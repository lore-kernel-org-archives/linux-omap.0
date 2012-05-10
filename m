From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] ARM: OMAP AM35xx: clock and hwmod data: fix AM35xx
 HSOTGUSB hwmod
Date: Thu, 10 May 2012 11:29:17 -0600
Message-ID: <20120510172913.13418.66154.stgit@dusk>
References: <20120510172449.13418.66815.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47638 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab2EJRdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 13:33:21 -0400
In-Reply-To: <20120510172449.13418.66815.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hema HK <hemahk@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Felipe Balbi <balbi@ti.com>

Partially fix the hwmod data for the AM35xx USB OTG hwmod.  This
should resolve the following boot warning on AM35xx platforms:

omap_hwmod: am35x_otg_hs: cannot be enabled for reset (3)

While here, also fix the clkdev records, to avoid warnings about
duplicate clock aliases.

The hwmod is also connected to the wrong interconnect.  It should be
connected to the IPSS, not the L4 CORE.  But that is left for a future
fix, since it probably has a dependency on some hwmod core changes.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Hema HK <hemahk@ti.com>
Cc: Mark A. Greer <mgreer@animalcreek.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 +++++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4e1a3b0..13102b9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3478,8 +3478,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("davinci_mdio.0",	NULL,	&emac_fck,	CK_AM35XX),
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
-	CLK("musb-am35x",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
-	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
+	CLK(NULL,	"hsotgusb_ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
+	CLK(NULL,	"hsotgusb_fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
 	CLK("omap_timer.1",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0c65079..678a3aa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1637,25 +1637,20 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 
 /* usb_otg_hs */
 static struct omap_hwmod_irq_info am35xx_usbhsotg_mpu_irqs[] = {
-
 	{ .name = "mc", .irq = 71 },
 	{ .irq = -1 }
 };
 
 static struct omap_hwmod_class am35xx_usbotg_class = {
 	.name = "am35xx_usbotg",
-	.sysc = NULL,
 };
 
 static struct omap_hwmod am35xx_usbhsotg_hwmod = {
 	.name		= "am35x_otg_hs",
 	.mpu_irqs	= am35xx_usbhsotg_mpu_irqs,
-	.main_clk	= NULL,
-	.prcm = {
-		.omap2 = {
-		},
-	},
+	.main_clk	= "hsotgusb_fck",
 	.class		= &am35xx_usbotg_class,
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* MMC/SD/SDIO common */
@@ -2046,9 +2041,10 @@ static struct omap_hwmod_ocp_if omap3xxx_usbhsotg__l3 = {
 static struct omap_hwmod_ocp_if am35xx_usbhsotg__l3 = {
 	.master		= &am35xx_usbhsotg_hwmod,
 	.slave		= &omap3xxx_l3_main_hwmod,
-	.clk		= "core_l3_ick",
+	.clk		= "hsotgusb_ick",
 	.user		= OCP_USER_MPU,
 };
+
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.master	= &omap3xxx_l4_core_hwmod,
@@ -2342,7 +2338,7 @@ static struct omap_hwmod_addr_space am35xx_usbhsotg_addrs[] = {
 static struct omap_hwmod_ocp_if am35xx_l4_core__usbhsotg = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_usbhsotg_hwmod,
-	.clk		= "l4_ick",
+	.clk		= "hsotgusb_ick",
 	.addr		= am35xx_usbhsotg_addrs,
 	.user		= OCP_USER_MPU,
 };


