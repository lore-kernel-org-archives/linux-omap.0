From: shubhrajyoti@ti.com
Subject: [PATCH v8 1/3] OMAP4: hwmod data: Add keypad in the hwmod database
Date: Mon, 27 Dec 2010 11:21:44 +0530
Message-ID: <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Abraham Arce <x0066660@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Benoit Cousson <b-cousson@ti.com>

Add hwmod data for OMAP4 keyboard controller
taking Benoit's patch:

 OMAP4: hwmod: Add partial hwmod support for OMAP4430

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70 ++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f9778fb..a0c6c39 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -657,6 +657,73 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
 };
 
 /*
+ * 'kbd' class
+ * keyboard controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_kbd_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_kbd_hwmod_class = {
+	.name = "kbd",
+	.sysc = &omap44xx_kbd_sysc,
+};
+
+/* kbd */
+static struct omap_hwmod omap44xx_kbd_hwmod;
+static struct omap_hwmod_irq_info omap44xx_kbd_irqs[] = {
+	{ .irq = 120 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_kbd_addrs[] = {
+	{
+		.pa_start	= 0x4a31c000,
+		.pa_end		= 0x4a31c07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> kbd */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__kbd = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_kbd_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_kbd_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_kbd_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* kbd slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_kbd_slaves[] = {
+	&omap44xx_l4_wkup__kbd,
+};
+
+static struct omap_hwmod omap44xx_kbd_hwmod = {
+	.name		= "kbd",
+	.class		= &omap44xx_kbd_hwmod_class,
+	.mpu_irqs	= omap44xx_kbd_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_kbd_irqs),
+	.main_clk	= "kbd_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_kbd_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_kbd_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+
+/*
  * 'mpu' class
  * mpu sub-system
  */
@@ -1509,6 +1576,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_gpio5_hwmod,
 	&omap44xx_gpio6_hwmod,
 
+	/* kbd class */
+	&omap44xx_kbd_hwmod,
+
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 	/* wd_timer class */
-- 
1.7.0.4

