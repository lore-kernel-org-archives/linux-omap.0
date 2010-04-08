From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 09/19] DSPBRIDGE: trivial clock cleanup for unused code
Date: Thu,  8 Apr 2010 18:15:58 -0500
Message-ID: <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57284 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933799Ab0DHW7b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:31 -0400
In-Reply-To: <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unusued struct and typedef.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |    2 --
 drivers/dsp/bridge/services/clk.c          |    7 -------
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 0c16709..44f0f0e 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -19,8 +19,6 @@
 #ifndef _CLK_H
 #define _CLK_H
 
-	/* Generic TIMER object: */
-struct timer_object;
 enum dsp_clk_id {
 	DSP_CLK_GPT5_FCK,
 	DSP_CLK_GPT5_ICK,
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 094fe68..babf043 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -35,8 +35,6 @@
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 
-typedef volatile unsigned long reg_uword32;
-
 #define OMAP_SSI_OFFSET			0x58000
 #define OMAP_SSI_SIZE			0x1000
 #define OMAP_SSI_SYSCONFIG_OFFSET	0x10
@@ -80,11 +78,6 @@ static struct dsp_clk_t dsp_clks[] = {
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
1.6.2.4

