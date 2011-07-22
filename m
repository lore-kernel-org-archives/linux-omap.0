From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Fri, 22 Jul 2011 11:57:17 +0300
Message-ID: <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-4-git-send-email-khilman@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48191 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751731Ab1GVI5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 04:57:21 -0400
Received: by fxg11 with SMTP id 11so5341195fxg.34
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 01:57:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311292338-11830-4-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2011 at 04:52:13PM -0700, Kevin Hilman wrote:
> Board code should not touch omap_device internals.  To get the MPU/IVA de=
vices,
> use existing APIs: omap2_get_mpu_device(), omap2_get_iva_device().
>=20
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   23 ++++++++++-------------
>  1 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap=
2/board-omap3beagle.c
> index 32f5f89..3ae16b4 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -491,23 +491,22 @@ static void __init beagle_opp_init(void)
> =20
>  	/* Custom OPP enabled for all xM versions */
>  	if (cpu_is_omap3630()) {
> -		struct omap_hwmod *mh =3D omap_hwmod_lookup("mpu");
> -		struct omap_hwmod *dh =3D omap_hwmod_lookup("iva");
> -		struct device *dev;
> +		struct device *mpu_dev, *iva_dev;
> =20
> -		if (!mh || !dh) {
> +		mpu_dev =3D omap2_get_mpuss_device();
> +		iva_dev =3D omap2_get_iva_device();

out of curiosity again, nothing to do with this patch.

Maybe it would be nicer to have an api such as:

omap2_get_device(name);

there are already four devices to be gotten, if that number grows any
bigger, so will the number of helper functions.

--=20
balbi

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKTtsAAoJEAv8Txj19kN1LrcH/05YDMUVLojn9TdbCl5R1Kha
cpNnvpCMvENXfMxsscwzNmKKWIDZ+qMyzX51hY1WW7wGq4wcd+8XBaAEtXPk274I
KMGfEN8MF2TXkWk4OONiGJE2Gb/mXAzjOglAA2s451yUdTzMYFKudlx9lzJvkyF6
6sciTblyHNRhZItvaNmd5SPhlsf40WgqZJ+v8bA0x3jtoJX8Znut0E0HpqwfrJQ5
QsHuFAekcH+j0KLOMdoy9JU8AITZNez4r1L61Fh/0jWlzAlxpGv4L1W+PA7i7RoG
hTQSdKyKlidcdpWAEepS3VpOIreWAOHNFePhPnes2qBVKu3cpBJeTgCIkkUAG/4=
=WmES
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
