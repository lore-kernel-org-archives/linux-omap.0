From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
Date: Wed, 9 May 2012 09:36:49 -0700
Message-ID: <20120509163649.GN5088@atomide.com>
References: <87zk9ijp86.fsf@ti.com>
 <1336531746-29027-1-git-send-email-Russ.Dill@ti.com>
 <20120509155555.GL5088@atomide.com>
 <CA+Bv8XZ4FYu+djvOMxhr6MbP8QYn4OL1PTc6TDJt42CpiESYDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52247 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760133Ab2EIQgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 12:36:52 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XZ4FYu+djvOMxhr6MbP8QYn4OL1PTc6TDJt42CpiESYDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, chase.maupin@ti.com, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Russ Dill <Russ.Dill@ti.com> [120509 09:29]:
> On Wed, May 9, 2012 at 8:55 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > Hi Tomi,
> >
> > * Russ Dill <Russ.Dill@ti.com> [120508 19:52]:
> >> This removes several boot warnings from board-omap3beagle.c:
> >>
> >> =C2=A0- gpio_request: gpio--22 (DVI reset) status -22
> >> =C2=A0- Unable to get DVI reset GPIO
> >>
> >> There is a combination of leftover code and revision confusion.
> >> Additionally, xM support is currently a hack.
> >>
> >> For original Beagleboard this removes the double initialization of=
 GPIO
> >> 170, properly configures it as an output, and wraps the initializa=
tion
> >> in an if block so that xM does not attempt to request it.
> >>
> >> For Beagleboard xM it removes reference to GPIO 129 which was part
> >> of rev A1 and A2 designs, but never functioned. It then properly a=
ssigns
> >> beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes =
the
> >> hack of initializing it high. Additionally, it uses
> >> gpio_set_value_cansleep since this GPIO is connected through i2c.
> >>
> >> Unfortunately, there is no way to tell the difference between xM A=
2 and
> >> A3. However, GPIO 129 does not function on rev A1 and A2, and the =
TWL
> >> GPIO used on A3 and beyond is not used on rev A1 and A2, there are=
 no
> >> problems created by this fix.
> >
> > Can you check if this needs updates for your clean up patches?
>=20
> I'm not sure what you mean, can you be more specific?

Tomi has a DSS clean-up series posted that affects the board-*.c
files.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
