From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/6] omap: musb: Adding hwmod data for ti81xx
Date: Fri, 26 Aug 2011 16:41:43 +0530
Message-ID: <1314357108-2279-2-git-send-email-ajay.gupta@ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab1HZLL6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 07:11:58 -0400
In-Reply-To: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi B <ravibabu@ti.com>, Benoit Cousson <b-cousson@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Ravi B <ravibabu@ti.com>

The usb subsystem (usbss) in ti81xx has two musb interfaces. There are three
irqs and three address spaces for usbss, musb0 and musb1 respectively. Created
one hwmod with three irq and memory resources.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi B <ravibabu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |   74 ++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index e73a4c6..e960d70 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -194,6 +194,7 @@ static struct omap_hwmod ti81xx_timer4_hwmod;
 static struct omap_hwmod ti81xx_timer5_hwmod;
 static struct omap_hwmod ti81xx_timer6_hwmod;
 static struct omap_hwmod ti81xx_timer7_hwmod;
+static struct omap_hwmod ti81xx_usbss_hwmod;
 
 /* L4 SLOW -> TIMER1 interface */
 static struct omap_hwmod_addr_space ti81xx_timer1_addr_space[] = {
@@ -650,6 +651,78 @@ static struct omap_hwmod ti81xx_timer7_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X | CHIP_IS_TI814X)
 };
 
+/* L3 SLOW -> USBSS interface */
+static struct omap_hwmod_addr_space ti81xx_usbss_addr_space[] = {
+	{
+		.name		= "usbss",
+		.pa_start	= 0x47400000,
+		.pa_end		= 0x47400000 + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.name		= "musb0",
+		.pa_start	= 0x47401000,
+		.pa_end		= 0x47401000 + SZ_2K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.name		= "musb1",
+		.pa_start	= 0x47401800,
+		.pa_end		= 0x47401800 + SZ_2K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+	},
+};
+
+static struct omap_hwmod_class_sysconfig ti81xx_usbhsotg_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class ti81xx_usbotg_class = {
+	.name = "usbotg",
+	.sysc = &ti81xx_usbhsotg_sysc,
+};
+
+static struct omap_hwmod_irq_info ti81xx_usbss_mpu_irqs[] = {
+	{ .name = "usbss-irq", .irq = 17, },
+	{ .name = "musb0-irq", .irq = 18, },
+	{ .name = "musb1-irq", .irq = 19, },
+	{ .irq = -1, },
+};
+
+static struct omap_hwmod_ocp_if ti81xx_l3_slow__usbss = {
+	.master		= &ti81xx_l3_slow_hwmod,
+	.slave		= &ti81xx_usbss_hwmod,
+	.clk		= "usbotg_ick",
+	.addr		= ti81xx_usbss_addr_space,
+	.user		= OCP_USER_MPU,
+	.flags		= OCPIF_SWSUP_IDLE,
+};
+
+static struct omap_hwmod_ocp_if *ti81xx_usbss_slaves[] = {
+	&ti81xx_l3_slow__usbss,
+};
+
+static struct omap_hwmod ti81xx_usbss_hwmod = {
+	.name		= "usb_otg_hs",
+	.mpu_irqs	= ti81xx_usbss_mpu_irqs,
+	.main_clk	= "usbotg_ick",
+	.clkdm_name	= "default_usb_clkdm",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = TI816X_CM_DEFAULT_USB_CLKCTRL_OFFSET,
+		},
+	},
+	.slaves		= ti81xx_usbss_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti81xx_usbss_slaves),
+	.class		= &ti81xx_usbotg_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X | CHIP_IS_TI814X)
+};
 
 static __initdata struct omap_hwmod *ti81xx_hwmods[] = {
 	&ti81xx_l3_fast_hwmod,
@@ -668,6 +741,7 @@ static __initdata struct omap_hwmod *ti81xx_hwmods[] = {
 	&ti81xx_timer5_hwmod,
 	&ti81xx_timer6_hwmod,
 	&ti81xx_timer7_hwmod,
+	&ti81xx_usbss_hwmod,
 	NULL,
 };
 
-- 
1.6.2.4

