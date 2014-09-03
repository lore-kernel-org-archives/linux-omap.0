From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
Date: Wed, 3 Sep 2014 11:39:02 -0700
Message-ID: <20140903183901.GF11766@atomide.com>
References: <20140819152405.GA12002@atomide.com>
 <20140902082931.GA32460@breakpoint.cc>
 <20140903002445.GD11766@atomide.com>
 <5406D388.5050104@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbaICSjb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 14:39:31 -0400
Content-Disposition: inline
In-Reply-To: <5406D388.5050104@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Lee Jones <lee.jones@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140903 01:39]:
> On 09/03/2014 02:24 AM, Tony Lindgren wrote:
> 
> > dump out the twl configuration in late_initcall and via sysfs
> > so maybe try that and see what the values are with working
> > and non-working case?
> 
> good.txt and bad.txt are from the late_initcall.
> 
>  $ diff -u good.txt bad.txt
> --- good.txt    2014-09-03 10:29:58.920317368 +0200
> +++ bad.txt     2014-09-03 10:28:57.064313222 +0200

Hmm can you check that you have good.txt and bad.txt the
right way? I'd assume you need VAUX2 or VAUX3 enabled
not disabled for the MMC to work?

> @@ -1,13 +1,13 @@
>   1: addr: 0x0017 grp: 0x0000 type: 0x0000 remap: 0x0008
> - 2: addr: 0x001b grp: 0x0000 type: 0x0000 remap: 0x0008
> - 3: addr: 0x001f grp: 0x0000 type: 0x0000 remap: 0x0008
> + 2: addr: 0x001b grp: 0x002e type: 0x0000 remap: 0x0008
> + 3: addr: 0x001f grp: 0x002e type: 0x0000 remap: 0x0008

OK so looking at res_config_addrs[], we have RES_VAUX2 at
0x1b and RES_VAUX3 at 0x1f. The value for the group register
0x2e means that bit5 is set and it's used by the p1 device
group. So when the group register is 0x2e, the resource is
enabled. Those got most likely enabled by twl-regulator.c
as twl4030-power.c has TWL4030_RESCONFIG_UNDEF for VAUX2 and
VAUX3.

>   4: addr: 0x0023 grp: 0x0000 type: 0x0000 remap: 0x0008
>   5: addr: 0x0027 grp: 0x002e type: 0x0000 remap: 0x0008
>   6: addr: 0x002b grp: 0x0000 type: 0x0000 remap: 0x0008
>   7: addr: 0x002f grp: 0x002e type: 0x000b remap: 0x0000
>   8: addr: 0x0033 grp: 0x002e type: 0x0000 remap: 0x0008
>   9: addr: 0x0037 grp: 0x002e type: 0x0000 remap: 0x0008
> -10: addr: 0x003b grp: 0x0000 type: 0x0000 remap: 0x0008
> +10: addr: 0x003b grp: 0x002e type: 0x0000 remap: 0x0008

And that's RES_VDAC at 0x3b with the same story, it's also
marked TWL4030_RESCONFIG_UNDEF and only modified by the
twl4030-power.c.

I think the use on beaglboard for these are:

VAUX2	USB_1V8
VAUX3	CAM_CORE
VDAC	VDAC_1V8

Not quite seeing the connection.. But I'm assuming you have
good.txt and bad.txt the wrong way around, and you need
VAUX2, VAUX3 or VDAC _enabled_ to get MMC working :)

So this seems to hint we have issue in one of these:

1. We are not claiming VAUX2, VAUX3 or VDAC for beagleboard,
   and there's now a timing issue where the regulator
   framework disables the unused regulators before MMC.

2. We may have a bug that causes register access to
   DEV_GRP_OFFSET in twl4030-power.c even with those
   resources marked as TWL4030_RESCONFIG_UNDEF.

3. There's a I2C race somewhere accessing twl registers.

Guessing #1 above, maybe give the following patch a try
and see if that helps? If that works, try commenting out
vaux3 or vdac and see which one is needed. I'm guessing
it's the vdac.

Regards,

Tony

--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -331,6 +331,18 @@
 	regulator-always-on;
 };
 
+&vaux3 {
+	regulator-name = "cam_core";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
+
+&vdac {
+	regulator-name = "vdac_1v8";
+	regulator-always-on;
+};
+
 &mcbsp2 {
 	status = "okay";
 };
