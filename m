From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 02/23] OMAPDSS: outputs: Create and initialize output
 instances
Date: Fri, 24 Aug 2012 16:14:02 +0300
Message-ID: <1345814042.9287.72.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1345528711-27801-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-lGgKnEtEQrpXD5R+mldQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42003 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759339Ab2HXNOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 09:14:09 -0400
Received: by lbon3 with SMTP id n3so995855lbo.28
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 06:14:06 -0700 (PDT)
In-Reply-To: <1345528711-27801-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com


--=-lGgKnEtEQrpXD5R+mldQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 11:28 +0530, Archit Taneja wrote:
> Create output instances by having an init function in the probes of the p=
latform
> device drivers for different interfaces. Create a small function for each
> interface to initialize the output entity's fields type and id.
>=20
> In the probe of each interface driver, the output entities are created be=
fore
> the *_probe_pdata() functions intentionally. This is done to ensure that =
the
> output entity is prepared before the panels connected to the output are
> registered. We need the output entities to be ready because OMAPDSS will =
try
> to make connections between overlays, managers, outputs and devices durin=
g the
> panel's probe.

You're referring to the recheck_connections stuff? I have a patch that
moves that to omapfb side. But of course it doesn't hurt to initialize
the output early.

We should generally do the initialization in output driver's probe more
or less so that we first setup everything related to the output driver,
and after that we register the dssdevs. But I think that's what is
already done.

So, no complaints =3D).

> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dpi.c  |   20 ++++++++++++++++++++
>  drivers/video/omap2/dss/dsi.c  |   26 ++++++++++++++++++++++++--
>  drivers/video/omap2/dss/hdmi.c |   18 ++++++++++++++++++
>  drivers/video/omap2/dss/rfbi.c |   19 +++++++++++++++++++
>  drivers/video/omap2/dss/sdi.c  |   20 ++++++++++++++++++++
>  drivers/video/omap2/dss/venc.c |   20 ++++++++++++++++++++
>  6 files changed, 121 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.=
c
> index f260343..4eca2e7 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -408,10 +408,30 @@ static void __init dpi_probe_pdata(struct platform_=
device *pdev)
>  	}
>  }
> =20
> +static int __init dpi_init_output(struct platform_device *pdev)
> +{
> +	struct omap_dss_output *out;
> +
> +	out =3D dss_create_output(pdev);
> +	if (!out)
> +		return -ENOMEM;
> +
> +	out->id =3D OMAP_DSS_OUTPUT_DPI;
> +	out->type =3D OMAP_DISPLAY_TYPE_DPI;
> +
> +	return 0;
> +}
> +
>  static int __init omap_dpi_probe(struct platform_device *pdev)
>  {
> +	int r;
> +
>  	mutex_init(&dpi.lock);
> =20
> +	r =3D dpi_init_output(pdev);
> +	if (r)
> +		return r;
> +
>  	dpi_probe_pdata(pdev);
> =20
>  	return 0;
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.=
c
> index 659b6cd..22e0873 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -4903,6 +4903,23 @@ static void __init dsi_probe_pdata(struct platform=
_device *dsidev)
>  	}
>  }
> =20
> +static int __init dsi_init_output(struct platform_device *dsidev,
> +		struct dsi_data *dsi)
> +{
> +	struct omap_dss_output *out;
> +
> +	out =3D dss_create_output(dsidev);
> +	if (!out)
> +		return -ENOMEM;
> +
> +	out->id =3D dsi->module_id =3D=3D 0 ?
> +			OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
> +
> +	out->type =3D OMAP_DISPLAY_TYPE_DSI;
> +
> +	return 0;

As I mentioned in the last email, I think this could be something like:

struct omap_dss_output *out =3D &dsi->output;

out->pdev =3D dsidev;
out->id =3D xxx;
out->type =3D yyy;
dss_register_output(out);


> +}
> +
>  /* DSI1 HW IP initialisation */
>  static int __init omap_dsihw_probe(struct platform_device *dsidev)
>  {
> @@ -4997,10 +5014,14 @@ static int __init omap_dsihw_probe(struct platfor=
m_device *dsidev)
>  	else
>  		dsi->num_lanes_supported =3D 3;
> =20
> -	dsi_probe_pdata(dsidev);
> -
>  	dsi_runtime_put(dsidev);
> =20
> +	r =3D dsi_init_output(dsidev, dsi);
> +	if (r)
> +		goto err_init_output;
> +
> +	dsi_probe_pdata(dsidev);
> +

Why do you change the sequence here? Isn't it enough to just add the
init_output before probe_pdata?

 Tomi


--=-lGgKnEtEQrpXD5R+mldQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQN34aAAoJEPo9qoy8lh717ekP/Rp1K/Z4N77ZKi36OWLhDn/1
ktp8903fL6ymHDU+HErnF0iQG0TCFvtQbhE0utYiE8YhYwWUj12Cg8V1tZKYtHLd
k0u6xaE4r0TvsAlF6LwGnP0FZeDt82pG/cdifbt15RT5F5OAqPgqxpT1bDx6GVLC
A1xXzTww6D0P58q9QvpSWHrR4cdnFDGBRzlszfd1ozjafXNlNYowl2eSh/BwyB51
0eLTjuAlag1o/8H+0G6+OejCNXtHGXD1Ci50mO7sxwgEiO98CvDypJoqlOwdwvBs
Uzh+qlBKnHohPDL6+PGYsQJtIb8oI0JmZkx+Plry/P75Sci8B2je3XYsJOpBYsdJ
LaS81HxWCeFVsU38su2UezftDRRnGF+W9oOMcpPy2EZqJVj0pyXb84a8Kxw7twmU
hbzvaNseJhws/WbUjLgcltSKvMz4CSZhTa+p/20zU/38OD8c9FPWCEwoz0FZXeZO
QnsxlxPcTELsDyM6KEKEcz0Gv/HQuPOmab0VuJlP6TI60JtPI5S7glkOG7B76CJ9
fCJ8RpnurTabX0TnV+flSHGnFb5V3tKb6FH7yc4u0o0YSw28eqg9mSa/NbV2tJbD
SKphoqu0suqRZsOoS3osjrKeKZXuoj3hEdIZ2JSGKyCsPc41ODoTpY+bT7gkWQHd
+uk7uIwcFmjfXuI9xV6Y
=T5gw
-----END PGP SIGNATURE-----

--=-lGgKnEtEQrpXD5R+mldQ--

