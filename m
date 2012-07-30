From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: New build warnings
Date: Mon, 30 Jul 2012 17:44:44 +0100
Message-ID: <20120730164444.GO6802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51945 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab2G3Qos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 12:44:48 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

Okay, so last night's build run shows some new warnings...

drivers/regulator/twl-regulator.c: In function 'twlreg_probe':
drivers/regulator/twl-regulator.c:1151: warning: assignment discards qu=
alifiers from pointer target type
drivers/regulator/twl-regulator.c:1160: warning: assignment discards qu=
alifiers from pointer target type

These two look like missing const - looks like they were introduced by:

commit 98d7bbb9929bcc14e11ac8a55245a4f2dc174e17
Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Date:   Thu Jun 7 12:20:14 2012 +0200

    of: add const to struct *of_device_id.data

    Drivers should never need to modify the data of a device id. So it =
can
    be const which in turn allows more consts in the driver.

    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>




drivers/regulator/twl-regulator.c: At top level:
drivers/regulator/twl-regulator.c:1051: warning: 'TWLRES_INFO_CLK32KG' =
defined but not used

This one looks like it was caused by:

commit 0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Mon Jun 4 17:23:13 2012 +0100

    regulator: twl: Remove references to 32kHz clock from DT bindings

    Due to the lack of a generic clock API we'd had the 32kHz clock in =
the
    regulator driver but this is definitely a Linux-specific thing and =
now
    we have a clock API hopefully the code can be moved elsewhere. Try =
to
    avoid getting DTs deployed relying on the 32kHz clock by removing i=
t
    from the bindings, grep seems to tell me it's not currently used an=
yway.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

which removes:

-#define TWLRES_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLRES, label)
-       TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),

but completely forgets that this:

TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);

defines a structure that it was using.  (Welcome to why macros are horr=
id
when they hide the names of stuff they create.)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
