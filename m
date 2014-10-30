From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] ARM: dts: Fix bootloader version dependencies by
 muxing n900 smc91x pins
Date: Thu, 30 Oct 2014 08:49:55 -0700
Message-ID: <20141030154952.GF2560@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-2-git-send-email-tony@atomide.com>
 <54522829.6060406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21799 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbaJ3PvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2014 11:51:08 -0400
Content-Disposition: inline
In-Reply-To: <54522829.6060406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>

* Roger Quadros <rogerq@ti.com> [141030 05:01]:
> On 10/30/2014 02:28 AM, Tony Lindgren wrote:
> > +
> > +			/*
> > +			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
> > +			 * according to TRM. REVISIT: why does nolo set input for gpmc_clk?
> > +			 */
> > +                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
> > +                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
> 
> Right about the comment. GPMC_CLK should feed the CLK input of the OneNAND.
> This needs to be an OUTPUT pin.
> 
> Does OneNAND work when this pin is configured as output?

Does not seem to work, it produces onenand_wait: ECC error = 0xffff.

It seems the clock needs to be copied to GPMC too in some cases.
For MMC, there's the MMCSDIO2ADPCLKISEL option to copy the clock to
account for level shifter latencies [1]. But in the OneNAND case I
don't think there are any level shifters, and I don't think we have
"copy clock" option for GPMC either in SCM so it somehow is automatic
in GPMC.

Anyways, updated patch below with wrong guessing removed.

Regards,

Tony

[1] http://processors.wiki.ti.com/index.php/SD-MMC_Usage_Notes_on_OMAP35x_and_AM37x


8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 29 Oct 2014 17:16:47 -0700
Subject: [PATCH] ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins

Apparently some versions of nolo don't mux the all the necessary GPMC
pins for the smc91x probe to work properly. Let's fix this issue
by adding mux support for GPMC to the kernel.

Note that GPMC clk needs input enabled for OnenNAND to work.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -142,6 +142,33 @@
 		>;
 	};
 
+	gpmc_pins: pinmux_gpmc_pins {
+		pinctrl-single,pins = <
+
+			/* address lines */
+                        OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
+                        OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
+                        OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
+
+			/* data lines, gpmc_d0..d7 not muxable according to TRM */
+                        OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
+                        OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
+                        OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
+                        OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
+                        OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
+                        OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
+                        OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
+                        OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
+
+			/*
+			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
+			 * according to TRM. OneNAND seems to require PIN_INPUT on clock.
+			 */
+                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
+                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+		>;
+	};
+
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			0x18a (PIN_INPUT | MUX_MODE0)		/* i2c1_scl */
@@ -588,6 +615,8 @@
 	ranges = <0 0 0x04000000 0x10000000>; /* 256MB */
 	ranges = <0 0 0x01000000 0x01000000>,	/* 16 MB for OneNAND */
 		 <1 0 0x02000000 0x01000000>;	/* 16 MB for smc91c96 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmc_pins>;
 
 	/* gpio-irq for dma: 65 */
 
