From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: trivial clock cleanup for unused code
Date: Tue, 27 Apr 2010 20:29:16 -0500
Message-ID: <1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-2-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-3-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
 <1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41685 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0D1BYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 21:24:32 -0400
In-Reply-To: <1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unusued struct and typedef.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |    2 --
 drivers/dsp/bridge/services/clk.c          |    7 -------
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 621d08f..f19d024 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -19,8 +19,6 @@
 #ifndef _CLK_H
 #define _CLK_H
 
-	/* Generic TIMER object: */
-struct timer_object;
 enum dsp_clk_id {
 	DSP_CLK_IVA2_CK = 0,
 	DSP_CLK_GPT5_FCK,
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index e447d54..e35b929 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -32,8 +32,6 @@
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 
-typedef volatile unsigned long reg_uword32;
-
 #define OMAP_SSI_OFFSET			0x58000
 #define OMAP_SSI_SIZE			0x1000
 #define OMAP_SSI_SYSCONFIG_OFFSET	0x10
@@ -78,11 +76,6 @@ static struct dsp_clk_t dsp_clks[] = {
 	{NULL, ""}
 };
 
-/* Generic TIMER object: */
-struct timer_object {
-	struct timer_list timer;
-};
-
 /*
  *  ======== dsp_clk_exit ========
  *  Purpose:
-- 
1.6.0.4

