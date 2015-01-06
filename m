From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 08:59:03 -0800
Message-ID: <20150106165903.GF4025@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50674 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754342AbbAFRCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 12:02:52 -0500
Content-Disposition: inline
In-Reply-To: <20150106080025.GA6752@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

* Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > dependency is removed". We've now fixed the issues that
> > caused problems with uninitialized hardware depending on
> > the bootloader version. Mostly things got fixed with
> > the following commits:
> > 
> > 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> > 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> > 
> > Note that this only affects the early development boards
> > with Ethernet that we still have in a few automated boot
> > test systems.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Normally, the early development boards should have separate dts file
> (then include common parts), no?

In this case it won't matter. The GPMC hardware is there, the probe
just fails if no smsc91x is found.
 
> Could you at least add a note to the dts file what is it? Because I
> always thought it is a bug.

Sure, updated patch below. Can somebody please test boot it on
a production n900 too to make sure it no longer causes issues?
 
> [Plus of course, obviouse question is: where can I get one of those
> boards? :-)]

Another planet a long time ago :)

Regards,

Tony

8< ----------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 6 Jan 2015 08:49:57 -0800
Subject: [PATCH] ARM: dts: Revert disabling of smc91x for n900

Revert "ARM: dts: Disable smc91x on n900 until bootloader
dependency is removed". We've now fixed the issues that
caused problems with uninitialized hardware depending on
the bootloader version. Mostly things got fixed with
the following commits:

9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")

Note that this only affects the early development boards
with Ethernet that we still have in a few automated boot
test systems. And it's also available supposedly in some
versions of qemu.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -700,11 +700,9 @@
 		};
 	};
 
+	/* Ethernet is on some early development boards and qemu */
 	ethernet@gpmc {
 		compatible = "smsc,lan91c94";
-
-		status = "disabled";
-
 		interrupt-parent = <&gpio2>;
 		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
 		reg = <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
