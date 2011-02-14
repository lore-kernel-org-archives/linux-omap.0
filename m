From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Mon, 14 Feb 2011 15:48:42 +0200
Message-ID: <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
References: <1297691206.2951.8.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40715 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753364Ab1BNNsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 08:48:51 -0500
Received: by mail-bw0-f53.google.com with SMTP id 12so7739643bwg.40
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 05:48:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297691206.2951.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 14, 2011 at 03:46:46PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> I've been trying to get USB ethernet gadget driver working so that I can
> use NFS root to boot my board (overo or beagle).
> 
> With 2.6.37 I did get it work, but only after I enabled host mode and
> set the driver mode to OTG. With just USB peripheral mode it didn't seem
> to work.
> 
> With 2.6.38-rc4 I don't seem to get it working at all, not matter what
> config options I have tried.
> 
> And when I say "not working" I mean I don't get any output about USB
> when the kernel is waiting for the rootfs. Not even if I unplug and plug
> the USB cable. And the PC's kernel messages don't show anything when the
> board's kernel boots up.
> 
> I've attached the configs I have tried.

try this patch:

commit d5f42190e7cf11b20face63ee96f26c7d2067b63
Author: Ming Lei <tom.leiming@gmail.com>
Date:   Wed Jan 5 22:03:21 2011 +0800

    arm: omap4: panda: remove usb_nop_xceiv_register(v1)
    
    Panda uses both twl6030 otg phy(vbus, id) and internal
    phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
    twl6030 otg driver working since current otg code only supports
    one global transceiver. Otherwise, musb doesn't work without
    the remove.
    
    Reviewd-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Ming Lei <tom.leiming@gmail.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e001a04..e944025 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -409,8 +409,6 @@ static void __init omap4_panda_init(void)
        platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
        omap_serial_init();
        omap4_twl6030_hsmmc_init(mmc);
-       /* OMAP4 Panda uses internal transceiver so register nop transceiver */
-       usb_nop_xceiv_register();
        omap4_ehci_init();
        usb_musb_init(&musb_board_data);
 }

-- 
balbi
