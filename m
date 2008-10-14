From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 5/6] Add new register definitions for SDRAM controller
Date: Tue, 14 Oct 2008 15:23:30 +0300
Message-ID: <1223987011-25667-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-4-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33567 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbYJNKiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:38:09 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAc1LN006381
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:38:07 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjLx000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:52 +0300
In-Reply-To: <1223987011-25667-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Added SDRC_EMR2_* and SDRC_MANUAL_*

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/include/mach/sdrc.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index c66c838..a5a6cf9 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -31,14 +31,18 @@
 #define SDRC_POWER		0x070
 #define SDRC_MCFG_0		0x080
 #define SDRC_MR_0		0x084
+#define SDRC_EMR2_0		0x08c
 #define SDRC_ACTIM_CTRL_A_0	0x09c
 #define SDRC_ACTIM_CTRL_B_0	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
+#define SDRC_MANUAL_0		0x0a8
 #define SDRC_MCFG_1		0x0B0
 #define SDRC_MR_1		0x0B4
+#define SDRC_EMR2_1		0x0BC
 #define SDRC_ACTIM_CTRL_A_1	0x0C4
 #define SDRC_ACTIM_CTRL_B_1	0x0C8
 #define SDRC_RFR_CTRL_1		0x0D4
+#define SDRC_MANUAL_1		0x0D8
 
 /*
  * These values represent the number of memory clock cycles between
-- 
1.5.4.3

