From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/7] I2C patches for v3.8 merge window
Date: Mon, 5 Nov 2012 10:10:09 +0200
Message-ID: <20121105081009.GA2490@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351167915-15079-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 03:25:08PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> here's another series for OMAP I2C driver. There are a few cleanups
> and one very nice new feature: we can now report how many bytes
> we transferred until NACK.
>=20
> Note that the implemementation for OMAP-I2C turned out to be a
> little more complex then I expected, mainly because of the way
> I2C_CNT register behaves and because of the very buggy register
> usage on that driver.
>=20
> I have boot tested all patches on beagle xM (3630) and pandaboard
> rev A3 (4430), will send boot-logs if anyone wants to see.
>=20
> All patches are available at [1] if anyone wants an easy way to
> test the patches.

Wolfram, patches 1-5 are ok to apply, we just need to rework patches 6
and 7 so drivers can report how many bytes managed to be transferred.
None of these patches cause any known regressions.

let me know if you want me to resend only the 5 patches which should be
applied.

cheers

--=20
balbi

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3RhAAoJEIaOsuA1yqRE5oAP/2IVAzdKLVNLf/hXQdWiDZnJ
riYSSNPGg4B/ja9kVFq69X92hyvJZ6Jx/45FixJ839RrwHCQIXhT6J6IEJuKYq1p
Y8/H8rwvzJiFWE4Fbsfrjq65ogBysF8R+MO6pLDaLaMhGOVC41b9j9Kvq5vZfiJA
Au/fFwipcrk26s1Ap23qy9QEzNXlDZBVPHty10kGQCbWnEtxzDtUIvH6/53RGNic
jp6qrUXcB8Af/iEwEwkqE4TYUy6VnZIQLYbuv6/eUlnhExgVsxEF4sE5wEAdA1go
K34la0N5ofW8UFqeA05NPFVAoO8Jy+jUln5hA0UDSTnuDlX0CVRZQNLQnE3VhE+X
xFYoRLK4DGpmrzwE7AzG4AtIHtI8XJFbJO9c6KiwgsRh3wokDs+12jnlic6k4fAb
Ihr9Gm1PoXTMmCIEOeAXHxlj7o7RGHNa5ZvHbVzaAkm9XP3zX7B5S4XW1nvEdl+2
zE3cqUYYLHN28gQdWUq7Gx6j5p3TcIsTzNOFA6U4wT0++gg8Npbmov7XtgnhMVR0
tkTFK6a6mb8/DhpkzgYNh1tMeBRKWc1AWH57/CKaGynw6xyvcGzt3qzFnYUSyH6w
tGbERoFCJu5D6Jlm12T0E/T194ldWdv5IT+87PH5VoShmM6I5PR6sNIYzi5N52Oi
bZ8o0YSo8QZb0Nl6HlIo
=UgTt
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
