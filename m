From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: TWL6040 fails to initialize
Date: Wed, 26 Feb 2014 09:26:39 +0200
Message-ID: <530D972F.805@ti.com>
References: <530C70B3.4010103@epfl.ch> <530CA8DA.8050806@ti.com> <530CB9C6.60806@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbaBZH1I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 02:27:08 -0500
In-Reply-To: <530CB9C6.60806@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>

On 02/25/2014 05:41 PM, Florian Vaussard wrote:
> If the power was not enabled at all, I would be unable to read the
> revision register, no? And delaying the probe by one millisecond woul=
d
> be of no help in this case IMHO.

One thing which might cause this is that if the audpwron GPIO is set hi=
gh
before the twl6040 module is probing. When I request the GPIO I ask it =
to be
set to low. If the line was high before this means we initiate the powe=
r off
sequence.
Can you try something like this:

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 75316fb33448..d2a0bd1539ae 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -674,6 +674,9 @@ static int twl6040_probe(struct i2c_client *client,
                                            GPIOF_OUT_INIT_LOW, "audpwr=
on");
                if (ret)
                        goto gpio_err;
+
+               /* power-down sequence latency */
+               usleep_range(500, 700);
        }

        ret =3D regmap_add_irq_chip(twl6040->regmap, twl6040->irq, IRQF=
_ONESHOT,


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
