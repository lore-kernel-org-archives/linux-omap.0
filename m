From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: rx51: support for lis3lv02d accelerometer
Date: Wed, 23 May 2012 20:22:16 +0200
Message-ID: <11538481.hbXYTSlcIX@pali>
References: <1621273.5PNGJFOirm@pali> <20120509000734.GZ5088@atomide.com> <20120521160840.GK17852@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3592334.xWMB20p7sQ"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120521160840.GK17852@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>, Sebastian Reichel <sre@debian.org>, Felipe Contreras <felipe.contreras@nokia.com>, Ameya Palande <ameya.palande@nokia.com>
List-Id: linux-omap@vger.kernel.org


--nextPart3592334.xWMB20p7sQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday 21 May 2012 09:08:40 Tony Lindgren wrote:
> Hi Pali,
>=20
> * Tony Lindgren <tony@atomide.com> [120508 17:12]:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [120504 08:41]:
> > > Hi!
> > >=20
> > > Upstream linux kernel has already driver for lis3lv02d
> > > accelerometer in drivers/misc/lis3lv02d. So now can be
> > > added also platform support for nokia rx51. Patch exists
> > > for long time in meego obs repository:
> > > https://build.pub.meego.com/package/view_file?file=3Dlinux-2
> > > .6-omap-rx51-Platform-support-for-lis3lv02d-acceleromet.pat
> > > ch&package=3Dkernel-adaptation-n900&project=3DCE%3AAdaptation%3
> > > AN900
> > >=20
> > > It is possible to include this patch to upstream kernel?
> >=20
> > Thanks, applying into board branch with From: Ameya as in the
> > link above.
>=20
> Just noticed that this one is still using OMAP_GPIO_IRQ that
> won't work any longer. Can you please send a fix on top of this
> patch against linux next to fix it?
>=20
> The fix is to use gpio_to_irq() in the related init function
> instead of static OMAP_GPIO_IRQ in the data structure.
>=20
> Regards,
>=20
> Tony

Sorry, but now I do not have time for it. Tony, if fix is simple=20
can you do it?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--nextPart3592334.xWMB20p7sQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk+9KtgACgkQi/DJPQPkQ1KWCwCgmPFRogLGUTQ2HT4xkGGPMyRE
UeYAnR7VYnoLyofdqafEiglDah7laShk
=ysU0
-----END PGP SIGNATURE-----

--nextPart3592334.xWMB20p7sQ--
