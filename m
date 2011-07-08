From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Fri, 8 Jul 2011 18:02:26 +0300
Message-ID: <2323058.DqPoNzVktU@barack>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com> <1310068516.3569.22.camel@CNA0741383> <20110708083733.GA18860@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab1GHPMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:12:39 -0400
In-Reply-To: <20110708083733.GA18860@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Friday 08 July 2011 16:28:05 Mark Brown wrote:
> > It's not that simple in this situation. We also have a PM dependenc=
y on
> > the CODEC here too, it supplies our interface clock via the DAI so =
we
> > have to be very careful how we interact with the ABE and CODEC. The
> > critical thing here is the pop reduction and a subsequent ABE patch=
 will
> > also introduce some hard timing constraints here too.
>=20
> This definitely feels like it needs sorting in a better way than just
> inserting random delays into drivers

I agree, there should be a better way to handle this.

> the clocking dependencies are far
> from unique, for example, and would normally be managed by the machin=
e
> drivers with the current infrastructure.

Sort of yes, but as soon as we have more devices, we will need either w=
ays in=20
the core, or some common file to handle the clocking, startup, and othe=
r=20
dependencies between McPDM and the twl6040 - I'm completely ignoring th=
e ABE=20
here.
BTW: what infrastructure you are suggesting?

> Right now it's all sounding
> far too fragile due to the lack of any explicit indication of what's
> going on and the fact that things are going to be spread over a bunch=
 of
> different drivers.

Agreed, but... if we handle the McPDM stop start from the outside, will=
 it=20
help? I mean we need to keep on eye what the twl6040 is doing, and do t=
hings=20
accordingly within the McPDM.
=20
> If we just insert random delays into the drivers the chances of anyon=
e
> understanding what the code is supposed to be doing in the future see=
m
> low which isn't going to be nice when people do different designs.

Again: agreed.
Unfortunately this cleanup work has to wait, since at least I'm going f=
or a=20
holiday.

Another, not directly related thing is that with this driver in place a=
t least=20
one can play audio on OMAP4 with upstream kernel (through McPDM, and wi=
thout=20
ABE).

This area is still work in progress, but I prefer to start from somethi=
ng,=20
which shows some sign of life.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
