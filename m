From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Fix MUSB ifdefs for platform init code
Date: Wed, 13 Jun 2012 03:15:06 -0700
Message-ID: <20120613101506.18645.98406.stgit@muffinssi.local>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27175 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab2FMKPL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 06:15:11 -0400
In-Reply-To: <20120613101303.18645.83320.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Commit 62285963 (usb: musb: drop a gigantic amount of ifdeferry)
got rid of a bunch of ifdefs in the MUSB code. Looks like the
platform init code is still using these dropped defines though,
which in many cases results the board defaulting always to host
mode.

Currently the situation is that USB_MUSB_HDRC is the main
Kconfig option with additional USB_GADGET_MUSB_HDRC so only
these two should be used to select between host and OTG mode.

Fix the situation for omaps. The following users should fix the
platform init code in a similar way:

Dropped Kconfig option          Current users

USB_MUSB_OTG                    blackfin, davinci, not in Kconfigs
USB_MUSB_PERIPHERAL             davinci, not in Kconfigs
USB_MUSB_HOST                   davinci, not in Kconfigs
USB_MUSB_HDRC_HCD               blackfin, not in Kconfigs
USB_MUSB_OTG                    blackfin, not in Kconfigs

Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c        |    6 ++----
 arch/arm/mach-omap2/omap_phy_internal.c |    6 ------
 arch/arm/mach-omap2/usb-musb.c          |    6 ++----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 1b582c6..b3e1afe 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -86,11 +86,9 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data tusb_data = {
-#if defined(CONFIG_USB_MUSB_OTG)
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	.mode		= MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_PERIPHERAL)
-	.mode		= MUSB_PERIPHERAL,
-#else /* defined(CONFIG_USB_MUSB_HOST) */
+#else
 	.mode		= MUSB_HOST,
 #endif
 	.set_power	= tusb_set_power,
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 4c90477..d52651a 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -239,21 +239,15 @@ void am35x_set_mode(u8 musb_mode)
 
 	devconf2 &= ~CONF2_OTGMODE;
 	switch (musb_mode) {
-#ifdef	CONFIG_USB_MUSB_HDRC_HCD
 	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
 		devconf2 |= CONF2_FORCE_HOST;
 		break;
-#endif
-#ifdef	CONFIG_USB_GADGET_MUSB_HDRC
 	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
 		devconf2 |= CONF2_FORCE_DEVICE;
 		break;
-#endif
-#ifdef	CONFIG_USB_MUSB_OTG
 	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
 		devconf2 |= CONF2_NO_OVERRIDE;
 		break;
-#endif
 	default:
 		pr_info(KERN_INFO "Unsupported mode %u\n", musb_mode);
 	}
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index b19d1b4..c4a5768 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -41,12 +41,10 @@ static struct musb_hdrc_config musb_config = {
 };
 
 static struct musb_hdrc_platform_data musb_plat = {
-#ifdef CONFIG_USB_MUSB_OTG
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	.mode		= MUSB_OTG,
-#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+#else
 	.mode		= MUSB_HOST,
-#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
-	.mode		= MUSB_PERIPHERAL,
 #endif
 	/* .clock is set dynamically */
 	.config		= &musb_config,

