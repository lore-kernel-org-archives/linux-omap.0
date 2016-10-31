From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval property query
Date: Mon, 31 Oct 2016 21:30:20 +0100
Message-ID: <201610312130.20261@pali>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting> <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com> <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9129222.Ux6CIOLuVt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Matt Ranostay <mranostay@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart9129222.Ux6CIOLuVt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 31 October 2016 21:22:18 Matt Ranostay wrote:
> On Tue, Oct 25, 2016 at 11:47 AM, Matt Ranostay <mranostay@gmail.com>
> wrote:
> > On Mon, Oct 24, 2016 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
> >>> Pavel + Sebastian this is the patchset that need I some input on
> >>> :)
> >>=20
> >> Better then previous one.
> >=20
> >> But my version of bq27xxx_battery.c already contains this:
> > This is for allowing udev rule to set the properties as well.
> > otherwise a kinda crude RUN =3D " echo value >
> > /sys/module/bq27xxx_battery/parameters/poll_interval" is required.
>=20
> Any thoughts on this?

Isn't sysfs /sys/module/bq27xxx_battery/parameters/poll_interval=20
attribute what should be used to change module parameters like=20
poll_interval?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9129222.Ux6CIOLuVt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgXqdwACgkQi/DJPQPkQ1LAxwCePYQE5tWLGJ3XWUdiuvysls4/
UbYAoLgORj9Pe/Ahm9IDRyuOEwq7CnvF
=zNIO
-----END PGP SIGNATURE-----

--nextPart9129222.Ux6CIOLuVt--
