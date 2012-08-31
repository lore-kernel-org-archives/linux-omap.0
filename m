From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 03/23] OMAPDSS: output: Add set/unset device ops for
 omap_dss_output
Date: Fri, 31 Aug 2012 15:03:41 +0300
Message-ID: <1346414621.18766.13.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-81QbRyA+j70QRydU+a0Z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43625 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752250Ab2HaMDr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 08:03:47 -0400
Received: by lagy9 with SMTP id y9so2216140lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 05:03:44 -0700 (PDT)
In-Reply-To: <1346326845-16583-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-81QbRyA+j70QRydU+a0Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> An output entity represented by the struct omap_dss_output connects to a
> omap_dss_device entity. Add functions to set or unset an output's device.=
 This
> is similar to how managers and devices were connected previously. An outp=
ut can
> connect to a device without being connected to a manager. However, the ou=
tput
> needs to eventually connect to a manager so that the connected panel can =
be
> enabled.
>=20
> Keep the omap_overlay_manager pointer in omap_dss_device for now to preve=
nt
> breaking things. This will be removed later when outputs are supported
> completely.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/output.c |   67 ++++++++++++++++++++++++++++++++=
++++++
>  include/video/omapdss.h          |    5 +++
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/o=
utput.c
> index 7d81be5..abc3aa2 100644
> --- a/drivers/video/omap2/dss/output.c
> +++ b/drivers/video/omap2/dss/output.c
> @@ -24,9 +24,76 @@
>  #include "dss.h"
> =20
>  static LIST_HEAD(output_list);
> +static DEFINE_MUTEX(output_lock);
> +
> +static int dss_output_set_device(struct omap_dss_output *out,
> +		struct omap_dss_device *dssdev)
> +{
> +	int r;
> +
> +	mutex_lock(&output_lock);
> +
> +	if (out->device) {
> +		DSSERR("output already has device %s connected to it\n",
> +			out->device->name);
> +		r =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	if (out->type !=3D dssdev->type) {
> +		DSSERR("output type and display type don't match\n");
> +		r =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	out->device =3D dssdev;
> +	dssdev->output =3D out;
> +
> +	mutex_unlock(&output_lock);
> +
> +	return 0;
> +err:
> +	mutex_unlock(&output_lock);
> +
> +	return r;
> +}
> +
> +static int dss_output_unset_device(struct omap_dss_output *out)
> +{
> +	int r;
> +
> +	mutex_lock(&output_lock);
> +
> +	if (!out->device) {
> +		DSSERR("output doesn't have a device connected to it\n");
> +		r =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	if (out->device->state !=3D OMAP_DSS_DISPLAY_DISABLED) {
> +		DSSERR("device %s is not disabled, cannot unset device\n",
> +				out->device->name);
> +		r =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	out->device->output =3D NULL;
> +	out->device =3D NULL;
> +
> +	mutex_unlock(&output_lock);
> +
> +	return 0;
> +err:
> +	mutex_unlock(&output_lock);
> +
> +	return r;
> +}
> =20
>  void dss_register_output(struct omap_dss_output *out)
>  {
> +	out->set_device =3D &dss_output_set_device;
> +	out->unset_device =3D &dss_output_unset_device;
> +
>  	list_add_tail(&out->list, &output_list);
>  }

I don't think there's need for this indirection. We should use function
pointers only when the func pointer may lead to different functions.
Here we'll always have just one function, dss_output_set_device. We can
as well call the function directly.

I know we have similar func pointers for ovls/mgrs currently, but I
don't think they are good either. They are a relic from the time we
supported "virtual" overlays and managers, and thus could have different
implementations for the operations.

 Tomi


--=-81QbRyA+j70QRydU+a0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQKgeAAoJEPo9qoy8lh71YyEQAKypxavDyzND/su4Ro/0G8sK
77oUaBnvbY2tbRnd5v+qMHV5HR8wnNq79QbcwdHzubk9DewBG7mXaalO89zKzDWN
OsMpnuv7sBmq4vkOkE2Qiys7R4XDsnVDmECq22MdIE6Kk13JRz3hPEBv4HZ10Nua
GTaFvDBMnGnGHhWpf6Ow8QpHdl/WqJipiSuTTt6gGK9pD6TJti6v1z67gtKSiJm3
a2RN6Z07f1BoK3J2MbLE/HR9VeAuoyXsAwBIgZWZ/Hmt5W6J13IMnl4NFpcogi+t
HI1IywNhcjI+s7EobHsly2PDN281RYysleVPDD1TLAUBY9LqK2yJAtvQJYweqRqF
QZUuVQHn+K/TMDGSJ9W0vEm/ZpTSUR1LvgUEQtXBg93fOQ9W1KSL9UqXUn27Qt9n
TOn1Vt/yrPkI5wDHAve84tGzmUMmSmEHOPhjOzjmqeXfMToDTJQ6/vxkWEzkKIoa
hDHi6xHXulJa0OB1Q1vqqcs/yk2XOEjA/viX9S+MQg2aHuKk5w6fJp7DuENVexPO
EMuGDwnlLbOrrLojtEnFKjoSa7rcT4BD58ZiuhJc7UBQ0Y7v9RQnnF3+ceSCoSWn
U3V4PqF97tYgXyb93aYIeHoPDMuPLJfT6DoB/6SkV5lGmk+n/x7XIEXegg4r4auk
jaLHicsY8iALUwk1qZsh
=SDSP
-----END PGP SIGNATURE-----

--=-81QbRyA+j70QRydU+a0Z--

