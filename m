From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
Date: Wed, 8 May 2013 20:36:06 -0400
Message-ID: <20130509003606.GE31290@titan.lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
 <20130508194504.GD32546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63220 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752066Ab3EIAgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 20:36:12 -0400
Content-Disposition: inline
In-Reply-To: <20130508194504.GD32546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, May 08, 2013 at 12:45:04PM -0700, Tony Lindgren wrote:
> * Jason Cooper <jason@lakedaemon.net> [130508 12:29]:
> > 
> > Tony has been helping me out offline with this, and he suggested trying the
> > gpmc against Linus' ToT.  Which locks up before it even has a chance to get
> > going.  So this series is against v3.9.
> 
> You may have better luck with today's mainline treeand the following fix:
> 
> http://lkml.org/lkml/2013/5/8/374#

Ok, I'm attempting to do that, but got this for 'make dtbs':

ERROR (phandle_references): Reference to non-existent node or label "usb2_phy"

ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [arch/arm/boot/dts/omap3-wireless_plus.dtb] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [dtbs] Error 2

which was created by:

  ad871c10 ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards

It assumes the board has twl4030 (and then includes it).  Bootlogs from
the vendor provided kernel don't show a single message from twl4030, so
I've omitted it.

Assuming I did the correct thing by omitting the twl4030, I think the
correct answer is to declare the phy in the dts files, like so:

---->8-----

commit c369d84600bd85b35d83807ce7ba893cea116fb4
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Thu May 9 00:33:48 2013 +0000

    ARM: omap3: dts: don't assume boards are using twl4030
    
    If a board isn't using twl4030, then dtc will complain about the missing
    phandle (which is in twl4030.dtsi).  Move the phy declaration to the dts
    files.
    
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 5a31964..3046d1f 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -122,6 +122,7 @@
 
 &usb_otg_hs {
 	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 05f51e1..96d1c20 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -68,6 +68,7 @@
 
 &usb_otg_hs {
 	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index d4a7280..a626c50 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -73,6 +73,7 @@
 
 &usb_otg_hs {
 	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
 	mode = <3>;
 	power = <50>;
 };
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 4ad03d9..82a404d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -519,7 +519,6 @@
 			interrupts = <0 92 0x4>, <0 93 0x4>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
-			usb-phy = <&usb2_phy>;
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
