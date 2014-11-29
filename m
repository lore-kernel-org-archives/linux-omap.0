From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Sat, 29 Nov 2014 09:35:21 -0600
Message-ID: <20141129153521.GB14924@saruman>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
 <20141117180413.GF7046@atomide.com>
 <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
 <20141118154204.GI7046@atomide.com>
 <CAFqH_508pYkDXO8BCR=cFGFY_CgfkhqvseUy=Z--fJMOQCo6Tg@mail.gmail.com>
 <20141119175348.GK7046@atomide.com>
 <CAGm1_kvZnkB4MWPv3ExCqibb0Rq4xXfkPHHpfDb9HOTFNf7BiA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36696 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbaK2PfQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Nov 2014 10:35:16 -0500
Content-Disposition: inline
In-Reply-To: <CAGm1_kvZnkB4MWPv3ExCqibb0Rq4xXfkPHHpfDb9HOTFNf7BiA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 28, 2014 at 11:35:53AM +0100, Yegor Yefremov wrote:
> On Wed, Nov 19, 2014 at 6:53 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Enric Balletbo Serra <eballetbo@gmail.com> [141119 03:14]:
> >> 2014-11-18 16:42 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> >>
> >> Checked again, and no luck. It's very weird because from the OTG point
> >> of view, OTG is exactly the same between Beagleboard-XM and IGEPv2.
> >>
> >> Can you confirm that you're using kernel 3.18-rc5 without other
> >> patches applied ? At this moment, I don't have a Beagleboard-XM to
> >> test, I'll try to get one because at this moment I'm a bit stuck with
> >> this problem.
> >
> > Yes it was with v3.18-rc5 and the defconfig patch I posted except
> > I had to disable all the other MUSB platforms. Also tested it with
> > built in modules.
> >
> > Maybe you need to check the .dts pinctrl entries for hsusb0_* lines?
>=20
> Just my 2 cents, My am335x based board shows similar symptoms
> (CONFIG_USB_MUSB_DUAL_ROLE enabled). Only if I specify  dr_mode =3D
> "host"; in my DTS I get device enumerated. 3.15, that I had before
> made no problems as OTG.

Are you sure your ID pin is properly routed ? If you set dr_mode to otg,
then you *must* have a properly routed ID pin and use a proper
micro-/mini-ab receptacle. That's not true for e.g. beagle bone black.

One USB port is using a Standard-A while the other uses mini-B. You
can't do any role swapping with those.

--=20
balbi

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUeee5AAoJEIaOsuA1yqREkqgP/Rmkb5pDSGD50Vxe/bqRMf6Y
V0TWk9rCelXl7cns5sv5lZvmv7/ylvjrBoExTCuH639nSKmKdBjLqzs0e4xurMd2
BX2GKt2i+7fhTw9akIpcLqkkfqFgW5tuxF8FdEpbqY28T2Vo6HQ/Kgns4fnoO5FB
bzwRSCldQG6MYWHnZaLI1CByIwmOU8uHaMsZ5Ka6IbOH5je7hy2BB0Y9Fj1zs+mA
dx6cTFzp+XbSBMKoUDM9QjM6l0rGwtQ1S7FWAWBdCDpsj4kcPc7tWFdggOiR0U1k
oop5EPGVEcmzhdqsnkSUK1+QXHq6CU7KfBtBgmUYckuDZS77kJ4rb6MgF4RlRbd3
7ux5FWiqPhEzp7yIXkaCv8zJJu8Cz+xMozH5njj83l5K4Tg3aa/+dilbyL/h7Z6s
DNntvPUkZECaPS4kNCfs37QK+KdpQEY8NRTkJeqacVBCwi5qyq9r9RvJGEP6oue5
fR/umjx2hJgBAGJvG8SJ29OgMupWA+B080pUg6S64bmBZIjCRHpvl7JfrZB3zQ83
VIO4BPjU7Dy6svlDu0rkFZ2XKiWE1u0CzT98/LI13FbT7/vbUezSZE6xmaMiy9KB
h5PJ9y00tKOWwL41SR+BPhmkFft3AYtQ02u2ledhB1kKDcPd87YPgxJKzSW+kAWd
qXhBknNRtd4HknUjJ08z
=m8UX
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
