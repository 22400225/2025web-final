<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<style>
    /* 대시보드 전용 스타일 */
    .stat-card {
        background: white;
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.03);
        height: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .stat-icon {
        width: 60px; height: 60px;
        background: #F2F4F6;
        border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        color: var(--primary);
        font-size: 1.8rem;
    }
    .table-custom th { background-color: #F9FAFB; border-bottom: none; color: #8B95A1; font-weight: 600; padding: 15px; }
    .table-custom td { padding: 15px; vertical-align: middle; border-bottom: 1px solid #f1f3f5; }
    .table-custom tr:last-child td { border-bottom: none; }
</style>

<div class="row g-4">
    <div class="col-lg-3">
        <div class="custom-card p-4 h-100">
            <h4 class="fw-bold mb-4 ps-2">관리자 메뉴</h4>
            <div class="list-group list-group-flush">
                <a href="#" class="list-group-item list-group-item-action border-0 rounded-3 active fw-bold mb-2">
                    <i class="bi bi-grid-fill me-2"></i> 대시보드
                </a>
                <a href="/" class="list-group-item list-group-item-action border-0 rounded-3 text-muted">
                    <i class="bi bi-house-door me-2"></i> 메인으로 돌아가기
                </a>
            </div>


        </div>
    </div>

    <div class="col-lg-9">

        <div class="row g-4 mb-4">
            <div class="col-md-6">
                <div class="stat-card">
                    <div>
                        <p class="text-muted mb-1 fw-bold">총 회원 수</p>
                        <h2 class="fw-bold mb-0">${totalUsers}명</h2>
                    </div>
                    <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="stat-card">
                    <div>
                        <p class="text-muted mb-1 fw-bold">등록된 매물</p>
                        <h2 class="fw-bold mb-0">${totalRooms}개</h2>
                    </div>
                    <div class="stat-icon"><i class="bi bi-house-check-fill"></i></div>
                </div>
            </div>
        </div>

        <ul class="nav nav-pills mb-3 gap-2" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active rounded-pill fw-bold" id="pills-users-tab" data-bs-toggle="pill" data-bs-target="#pills-users" type="button">회원 관리</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link rounded-pill fw-bold bg-white text-secondary border" id="pills-rooms-tab" data-bs-toggle="pill" data-bs-target="#pills-rooms" type="button">매물 관리</button>
            </li>
        </ul>

        <div class="tab-content custom-card p-0 overflow-hidden" id="pills-tabContent">

            <div class="tab-pane fade show active" id="pills-users">
                <div class="p-4 border-bottom"><h5 class="fw-bold mb-0">가입된 회원 목록</h5></div>
                <div class="table-responsive">
                    <table class="table table-custom mb-0 w-100">
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>이름</th>
                            <th>학번(ID)</th>
                            <th>권한</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.userNo}</td>
                                <td class="fw-bold">${user.name}</td>
                                <td>${user.studentId}</td>
                                <td>
                                        <span class="badge ${user.role == 'ADMIN' ? 'bg-primary' : 'bg-light text-secondary'} rounded-pill">
                                                ${user.role}
                                        </span>
                                </td>
                                <td>
                                    <c:if test="${user.role != 'ADMIN'}">
                                        <a href="/admin/user/delete?id=${user.userNo}" onclick="return confirm('이 회원을 추방하시겠습니까?')" class="btn btn-sm btn-outline-danger rounded-pill fw-bold">추방</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="tab-pane fade" id="pills-rooms">
                <div class="p-4 border-bottom"><h5 class="fw-bold mb-0">등록된 매물 목록</h5></div>
                <div class="table-responsive">
                    <table class="table table-custom mb-0 w-100">
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>가격</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="room" items="${roomList}">
                            <tr>
                                <td>${room.roomNo}</td>
                                <td>
                                    <a href="/room/detail?id=${room.roomNo}" class="text-decoration-none text-dark fw-bold">
                                            ${room.title}
                                    </a>
                                </td>
                                <td>${room.writerName}</td>
                                <td>${room.price}원</td>
                                <td>
                                    <a href="/admin/room/delete?id=${room.roomNo}" onclick="return confirm('이 매물을 강제 삭제하시겠습니까?')" class="btn btn-sm btn-outline-danger rounded-pill fw-bold">삭제</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>