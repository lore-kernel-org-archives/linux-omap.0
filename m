From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
Date: Thu, 22 Nov 2012 22:49:15 +0100
Message-ID: <20121122214915.GD14851@pengutronix.de>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
 <20121120144621.5d2c213a@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121120144621.5d2c213a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 02:46:21PM +0100, Jean Delvare wrote:
> On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > needed.
>=20
> As mentioned on the lm-sensors list for hwmon patches already, I think
> it would be much clearer to not split __devexit, __devexit_p, __devinit
> etc. removal into separate patches. One patch per subsystem would be
> easier to review and apply. If patches grow too large then you'd rather
> split in a different direction, for example drivers/i2c/muxes vs.
> drivers/i2c/busses or even grouped by related bus drivers (see entries
> "I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
> MAINTAINERS for examples of meaningful groups.)

I agree with Jean here. Is there a V2 planned? With a change like this?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCundsACgkQD27XaX1/VRvVDQCfb648pSwyIGE88RY9RW4sDgf2
fpMAn2qfmShNxBl1Oz5Jg8yV6GDi3TcE
=yTbX
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
