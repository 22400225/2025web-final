package com.handong.web.room.controller;

import com.handong.web.room.service.RoomService;
import com.handong.web.room.service.UserService;
import com.handong.web.room.vo.RoomVO;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoomService roomService;

    // 관리자 권한 체크 메서드
    private boolean isAdmin(HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        return loginUser != null && "ADMIN".equals(loginUser.getRole());
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // 1. 관리자 아니면 쫓아내기
        if (!isAdmin(session)) {
            return "redirect:/";
        }

        // 2. 데이터 가져오기
        List<UserVO> userList = userService.getAllUsers();
        List<RoomVO> roomList = roomService.getRoomList(); // 기존 메서드 활용
        int totalRooms = roomService.countRooms();
        int totalUsers = userList.size();

        // 3. 화면에 전달
        model.addAttribute("userList", userList);
        model.addAttribute("roomList", roomList);
        model.addAttribute("totalRooms", totalRooms);
        model.addAttribute("totalUsers", totalUsers);

        return "admin/dashboard";
    }

    // 회원 강제 추방
    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("id") int userNo, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        userService.deleteUser(userNo);
        return "redirect:/admin/dashboard";
    }

    // 게시물 강제 삭제
    @GetMapping("/room/delete")
    public String deleteRoom(@RequestParam("id") int roomNo, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        roomService.removeRoom(roomNo);
        return "redirect:/admin/dashboard";
    }
}