From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] ARM: omap3: Split the pinmux core device
Date: Wed, 4 Dec 2013 13:49:49 -0800
Message-ID: <20131204214949.GW26766@atomide.com>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <2098999.THrpfnVM6o@avalon>
 <20131204182437.GU26766@atomide.com>
 <3374611.sGfCARW7Hu@avalon>
 <20131204185341.GV26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21596 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753220Ab3LDVtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 16:49:52 -0500
Content-Disposition: inline
In-Reply-To: <20131204185341.GV26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, sakari.ailus@iki.fi

* Tony Lindgren <tony@atomide.com> [131204 10:54]:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131204 10:45]:
> > On Wednesday 04 December 2013 10:24:37 Tony Lindgren wrote:
> > > 
> > > OK. I wonder if we should add something like this to make it easier to
> > > use the padconf values from the TRM:
> > > 
> > > #define OMAP_IOPAD_OFFSET(pa, offset)	((pa) & 0xffff) - (offset))
> > > 
> > > #define OMAP2_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0030) (val))
> > > #define OMAP3_CORE1_IOPAD(pa, val)	OMAP2_CORE_IOPAD((pa), (val))
> > > #define OMAP3_CORE2_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x05a0) (val))
> > > #define OMAP4_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0040) (val))
> > > #define OMAP4_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xe040) (val))
> > > #define OMAP5_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0840) (val))
> > > #define OMAP5_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xc850) (val))
> > > ...
> > > 
> > > Then we would have entries like:
> > > 
> > > 	pinctrl-single,pins = <
> > > 		OMAP3_CORE1_IOPAD(0x158, PIN_INPUT_PULLUP | MUX_MODE0)
> > > 		...
> > > 	>;
> > > 
> > > instead of:
> > > 
> > > 	pinctrl-single,pins = <
> > > 		0x128 (PIN_INPUT_PULLUP | MUX_MODE0)
> > > 		...
> > > 	>;
> > 
> > That's a good idea, it would be much more readable. Would you like to submit a 
> > patch ? Should I rebase my patch on top of that, or the other way around ?
> 
> OK I'll do a patch for that later on today, then you can use that. Might
> cut down the churn a little that way.

Here's the patch for it, needs some checks and testing as I got several
things wrong in the example above :)

Regards,

Tony

8< ----------------------------

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 4 Dec 2013 13:03:58 -0800
Subject: [PATCH] ARM: dts: Add omap specific pinctrl defines to use padconf addresses

As we have one to three pinctrl-single instances for each SoC it is
a bit confusing to configure the padconf register offset from the
base of the padconf register base.

Let's add macros that allow using the physical address of the
padconf register directly, or in most cases, just the last 16-bits
of the address as they are shown in the documentation.

Note that most documentation shows two padconf registers for each
32-bit address, so adding 2 to the documentation address is needed for
the second padconf register as we treat them as 16-bit registers
for omap3+.

For example, omap36xx documentation shows sdmmc2_clk at 0x48002158,
so we can just use the last 16-bits of that value:

	pinctrl-single,pins = <
		OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)
		...
	>;

And we don't need to separately calculate the offset from the 0x2030
base:

	pinctrl-single,pins = <
		0x128 (PIN_INPUT_PULLUP | MUX_MODE0)
		...
	>;

Naturally both ways of defining the registers can be used, and I'm
not saying we should replace all the existing defines. But it may
be handy to use these macros for new entries and when doing other
related .dts file clean-up.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -49,5 +49,24 @@
 #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
 #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
 
+/*
+ * Macros to allow using the absolute physical address instead of the
+ * padconf registers instead of the offset from padconf base.
+ */
+#define OMAP_IOPAD_OFFSET(pa, offset)	((pa) & 0xffff) - (offset))
+
+#define OMAP2420_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0030) (val))
+#define OMAP2430_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x2030) (val))
+#define OMAP3_CORE1_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x2030) (val))
+#define OMAP3_CORE2_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x25a0) (val))
+#define OMAP3_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x2a00) (val))
+#define AM33XX_IOPAD(pa, val)		(OMAP_IOPAD_OFFSET((pa), 0x0800) (val))
+#define OMAP4_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0040) (val))
+#define OMAP4_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xe040) (val))
+#define AM4372_IOPAD(pa, val)		(OMAP_IOPAD_OFFSET((pa), 0x0800) (val))
+#define OMAP5_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x2840) (val))
+#define OMAP5_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xc840) (val))
+#define DRA7XX_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x3400) (val))
+
 #endif
 
