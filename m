From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv7 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 15:44:27 +0200
Message-ID: <20120912134427.GC16547@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <20120911220048.GD27031@pengutronix.de>
 <50505FDC.4090500@ti.com>
 <20120912101850.GB2624@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120912101850.GB2624-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 12:18:50PM +0200, Wolfram Sang wrote:
>=20
> > I donot see the warning. Am I missing something?
>=20
> I deleted my logfiles already. Ignore it for now, if it comes up again
> with your new series, I will give a more detailed pointer.

Sorry, the section mismatch was not related to I2C it seems:

WARNING: vmlinux.o(.data+0x30958): Section mismatch in reference from the v=
ariable rx51_si4713_dev to the (unknown reference) .init.data:(unknown)
The variable rx51_si4713_dev references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Got it with an "allnoconfig" and then selecting MMU and OMAP.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBQkbsACgkQD27XaX1/VRtbuACgkBa0lOIN551eec9TSetVPsCE
Ew0AoKizKon3DIILpERWJIwzAXdgRVDc
=T4Yq
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
