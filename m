From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: change offset of RSTCTRL and RSTST register to
 the correct value.
Date: Wed, 17 Jun 2009 20:33:05 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60297E9F2D9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbZFRBdK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 21:33:10 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5I1X7u6004934
	for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 20:33:12 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5I1X7q2018992
	for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 20:33:07 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5I1X754008506
	for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 20:33:07 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 35acd0141fdaeb9a7b3214de34442a4948275ffb Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 15 Jun 2009 16:14:23 -0500
Subject: [PATCH] DSPBRIDGE: change offset of RSTCTRL and RSTST register to the correct value.

This patch changes the defines of the offset for RM_RSTCTRL_IVA2 and
RM_RSTCTRL_IVA2 to the value according with the TRM.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/hw/PRCMAccInt.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/hw/PRCMAccInt.h b/drivers/dsp/bridge/hw/PRCMAccInt.h
index 42baa68..5a11f01 100644
--- a/drivers/dsp/bridge/hw/PRCMAccInt.h
+++ b/drivers/dsp/bridge/hw/PRCMAccInt.h
@@ -117,8 +117,8 @@
 #define PRCM_CM_AUTOIDLE_DSP_OFFSET          (u32)(0x830)
 #define PRCM_CM_CLKSEL_DSP_OFFSET            (u32)(0x840)
 #define PRCM_CM_CLKSTCTRL_DSP_OFFSET         (u32)(0x848)
-#define PRCM_RM_RSTCTRL_DSP_OFFSET           (u32)(0x850)
-#define PRCM_RM_RSTST_DSP_OFFSET             (u32)(0x858)
+#define PRCM_RM_RSTCTRL_DSP_OFFSET           (u32)(0x050)
+#define PRCM_RM_RSTST_DSP_OFFSET             (u32)(0x058)
 #define PRCM_PM_PWSTCTRL_DSP_OFFSET          (u32)(0x8e0)
 #define PRCM_PM_PWSTST_DSP_OFFSET            (u32)(0x8e4)
 #define PRCM_PM_PWSTST_IVA2_OFFSET            (u32)(0xE4)
-- 
1.5.6.4
