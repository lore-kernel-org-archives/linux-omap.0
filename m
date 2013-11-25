From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 14:46:41 -0600
Message-ID: <20131125204641.GM18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-5-git-send-email-zonque@gmail.com>
 <20131125194804.GB18046@saruman.home>
 <5293AD40.6060607@gmail.com>
 <20131125200853.GG18046@saruman.home>
 <5293B28F.9010506@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OoKXXPSaVc/Wpb6N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48418 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3KYUri (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 15:47:38 -0500
Content-Disposition: inline
In-Reply-To: <5293B28F.9010506@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

--OoKXXPSaVc/Wpb6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 09:26:55PM +0100, Daniel Mack wrote:
> On 11/25/2013 09:08 PM, Felipe Balbi wrote:
> > On Mon, Nov 25, 2013 at 09:04:16PM +0100, Daniel Mack wrote:
> >>>> diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb=
_virthub.c
> >>>> index e977441..24e46c0 100644
> >>>> --- a/drivers/usb/musb/musb_virthub.c
> >>>> +++ b/drivers/usb/musb/musb_virthub.c
> >>>> @@ -109,7 +109,7 @@ void musb_port_suspend(struct musb *musb, bool d=
o_suspend)
> >>>>  	}
> >>>>  }
> >>>> =20
> >>>> -static void musb_port_reset(struct musb *musb, bool do_reset)
> >>>> +void musb_port_reset(struct musb *musb, bool do_reset)
> >>>
> >>> NAK, this should not be called from the glue layers at all. If anythi=
ng
> >>> call from musb_core's resume callback. That will only be called after
> >>> parent's resume has been called anyway.
> >>
> >> Given that this driver is successfully used with suspend/resume on oth=
er
> >> platforms without that reset, but it's clearly needed for dsps, I'm
> >> fairly sure this should be a glue-layer specific thing. Hence the chan=
ge.
> >>
> >> I think it'll break things on other platforms if we unconditionally
> >> reset the port after resume, but I can't test it. Anyone?
> >=20
> > your original commit log only says "we need to issue port reset" but it
> > never explains why. It could very well be you just found a device which
> > needs to be reset when coming out of suspend and it misses a quirk flag=
 ?
>=20
> I think I can really rule that out, as I tested with multiple USB sticks
> and also tested the same sticks on other embedded platforms.
>=20
> > In any case, those functions should never be called by the glue, if
> > reset needs to be called, it must be called by musb-hdrc.ko, if you need
> > a flag, pass a flag but I need a really good explanation in your commit
> > log of why that's necessary.
>=20
> Well, if I'd only knew exactly why. All these patches are really the
> result of many days of trial and error, with multiple drivers (musb,
> cppi41, ...) involved. And as I said - I have no documentation of the
> musb core itself.
>=20
> So yes, I can do it the other way around and pass a flag, but what I
> can't provide is a good explanantion why the dsps glue behaves
> differently here than others. I'm curious myself, and all I know is that
> with this reset in place, things work as expected on AM33xx.

ok, then let's pass a flag. Meanwhile I'll try to figure out internally
why we need that reset. As Alan said, usb-persist should already for a
bus-reset when resuming, right ?

--=20
balbi

--OoKXXPSaVc/Wpb6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk7cxAAoJEIaOsuA1yqRErFAP/AswGDoEQoUKIfX2jfMC6EVA
Ay6AUHug1O//U9O23dtlwi9H9dzNM7fuiAqK0AK6LrCnkGsGH9StXgVkwvsf59/w
ljFi4n12nQcOyIvWDW+tZ7GlYN6bEhn8IcDUHKRoLgeTYboY3RPZVp+qz17IET6S
t17KQrJYUUMr4ZLTPcJp7sn53qhanL411SAQxvcQaQoSKylo67KsIVSGxGF001Qv
E26A/1sX60CLHCVGeCNBtEg27GRWEAkIaZJcgPNQmCidstV6jw9G0LdsR+b7tQnM
2YEM53mb7jiu0r2ItIAW9z5w0Sm/vzN4Rdi7CXbziA7T+F9ssS7SQRTY1VzLOJc9
YT7+h4hn42jGExWXq2NdlzTkxcKKtqnv7vv7EAQkz2V99G312Qr2bnUEuRfNTCVt
KD2q2CqUwqd5KSuqofbeSqfTBcJ8ni0SBkO7z1SaWFfvpMnTOicQ4Cy6yNdpEc36
dPWIP5yQoATkKYYs5aejxJq1/PUF+2+hxWiRZ0UYL5pMwZrSp/ATQHdh2NCq8LUz
M+lGjM2P24xh4gd/8PFpxJoUJVxoYyH3mqXiqO3tyVVJrBhiJz9YAxvwxxFCeaTA
phwPdumcdwH9/VbrNNOnXmgyT7BeVlDdYkKGCYNU4WTrT9/VVHBQ9Ie4U9BSjlq2
lhob5xgLALISifDksRqw
=5lSQ
-----END PGP SIGNATURE-----

--OoKXXPSaVc/Wpb6N--
