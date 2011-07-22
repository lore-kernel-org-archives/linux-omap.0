From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting
 between devices
Date: Fri, 22 Jul 2011 11:58:20 +0300
Message-ID: <20110722085819.GJ32058@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-5-git-send-email-khilman@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37381 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751731Ab1GVI6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 04:58:24 -0400
Received: by mail-fx0-f43.google.com with SMTP id 17so4354599fxg.2
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 01:58:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311292338-11830-5-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2011 at 04:52:14PM -0700, Kevin Hilman wrote:
> For converting from struct device to platform_device, and from
> platform_device to struct device, there are existing macros.  Use
> them instead of manual use of container_of().
>=20
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 6c62af1..02199e8 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -260,9 +260,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
>  #ifdef CONFIG_ARCH_OMAP3
>  static struct omap_device *find_omap_device_by_dev(struct device *dev)
>  {
> -	struct platform_device *pdev =3D container_of(dev,
> -					struct platform_device, dev);
> -	return container_of(pdev, struct omap_device, pdev);
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +
> +	return to_omap_device(pdev);

could simplify to:

	return to_omap_device(to_platform_device(dev));

but it won't change much. Only decrease readability, probably.

--=20
balbi

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKTurAAoJEAv8Txj19kN1eU4H/0BZku/xOESvjn1mXV4WoiSX
NAZ4ev4xd5b2bFQC7qMe2ZsIiXQi8CWekj2YyhGb7Jp/wg5iaU5tkchuYSlPn8d6
k802p+HQ223Ff5uOY9aEOgP+hy+AK3JEFG9d/G07ltcjcdmtXKLCFYedjgM6+HQN
vYbml1urqtVmTx2dBM6ZJFozeGgtL2JOCWAL3EFmi+x4Nm0ma76fQqqEyU6GZyue
ERpsLz+dx4T4fKIbBhWb5uiBvxjF9Gf600Mpa41OnMiVj/Ux2FW9/sh3wsL2g9OB
+a7bfPSBjwq1HSVN0pPjH5pGjI1xUlPQvDO2+YstT3QCsYMaZvElF3hISMtfDLo=
=PEXj
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
