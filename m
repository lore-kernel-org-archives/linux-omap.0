From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 0/8] I2C patches for v3.8 merge window
Date: Wed, 14 Nov 2012 17:58:45 +0100
Message-ID: <20121114165845.GB1020@pengutronix.de>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <20121022133023.GC14033@arwen.pp.htv.fi>
 <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> here's another series for OMAP I2C driver. There are a few cleanups
> >> and one very nice new feature: we can now report how many bytes
> >> we transferred until NACK.
> >>
> >> Note that the implemementation for OMAP-I2C turned out to be a
> >> little more complex then I expected, mainly because of the way
> >> I2C_CNT register behaves and because of the very buggy register
> >> usage on that driver.
> >>
> >> I have boot tested all patches on beagle xM (3630) and pandaboard
> >> rev A3 (4430), will send boot-logs if anyone wants to see.

The series is a bit confusing mixing V1, V2 and V3 patches. Also, there
are a few comments unaddressed it seems to me (reading in hot path,
barriers). Please make sure these are properly handled and resend as a
seperate series (all patches V4). Bonus point if you rebase it to my
for-next, which I will push out soon.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjzcUACgkQD27XaX1/VRvtbgCfZ5Sot5HrHh8kC4+tY9z8BFdl
dMUAn1dTMmi30kh5m8bOXvlZGfxzgmzB
=x2K1
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
