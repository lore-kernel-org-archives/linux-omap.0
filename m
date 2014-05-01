From: Leigh Brown <leigh@solinno.co.uk>
Subject: USB on Beaglebone black with mainline kernel
Date: Thu, 01 May 2014 18:32:01 +0100
Message-ID: <2041f22864c5524e6ff51c86487d7c86@doppler.thel33t.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from doppler.thel33t.co.uk ([193.110.88.198]:46244 "EHLO
	doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaEARSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 May 2014 13:18:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

Hello,

I'm trying to run the mainline kernel on my Beaglebone Black and things 
are working quite well, apart from USB.  There have been a few patches 
recently that have improved things, but right now I'm at the point where 
I could do with a pointer in the right direction.

The main issue now is this :-

usb 2-1: new high-speed USB device number 2 using musb-hdrc
musb-hdrc musb-hdrc.1.auto: qh dc059c80 urb dc059b00 dev0 ep0out, hw_ep 
0, dc2c5040/8
musb-hdrc musb-hdrc.1.auto: --> hw0 urb dc059b00 spd3 dev0 ep0out 
h_addr00 h_port00 bytes 8
musb-hdrc musb-hdrc.1.auto: TX ep0 fifo e0eb2e00 count 8 buf dc2c5040
musb-hdrc musb-hdrc.1.auto: Start TX0 pio
musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(1)
musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0001 rx0000
musb-hdrc musb-hdrc.1.auto: <== csr0 0010, qh dc059c80, count 0, urb 
dc059b00, stage 1
musb-hdrc musb-hdrc.1.auto: no response, csr0 0010
musb-hdrc musb-hdrc.1.auto: aborting
musb-hdrc musb-hdrc.1.auto: complete dc059b00 
usb_api_blocking_completion+0x0/0x14 [usbcore] (-71), dev0 ep0in, 0/64

and my usb stick is not detected.  The usb stick is detected fine with 
the
linux-3.8.13-bone43-201405011132 kernel.

Complete dmesg and other interesting files are here (I've used #define 
DEBUG 1 on relevant files) :-

http://www.solinno.co.uk/public/bbb/linux-3.15.0-rc3+-201405011446/

Same stuff for working kernel :-

http://www.solinno.co.uk/public/bbb/linux-3.8.13-bone43-201405011132/

I'd really appreciate any assistance - does anyone have a working config 
for a recent mainline kernel?

Thanks,

Leigh.

Addendum - I've been tinkering without really knowing what I'm doing, 
but nothing has helped so far.

I've tried is adding clock details into the am33xx.dtsi for the USB phys 
:-

diff --git a/arch/arm/boot/dts/am33xx.dtsi 
b/arch/arm/boot/dts/am33xx.dtsi
index cb6811e..027d7fb 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -467,6 +467,8 @@
                                 reg-names = "phy";
                                 status = "disabled";
                                 ti,ctrl_mod = <&usb_ctrl_mod>;
+                               clocks = <&usbotg_fck 0>;
+                               clock-names = "main_clk";
                         };

                         usb0: usb@47401000 {
@@ -515,6 +517,8 @@
                                 reg-names = "phy";
                                 status = "disabled";
                                 ti,ctrl_mod = <&usb_ctrl_mod>;
+                               clocks = <&usbotg_fck 0>;
+                               clock-names = "main_clk";
                         };

                         usb1: usb@47401800 {

However it didn't seem to help.  I also tried to force phy detection 
using usb_bind_phy() :-

diff --git a/arch/arm/mach-omap2/board-generic.c 
b/arch/arm/mach-omap2/board-gen
index b8920b6..7218515 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,6 +15,7 @@
  #include <linux/of_irq.h>
  #include <linux/of_platform.h>
  #include <linux/irqdomain.h>
+#include <linux/usb/phy.h>

  #include <asm/mach/arch.h>

@@ -40,6 +41,12 @@ static void __init omap_generic_init(void)
         pdata_quirks_init(omap_dt_match_table);

         omapdss_init_of();
+
+       if (of_machine_is_compatible("ti,am33xx")) {
+               pr_info("horrible hack: adding usb bindings for 
am335x\n");
+               usb_bind_phy("musb-hdrc.0.auto", 0, "47401300.usb-phy");
+               usb_bind_phy("musb-hdrc.1.auto", 0, "47401b00.usb-phy");
+       }
  }

  #ifdef CONFIG_SOC_OMAP2420

This hasn't helped either.
