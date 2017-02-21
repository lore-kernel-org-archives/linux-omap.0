From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 18:07:55 +0100
Message-ID: <20170221180755.48946fc5@aktux>
References: <cover.1482936802.git.hns@goldelico.com>
        <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
        <201702202042.15878@pali>
        <201702202208.50498@pali>
        <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
        <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
        <0A33CCEA-448C-4C1D-9563-FDA54743BD01@goldelico.com>
        <20170221090940.GD9795@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QBvnUSHLCRUNlOXqJdFJkXU"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221090940.GD9795@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrey Gelman <andrey.gelman-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd@arndb>
List-Id: linux-omap@vger.kernel.org

--Sig_/QBvnUSHLCRUNlOXqJdFJkXU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

[...]
> > Hm. Why not touching pixel (0,0) on the touch is always pixel (0,0)
> > on the screen and touching pixel (639,479) is always (639,479)?
>=20
> Important is that there is no 1:1 mapping between input evdev device
> and drm/fb output device. These are two independent devices. There is
> no connection between screen and touch. So such presumption should
> not be done in kernel. You can do that in userspace.
>=20
But at least it can be told to userspace that these two devices are
connected. That information should be specified in devicetree because
it is not auto-detectable.

> Lets take e.g. touchpad. It acts similarly as touchscreen input device
> (both reports absolute positioned touch events), but touchpad is not
> connected with screen. And from kernel point of view these devices are
> both input and absolute positioned.
>=20
> It looks like the whole problem is there that you wanted to do this
> mapping for your hardware in kernel. And this is not what is kernel
> doing or should do. Moreover I know people who are using integrated
> touchscreen on laptop as (touch) input device for external monitor.
> And in this configuration it does not make any sense to map
> touchscreen input to pixels of integrated LCD touchscreen (as
> external monitor could have different resolution as integrated LCD
> touchcreen).
>  =20
Interesting example. But then you also do not need flipping/rotation
because the angle between your screen and your absolute position device
is not fixed.

Regards,
Andreas

>

--Sig_/QBvnUSHLCRUNlOXqJdFJkXU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJYrHQKAAoJEInxNTv1CwY0vlUP9ArqFcdZQ5ZzJURV5SSdM0j3
c13vY/QJvdBZKmMSKlWaL2ino87ITpbemmrFzknLL5o2FEDBa2jcylOesVyTTZwy
AoFgU6mg+oxjB2xzjgoqFmvlAFxnVdhUlepkPyvZoqyWUnVAY26VGWwq5Hy5pwZG
SS8O05ZTztKMc3PS+teXM3q82lpxMDxoxXH/f1faQpo1f5o90MDj4hiDO68gS9fW
15usLoj+cdoBGxKwCsAc5EJ7HcavBhUW3uodwASZG0CwZtvEpPCkfpCcZgqrJel1
xc96A2Yh75HnBs4z4S5UGVDHbzUBPq94VGKAd9MzFC43T19vXz3kHEseLmYZDgmZ
PexyDxoaVOswMH3tthDnchTOCdKTY0MqmR+xvuycp6njkckU+coyH9UJfN9B9QgT
0a2xSzUmOjRikr4B7dpgFqOSl2cS3KCqG4SGpUUajtyty8b/rwF7oU300tfTPZwU
BqOKgdBPitKhZfVq/WWlnDCtmcJifiHtU0N8krn+ZW08gSOzNdUpvOzq/MosXRTV
xSLkiA+WagMFeAWeu4nzZ4WojeovydME1RLVAYFz7Ayru3oVr4MFbbS7zEK8TiEt
Pamdxz/0mBVXWOMhFXHC5ym66w7BUgHwemvb4L5DntL+JvPhoRUOD22q0HtSR0aG
2gbFTegr0KpYYExRCf0=
=osTl
-----END PGP SIGNATURE-----

--Sig_/QBvnUSHLCRUNlOXqJdFJkXU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
