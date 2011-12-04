From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v5 3/4] regulator: pass additional of_node to regulator_register()
Date: Sun, 4 Dec 2011 15:23:07 +0530
Message-ID: <CAJuYYwRa=AGZ+Chuj+v49EHE+bOuoCWxhmDUO35BoZK2g97FQg@mail.gmail.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
	<1321615040-13257-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45910 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1LDJxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Dec 2011 04:53:08 -0500
In-Reply-To: <1321615040-13257-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, robherring2@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linux-kernel@vger.kernel.org, shawn.guo@freescale.com, linaro-dev@lists.linaro.org, olof@lixom.net, Michael Hennerich <michael.hennerich@analog.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Wolfram Sang <w.sang@pengutronix.de>, Zeng Zhaoming <b32542@freescale.com>, Dan Carpenter <error27@gmail.com>

Hi Rajendra,

On 18 November 2011 16:47, Rajendra Nayak <rnayak@ti.com> wrote:
> With device tree support for regulators, its needed that the
> regulator_dev->dev device has the right of_node attached.
> To be able to do this add an additional parameter to the
> regulator_register() api, wherein the dt-adapted driver can
> then pass this additional info onto the regulator core.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Ian Lartey <ian@opensource.wolfsonmicro.com>
> Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Zeng Zhaoming <b32542@freescale.com>
> Cc: Dan Carpenter <error27@gmail.com>
> ---
> =A0drivers/regulator/88pm8607.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/aat2870-regulator.c =A0| =A0 =A02 +-
> =A0drivers/regulator/ab3100.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/ab8500.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/ad5398.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/bq24022.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 ++=
-
> =A0drivers/regulator/da903x.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/db8500-prcmu.c =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/dummy.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/fixed.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/isl6271a-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/lp3971.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/lp3972.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/max1586.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/max8649.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/max8660.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/max8925-regulator.c =A0| =A0 =A02 +-
> =A0drivers/regulator/max8952.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/max8997.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/max8998.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/mc13783-regulator.c =A0| =A0 =A02 +-
> =A0drivers/regulator/mc13892-regulator.c =A0| =A0 =A02 +-
> =A0drivers/regulator/pcap-regulator.c =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/pcf50633-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/tps6105x-regulator.c | =A0 =A03 ++-
> =A0drivers/regulator/tps65023-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/tps6507x-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/tps6524x-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/tps6586x-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/tps65910-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/tps65912-regulator.c | =A0 =A02 +-
> =A0drivers/regulator/twl-regulator.c =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/regulator/wm831x-dcdc.c =A0 =A0 =A0 =A0| =A0 =A08 ++++----
> =A0drivers/regulator/wm831x-isink.c =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/regulator/wm831x-ldo.c =A0 =A0 =A0 =A0 | =A0 =A06 +++---
> =A0drivers/regulator/wm8350-regulator.c =A0 | =A0 =A02 +-
> =A0drivers/regulator/wm8400-regulator.c =A0 | =A0 =A02 +-
> =A0drivers/regulator/wm8994-regulator.c =A0 | =A0 =A02 +-
> =A0include/linux/regulator/driver.h =A0 =A0 =A0 | =A0 =A02 +-
> =A0sound/soc/codecs/sgtl5000.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A041 files changed, 48 insertions(+), 46 deletions(-)

Documentation/power/regulator/regulator.txt would also require an
update the reflect the change in api.

Thanks,
Thomas.

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
