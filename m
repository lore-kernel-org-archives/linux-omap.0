From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
Date: Wed, 27 Jul 2011 11:50:32 +0530
Message-ID: <1311747632-26899-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48036 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab1G0GLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jul 2011 02:11:17 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6R6BGJI030982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 01:11:16 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6R6BGZn002413
	for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 01:11:16 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6R6BGmt024518
	for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 01:11:16 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The Latest
TRM mentions the correct fields in the register.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
index c88420d..8321add 100644
--- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
+++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
@@ -941,10 +941,10 @@
 #define OMAP4_DSI2_LANEENABLE_MASK				(0x7 << 29)
 #define OMAP4_DSI1_LANEENABLE_SHIFT				24
 #define OMAP4_DSI1_LANEENABLE_MASK				(0x1f << 24)
-#define OMAP4_DSI1_PIPD_SHIFT					19
-#define OMAP4_DSI1_PIPD_MASK					(0x1f << 19)
-#define OMAP4_DSI2_PIPD_SHIFT					14
-#define OMAP4_DSI2_PIPD_MASK					(0x1f << 14)
+#define OMAP4_DSI1_PIPD_SHIFT					14
+#define OMAP4_DSI1_PIPD_MASK					(0x1f << 14)
+#define OMAP4_DSI2_PIPD_SHIFT					19
+#define OMAP4_DSI2_PIPD_MASK					(0x1f << 19)
 
 /* CONTROL_MCBSPLP */
 #define OMAP4_ALBCTRLRX_FSX_SHIFT				31
-- 
1.7.1

