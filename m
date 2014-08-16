From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/7] net: cpsw: Support for am335x chip MACIDs
Date: Sat, 16 Aug 2014 11:55:53 -0500
Message-ID: <20140816165549.GC2858@katana>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408202315-20006-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2014 at 05:18:28PM +0200, Markus Pargmann wrote:
> Hi,
>=20
> This series adds support to the cpsw driver to read the MACIDs of the am3=
35x
> chip and use them as fallback. These addresses are only used if there are=
 no
> mac addresses in the devicetree, for example set by a bootloader.
>=20
> In v3 I removed the previously seperate driver and included the changes i=
nto
> the main cpsw driver. I now check for a am33xx machine to not make this
> operation when running on davinci.
>=20
> Patches 1-4 are some minor fixes for the cpsw driver.
> Patch 5 adds the readout support.
> Patches 6 and 7 are for am33xx.dtsi to actually enable this feature.

Minor comments, but in general, looks good to me:

Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Tests on real HW need to wait another 9 days...


--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT740VAAoJEBQN5MwUoCm2LtUP/iuOzxyMeSGHsiefUhPo8dNp
K5CfVwAI/WOav7nVcl4xKLXYr0hFuOdgKxDYPncwmXUUIPofkmzzaGXVu5ySSEPb
zfp2wfrNrcvHdveRc+/eqRaejrApRF2cN4Fs3vyDUJ5mjFt7hC1tKIrudHLHUVN9
woYYYiCwfO8MkrmBQWB38pnlRGk8KI5qnA+mdfEGSxxHG7gR9lYoa6xhQ57WXo/C
Lu42BATYFs9yOB44iX/ROxKh6mueEpQvf2wmRojlpuPakHbUCF0ZwQ9jKAcZJmV0
GDt5K3FcZi4vdO5VPlXX9OncpKrwfbx8lf9+MmQqeUWWiCmmcwBfUYEOCcB+D2fo
qCcnFoWQUCSrDkJZ5zE/9GkunY+cc0HbSg3QD8z+HGd0Zb+WK1Df6YwZe+K77fyJ
fWNULmhDOWXghWrUWUeVKjAV/e7QQPBcb667wdTy06bqEl8e1YZFP3Rjq69GhIBz
Cc7Cbk2w5if3SLv6bqlC44sR9klsJUwa3Ob4FRSZfgbVaYnOhz6HKkxDU0VgVpUG
+6OzgZ8mAD0jpoYMcE5s48/QilTuMtVV9T8Ru2pXuSmulfQ1uwUMmXNJv6pA87SN
lu3V3S3ALwjjP6B+fM+mnmyyQT4CvYmfqearQXv34+R52zmzbzmu/sp2vW/761rx
TRJH37EX/MiiIAMVW8gl
=PR/y
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
