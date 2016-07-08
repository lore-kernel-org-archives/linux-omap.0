From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] [PATCH v3 1/4] spi: omap2-mcspi: Add comments for RX only
 DMA buffer workaround
Date: Fri, 8 Jul 2016 10:46:24 +0200
Message-ID: <20160708084624.GS6247@sirena.org.uk>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
 <1467911871-4508-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="onT/iYtSweZVW9zT"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467911871-4508-2-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--onT/iYtSweZVW9zT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2016 at 12:17:48PM -0500, Franklin S Cooper Jr wrote:
> OMAP35x and OMAP37x mentions in the McSPI End-of-Transfer Sequences section
> that if the McSPI is configured as a Master and only DMA RX is being
> performed then the DMA transfer size needs to be reduced by 1 or 2.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--onT/iYtSweZVW9zT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXf2hgAAoJECTWi3JdVIfQNQEH/0zc6vi4VIt8HuxulY09TfYG
23I2JBcq7kO9JNWLuSt9vfa4IXiCUBiQzr6h3mUPrDYq1c+o8use+4QLC/87jCfA
PHk19k9q02P6OPXUVKA8RnW6Z8Oge5NhKnwkUSmSd56sAkSzFMSOA9SyR1FMaHKu
Vic2N2a7mJ+oBizThfANHX+Nb9IH3L5EJC8Xag3/htqf/wtYLcKPYlD6l1J0UKzI
99Gxn3wfL+NkYRjl5Z9hUREfPcfmuc5/KaD+GjTogyfMWdUdSlxnCaHb+Pg2SExV
vz01RXjHMOuYbjUljj+snah8GhSvA+ABzjKJgI5yD0qef//fpdwhGv1VpVSOvsI=
=jk7N
-----END PGP SIGNATURE-----

--onT/iYtSweZVW9zT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
