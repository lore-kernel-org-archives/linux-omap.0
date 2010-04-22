From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/5(7)] input: serio: add support for Amstrad Delta
 serial keyboard port
Date: Thu, 22 Apr 2010 16:14:53 -0700
Message-ID: <20100422231452.GT18272@atomide.com>
References: <201004150419.05038.jkrzyszt@tis.icnet.pl>
 <201004150431.06719.jkrzyszt@tis.icnet.pl>
 <20100415161451.GA13966@core.coreip.homeip.net>
 <201004152016.10035.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52871 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0DVXO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 19:14:57 -0400
Content-Disposition: inline
In-Reply-To: <201004152016.10035.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100415 11:14]:
> Thursday 15 April 2010 18:14:51 Dmitry Torokhov napisa=C5=82(a):
> > Hi Janusz,
>=20
> Hi Dmitry,
>=20
> > On Thu, Apr 15, 2010 at 04:31:03AM +0200, Janusz Krzysztofik wrote:
> > > +
> > > +config SERIO_AMS_DELTA
> > > +	tristate "Amstrad Delta (E3) mailboard support"
> > > +	depends on MACH_AMS_DELTA
> > > +	default y
> > > +	select AMS_DELTA_FIQ
> > > +	select KEYBOARD_ATKBD
> >
> > I'd rather not select atkbd here since it is not required for this
> > driver to work but simply adjust your defconfig.
>=20
> I was just trying to address possible future support questions, as yo=
u can=20
> already find them in the e3-hacking 2006 archives :).
>=20
> OK, I'll drop it then and move the config back inside the "if SERIO".=
=2E."endif"=20
> block.
>=20
> > > +
> > > +	if (!(machine_is_ams_delta()))
> > > +		return -ENODEV;
> >
> > Extra parens.
>=20
> Yes, it looks like I'm too much wary. I'll drop them.
>=20
> > Otherwise:
> >
> > 	Acked-by: Dmitry Torokhov <dtor@mail.ru>
>=20
> Thanks.
>=20
> > I assume it is going to be merged with the rest of your patches thr=
ough
> > a tree other than linux-input.
>=20
> Probably yes, since it depends on most of them. Let's see first what =
Tony=20
> says.

Sorry for the delay, quite a few patches to read through right now..

Looks pretty good to me, I have one comment on the FIQ though.

After the remaining fixes, could you please repost the whole series
one more time now with linux-arm-kernel also cc'd?

Then if no more comments there, I'll add add it to omap for-next.

Cheers,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
