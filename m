From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC v2 3/5] OMAPDSS: DPI: support multiple DPI instances
Date: Tue, 27 May 2014 12:04:21 +0300
Message-ID: <53845515.6030305@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com> <1401096492-1405-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Opci8N8n2xaO3abVxJXisPdG8n2kWaktd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51474 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbaE0JE3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 05:04:29 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4R94SpC002063
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 04:04:28 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4R94SbC004616
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 04:04:28 -0500
In-Reply-To: <1401096492-1405-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

--Opci8N8n2xaO3abVxJXisPdG8n2kWaktd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/05/14 12:28, Archit Taneja wrote:
> SoCs containing DSS until now had only one DPI instance. DRA7x has 3 DP=
I
> instances.
>=20
> In order to support multiple instances, we allocate a driver data
> struct(dpi_data) for each instance. This is somewhat similar to how DSI=
 driver
> was changed to support multiple instances.
>=20
> One difference is that there aren't platform devices for each DPI insta=
nce
> when DT is used. In the DT case, we store the dpi_data pointer in the D=
PI port's
> (of the type struct device_node) data pointer. In the non DT case, we s=
till
> have dummy platform devices, and the device's private data pointer is u=
sed to
> store the DPI instance's dpi_data.
>=20
> dpi_init_output/dpi_uninit_output are untouched and only used for non D=
T case,
> dpi_init_output_port/dpi_uninit_output_port are used in the DT case, wh=
ere DSS
> configures the ports using dpi_init_port/dpi_uninit_port.

This is a bit too big patch, I think it should be split.

The first patch could add the name to the struct dpi_data, but still
keep it static, and also change the functions to pass the dpi_data
pointer around, as you do in this patch.

The functions where you do

struct dpi_data *dpi =3D dpi_get_data_from_dssdev(dssdev);

could just do

struct dpi_data *dpi =3D &dpi;

This way the in the first patch you can do most of the bulk changes,
without actually changing the behavior in any way.

In the next patch, you could then add the actual support for allocating
the dpi_data instances.

Those two patches should be moved to the beginning of the series, as
they are just preparatory patches, and they don't actually change
anything with DPI.

Third DPI patch would then add support for the actual multiple DPI
instances.

> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/dpi.c | 263 +++++++++++++++++++++++++---=
--------
>  1 file changed, 181 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/=
omap2/dss/dpi.c
> index 8593567..43966a7 100644
> --- a/drivers/video/fbdev/omap2/dss/dpi.c
> +++ b/drivers/video/fbdev/omap2/dss/dpi.c
> @@ -37,7 +37,7 @@
>  #include "dss.h"
>  #include "dss_features.h"
> =20
> -static struct {
> +struct dpi_data {
>  	struct platform_device *pdev;
> =20
>  	struct regulator *vdds_dsi_reg;
> @@ -52,7 +52,27 @@ static struct {
>  	struct omap_dss_device output;
> =20
>  	bool port_initialized;
> -} dpi;
> +};
> +
> +static struct dpi_data *dpi_get_data_from_dssdev(struct omap_dss_devic=
e *dssdev)
> +{
> +	struct device_node *parent =3D dssdev->dev->of_node;
> +
> +	/* non DT */
> +	if (!parent) {
> +		struct omap_dss_device *out =3D dssdev->src;
> +
> +		return dev_get_drvdata(out->dev);
> +	}

Why do you need the above? Just plain container_of() below should work
for both DT and non-DT.

 Tomi


--Opci8N8n2xaO3abVxJXisPdG8n2kWaktd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThFUaAAoJEPo9qoy8lh71I3IP/0fhZWUgS8ImDsPqV3vx+43m
1H1sizPo9lIa6ombn4WCGfO2lMPiSbjfEQdfh2QXyJCbfynZepr9ABvODbx+lnlN
xXGaClEn8Dj7Bp9mC54K/3zJIQ0o3Gj+lM1H5j5UwhlJR5jZt2Y6aOYS7NmCyCkO
h+egu3zU3PIm9jLdDrFGOQoV6z+BZgLCAqrLHDtdWggcVVYLqSUZ6sY/ZnXb98/f
9P4Ka2Kr+qM+JOYczrDJ3m94dKdJPQfEMbZ/4rlN6t+utWuWNEYbZ0Eq5ZxvuexC
Uwi9aWEcCoMZQsZ0QAntZJnGXsh3QRErGhj4WzbP4qw5apnZvGve+UMTuKBOaMGC
xHr1rYwuVLmxVSylsqltjtq4IF7PhaTMhFRD0gmlniMAnEzwXNbgL9wI96kvrPJS
T4mgsNSoSxlhDgHJSyF58VpMVwFz+PHaX6QmeH4MmVvjXGjj2BMf7gQ/zyFv9HQb
LJI6roIABqWkXOVU218z5ZBuE9n1AfPWoZkgAyLe/d+x9Ucc+mnlDx4JFSOFVilx
a3NQug4/WVO9WYigUvPXOtWGRLBIWgtn8ACdOp37ve2xHa0/xdfPREXxXlZgra1G
4COHWQfXRwFqjti50Jc2/4Hir5yet6M5gbA0clq7wSmOaQZNTIZKnGUTL7CLIKr1
ksmo/i/VXY+eLuRdM8CJ
=8/kx
-----END PGP SIGNATURE-----

--Opci8N8n2xaO3abVxJXisPdG8n2kWaktd--
