From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Thu, 21 Jan 2016 12:33:11 +0100
Message-ID: <20160121123311.5346e40d@ipc1.ka-ro>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160121111115.GJ6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

> On Thu, Jan 21, 2016 at 11:26:11AM +0100, Lothar Wa=C3=9Fmann wrote:
> > > On Thu, Jan 21, 2016 at 08:05:24AM +0100, Lothar Wa=C3=9Fmann wro=
te:
> > > > > On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa=C3=9Fmann=
 wrote:
>=20
> > > > > > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-=
Ro
> > > > > > electronics TX48 module. Make the IRQ optional in the drive=
r and use a
> > > > > > polling routine instead if no IRQ is specified in DT.
> > > > > > Otherwise the driver will continuously generate interrupts =
and make
> > > > > > the system unusable.
>=20
> > > > > How will the driver generate interrupts if there is no interr=
upt
> > > > > physically present in the system?
>=20
> > > > It's using timer interrupts to poll the LTC3589 state.
>=20
> > > I know that is what your patch does, my question is why you say i=
n your
> > > commit log that "Otherwise the driver will continuously generate
> > > interrupts and make the system unusable".
>=20
> > Because the interrupt is level triggered and the polarity of the
> > EXTINT pin is inverted, the interrupt will be constantly active whe=
n
> > the IRQ pin of the LTC3589 is inactive.
>=20
> So, to repeat my original question, how will that generate interrupts=
 if
> there is no interrupt physically present in the system?
>
It won't. That's the whole purpose of this patch.
I'm afraid, I don't quite understand what you want to say...

Without this patch there will be a constantly active interrupt, which
will stall the system because the nNMI interrupt (on the EXTINTn pin) i=
s
level triggered.
Since the polarity of the interrupt input is fixed, there is no way to
use it in our HW.


Lothar Wa=C3=9Fmann
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
