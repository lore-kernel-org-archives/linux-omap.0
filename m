From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/6 v8] AM35xx: hwmod data: Add USBOTG
Date: Thu, 17 Feb 2011 12:07:19 +0530
Message-ID: <1297924642-3791-4-git-send-email-hemahk@ti.com>
References: <1297924642-3791-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297924642-3791-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM35xx hwmod data structures are populated for USBOTG with base address,
L3 and L4 interface clocks and IRQ.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---

Index: linux-2.6/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ linux-2.6/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -28,6 +28,7 @@
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 #include "wd_timer.h"
+#include <mach/am35xx.h>
 
 /*
  * OMAP3xxx hardware module integration data
@@ -55,6 +56,8 @@ static struct omap_hwmod omap3xxx_gpio5_
 static struct omap_hwmod omap3xxx_gpio6_hwmod;
 static struct omap_hwmod omap34xx_sr1_hwmod;
 static struct omap_hwmod omap34xx_sr2_hwmod;
+static struct omap_hwmod am35xx_usbhsotg_hwmod;
+
 
 static struct omap_hwmod omap3xxx_dma_system_hwmod;
 
@@ -117,6 +120,13 @@ static struct omap_hwmod_ocp_if omap3xxx
 	.user		= OCP_USER_MPU,
 };
 
+/* l3_core -> am35xx_usbhsotg interface */
+static struct omap_hwmod_ocp_if am35xx_usbhsotg__l3 = {
+	.master		= &am35xx_usbhsotg_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.master	= &omap3xxx_l4_core_hwmod,
@@ -340,6 +350,31 @@ static struct omap_hwmod_ocp_if *omap3xx
 	&omap3xxx_l4_core__usbhsotg,
 };
 
+static struct omap_hwmod_addr_space am35xx_usbhsotg_addrs[] = {
+	{
+		.pa_start	= AM35XX_IPSS_USBOTGSS_BASE,
+		.pa_end		= AM35XX_IPSS_USBOTGSS_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> usbhsotg  */
+static struct omap_hwmod_ocp_if am35xx_l4_core__usbhsotg = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &am35xx_usbhsotg_hwmod,
+	.clk		= "l4_ick",
+	.addr		= am35xx_usbhsotg_addrs,
+	.addr_cnt	= ARRAY_SIZE(am35xx_usbhsotg_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if *am35xx_usbhsotg_masters[] = {
+	&am35xx_usbhsotg__l3,
+};
+
+static struct omap_hwmod_ocp_if *am35xx_usbhsotg_slaves[] = {
+	&am35xx_l4_core__usbhsotg,
+};
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -1452,6 +1487,33 @@ static struct omap_hwmod omap3xxx_usbhso
 				| HWMOD_SWSUP_MSTANDBY,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
+/* usb_otg_hs */
+static struct omap_hwmod_irq_info am35xx_usbhsotg_mpu_irqs[] = {
+
+	{ .name = "mc", .irq = 71 },
+};
+
+static struct omap_hwmod_class am35xx_usbotg_class = {
+	.name = "am35xx_usbotg",
+	.sysc = NULL,
+};
+
+static struct omap_hwmod am35xx_usbhsotg_hwmod = {
+	.name		= "am35x_otg_hs",
+	.mpu_irqs	= am35xx_usbhsotg_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(am35xx_usbhsotg_mpu_irqs),
+	.main_clk	= NULL,
+	.prcm = {
+		.omap2 = {
+		},
+	},
+	.masters	= am35xx_usbhsotg_masters,
+	.masters_cnt	= ARRAY_SIZE(am35xx_usbhsotg_masters),
+	.slaves		= am35xx_usbhsotg_slaves,
+	.slaves_cnt	= ARRAY_SIZE(am35xx_usbhsotg_slaves),
+	.class		= &am35xx_usbotg_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1)
+};
 
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
@@ -1488,6 +1550,9 @@ static __initdata struct omap_hwmod *oma
 	/* usbotg class */
 	&omap3xxx_usbhsotg_hwmod,
 
+	/* usbotg for am35x */
+	&am35xx_usbhsotg_hwmod,
+
 	NULL,
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
