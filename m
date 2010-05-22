From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: usb_nop_xceiv_register() missing when OTG built as modules
Date: Sun, 23 May 2010 02:53:10 +0300
Message-ID: <20100522235310.GA15859@matterhorn.lan>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com>
 <20100305090426.GG12757@nokia.com>
 <871vfy3azr.fsf@deeprootsystems.com>
 <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
 <87y6i6zatj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51583 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab0EVXwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 19:52:53 -0400
Received: by fxm5 with SMTP id 5so1685118fxm.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 16:52:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y6i6zatj.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 10 Mar 05, Kevin Hilman wrote:
> <me@felipebalbi.com> writes:
> 
> > On Fri, 05 Mar 2010 09:59:52 -0800, Kevin Hilman
> >> It would be my fault if I wrote those board files.  ;)
> >
> > sure, sorry. Maybe I didn't express myself really well.
> >
> >>> I suggest you keep usb as a module, but keep nop xceiv built-in.
> >> 
> >> Yes, that's the workaround I'm already using, but it is not a fix.
> >> 
> >> This dependency breaks the ability to build a minimal kernel with
> >> everything as modules (allmodconfig)
> >
> > now this is a really good point. Haven't thought that way...
> >
> >> The nop xceiv needs a way for built-in code to register itself for
> >> the cases when no xceiv is built as a module.
> >
> > when way to do that is not to use usb_nop_xceiv_register() and
> > add the platform_device to the board-files. I never really liked
> > the whole usb_nop_xceiv_register() hackery. Almost all board-files
> > have a list of platform_devices which get added by platform_add_devices()
> > anyways, so why not using that ??
> >
> > to me the usb_nop_xceiv_register() thing is just a lazy way of
> > defining platform_devices. Specially one that takes some 3
> > lines of code only.
> 
> Completely agree.  I didn't take the time to look into the USB code to
> see if a simple plaform device creation would fix this.
> 
> If so, any chance of a patch for OMAP3EVM and 4430SDP?
> 
> I'll be happy to test on OMAP3EVM, but don't have a 4430.
> 
> Kevin

Here is a compile-tested patch since I haven't seen this fixed in mainline
yet.  It applies to the tip of Linus' tree.

Attempting to remove usb_nop_xceiv_register() completely will require someone
with more knowledge of davinci and blackfin archs to comment on what boards
need the platform_device defined.

Cheers,
Amit


--envbJBWh7q8WU6mo
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-omap-remove-calls-to-usb_nop_xceiv_register-from-boa.patch"

>From 3df714f995b0895e905090760482194233f66a1d Mon Sep 17 00:00:00 2001
Message-Id: <3df714f995b0895e905090760482194233f66a1d.1274570700.git.amit.kucheria@canonical.com>
From: Amit Kucheria <amit.kucheria@canonical.com>
Date: Sun, 23 May 2010 01:35:00 +0300
Subject: [PATCH] omap: remove calls to usb_nop_xceiv_register from board files

This will allow the OMAP USB drivers to be compiled in as modules. At the
moment, CONFIG_NOP_USB_XCEIV cannot be a module.

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/mach-omap2/board-4430sdp.c  |   10 ++++++++--
 arch/arm/mach-omap2/board-omap3evm.c |   11 ++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..131f0fd 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -110,8 +110,16 @@ static struct platform_device sdp4430_lcd_device = {
 	.id		= -1,
 };
 
+static struct platform_device sdp4430_nop_usb_device = {
+	.name		= "nop_usb_xceiv",
+	.id		= -1,
+	.resource	= NULL,
+	.num_resources	= 0,
+};
+
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_nop_usb_device,
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
@@ -374,8 +382,6 @@ static void __init omap_4430sdp_init(void)
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
-	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 81bba19..456e218 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -620,6 +620,13 @@ struct spi_board_info omap3evm_spi_board_info[] = {
 	},
 };
 
+static struct platform_device omap3_evm_nop_usb_device = {
+	.name		= "nop_usb_xceiv",
+	.id		= -1,
+	.resource	= NULL,
+	.num_resources	= 0,
+};
+
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 };
 
@@ -634,6 +641,7 @@ static void __init omap3_evm_init_irq(void)
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_dss_device,
+	&omap3_evm_nop_usb_device,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
@@ -682,9 +690,6 @@ static void __init omap3_evm_init(void)
 
 	omap_serial_init();
 
-	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
-	usb_nop_xceiv_register();
-
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
 		omap_mux_init_gpio(22, OMAP_PIN_INPUT_PULLUP);
-- 
1.7.0.4


--envbJBWh7q8WU6mo--
