From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
Date: Wed, 11 Apr 2012 11:56:39 +0300
Message-ID: <20120411085638.GC12064@arwen.pp.htv.fi>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410162353.GA6217@core.coreip.homeip.net>
 <CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 02:19:48PM +0530, Poddar, Sourav wrote:
> >> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> >> +{
> >> + =A0 =A0 if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(keypad_data->base + offse=
t);
> >> + =A0 =A0 else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(keypad_data->base + offse=
t + 0x10);
> >> +
> >> + =A0 =A0 return -ENODEV;
> >
> > Instead do:
> >
> > =A0 =A0 =A0 =A0return __raw_readl(keypad_data->base + keypad_data->reg_=
offset +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset);
> >> +}
> I have a couple of doubts on this:
> 1. Before using kbd_readl/kbd_write anywhere we
> need to populate the "keypad_data->reg_offset"  with the register address
> which we need to read or write.

no no... keypad_data->reg_offset would be 0 or 0x10 depending on the
scheme you decode from revision.

--=20
balbi

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhUdGAAoJEIaOsuA1yqRE4v0P/iYCf7a3MpUL3fk5j54JCTbR
pjTCX8aNkCmIu3CJVTHNC6eqDDvjXZnYav4MQRnfpWAUeEpSc4DFDYhDN0adiMHy
OVMUB8+2gH0WZXtFZvKstAzgzEJCHDQD/ObISxn+2moW07l0tScWuu/jGSV5LBU9
RCbTmjkhBsy5fdikz7NS39Vhfa/3uoJZSjiEkMvgyWG6WGqWOcYTd1o4xMJ4RavE
VVg01u58PhMqIjX5BPpZdQVVXv2MrDC5+2tMM2yXwKHq+SklDYf6k968rq41k/BV
DNV9SeYRqQ9q2GVSpWDwT1HtfG7mtjVgmb3nz9Gmx4RRnfFJTjVlAyIjehtTmlOJ
nnbI1ucpLdcIg4a5kGigj7umcx6Qqbm2EZRXI6q+BUZA06H89MJXQNvmb0hgEKur
JJ83IGNOpmolmeGQssc0VC+I72QJpVp3njCk62gcmNPlb5ou6/9+/jdIgCQZFrZb
cQDpjWekoA458vvLhu39tTs1AdP7lypKSYIC/5juhaapb6qF/XObFuCGyGSKihkt
r8a5h6luAP0XefnXptg90wRUybi/EcRK3ecw0SnJL4HKzfZkyXz5zukuM0q6shPz
IsgXZpBmydp+yBIHJjWH0l6xe+N4Qifsa98zuQckJEmf4qN7Y+cDu75JjzMzzpgy
i9GdiUNXiA17P48PHD4h
=gB5N
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
