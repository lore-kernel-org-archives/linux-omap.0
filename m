From: Samreen <samreen@ti.com>
Subject: [PATCH 0/2] OMAP3: Display Support
Date: Thu, 14 Oct 2010 16:57:07 +0530
Message-ID: <1287055629-25153-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58793 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab0JNLbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 07:31:52 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9EBVpHW000441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 06:31:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Samreen <samreen@ti.com>

This patch series adds the Display Support for OMAP3 platforms
and the corresponding changes in the board files.

Kishore Y (2):
  OMAP3: ZOOM2/3/3630SDP: Add display board file for OMAP3
  OMAP3: Enable display on ZOOM2/3/3630SDP

 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  165 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   49 +++++++-
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +
 7 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c

