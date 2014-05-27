From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC v2 2/5] OMAPDSS: DT: Get source endpoint by matching reg-id
Date: Tue, 27 May 2014 11:34:28 +0300
Message-ID: <53844E14.9090504@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com> <1401096492-1405-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3wLVptKweKOLwdbKwWDBuRt6wf30qs4E4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbaE0Ieb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 04:34:31 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4R8YULW021107
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 03:34:30 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4R8YUWm019682
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 03:34:30 -0500
In-Reply-To: <1401096492-1405-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

--3wLVptKweKOLwdbKwWDBuRt6wf30qs4E4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/05/14 12:28, Archit Taneja wrote:
> In omapdss_of_find_source_for_first_ep, we retrieve a source endpoint's=
 DT node,
> and then see what omapdss output has the matching device_node pointer i=
n
> omap_dss_find_output_by_node.
>=20
> For all DPI and SDI outputs, the device_node pointer is set as the pare=
nt's DSS
> device_node pointer. If the source is one of these outputs, the above m=
ethod
> won't work.
>=20
> To get the correct output for ports within DSS(and in other cases in th=
e future,
> where multiple ports might be under one device), we require additional
> information which is exclusive to the output port.
>=20
> We create a new field in omap_dss_device called 'port_num', this provid=
es port
> number of the output port corresponding to this device. When searching =
for the
> source endpoint in DT, we extract the 'reg' property from the port corr=
esponding
> to the endpoint source. From the list of registered outputs, we pick ou=
t that
> output which has both dev->of_node and port_num matching with the devic=
e_node
> pointer and 'reg' of the source endpoint node from DT.
>=20
> For encoder blocks(the ones which have both an input and output port), =
we need
> to set the port_num as the 'reg' property for the output port as define=
d in the
> DT bindings. We set port_num to 1 in the tfp410 and tpd12s015 encoder d=
rivers.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  .../fbdev/omap2/displays-new/encoder-tfp410.c      |  1 +
>  .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |  1 +
>  drivers/video/fbdev/omap2/dss/dss-of.c             | 51 ++++++++++++++=
+++-----
>  drivers/video/fbdev/omap2/dss/output.c             |  8 ++--
>  include/video/omapdss.h                            |  7 ++-
>  5 files changed, 52 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/=
drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
> index b4e9a42..d927455 100644
> --- a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
> +++ b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
> @@ -249,6 +249,7 @@ static int tfp410_probe(struct platform_device *pde=
v)
>  	dssdev->output_type =3D OMAP_DISPLAY_TYPE_DVI;
>  	dssdev->owner =3D THIS_MODULE;
>  	dssdev->phy.dpi.data_lines =3D ddata->data_lines;
> +	dssdev->port_num =3D 1;
> =20
>  	r =3D omapdss_register_output(dssdev);
>  	if (r) {
> diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c=
 b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> index 7e33686..9e25fe7 100644
> --- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> +++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
> @@ -389,6 +389,7 @@ static int tpd_probe(struct platform_device *pdev)
>  	dssdev->type =3D OMAP_DISPLAY_TYPE_HDMI;
>  	dssdev->output_type =3D OMAP_DISPLAY_TYPE_HDMI;
>  	dssdev->owner =3D THIS_MODULE;
> +	dssdev->port_num =3D 1;
> =20
>  	in =3D ddata->in;
> =20
> diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbd=
ev/omap2/dss/dss-of.c
> index a4b20aa..8ba43faa 100644
> --- a/drivers/video/fbdev/omap2/dss/dss-of.c
> +++ b/drivers/video/fbdev/omap2/dss/dss-of.c
> @@ -132,28 +132,55 @@ EXPORT_SYMBOL_GPL(omapdss_of_get_first_endpoint);=

>  struct omap_dss_device *
>  omapdss_of_find_source_for_first_ep(struct device_node *node)
>  {
> -	struct device_node *ep;
> -	struct device_node *src_node;
> +	struct device_node *ep, *port_ep;
> +	struct device_node *src_node, *src_port;
>  	struct omap_dss_device *src;
> +	int r;
> +	u32 reg;
> =20
>  	ep =3D omapdss_of_get_first_endpoint(node);
> -	if (!ep)
> -		return ERR_PTR(-EINVAL);
> +	if (!ep) {
> +		r =3D -EINVAL;
> +		goto err_first_ep;
> +	}
> =20
>  	src_node =3D omapdss_of_get_remote_device_node(ep);
> +	if (!src_node) {
> +		r =3D -EINVAL;
> +		goto err_src_node;
> +	}
> =20
> -	of_node_put(ep);
> -
> -	if (!src_node)
> -		return ERR_PTR(-EINVAL);
> +	port_ep =3D of_parse_phandle(ep, "remote-endpoint", 0);
> +	if (!port_ep) {
> +		r =3D -EINVAL;
> +		goto err_port_ep;
> +	}
> =20
> -	src =3D omap_dss_find_output_by_node(src_node);
> +	src_port =3D of_get_next_parent(port_ep);
> +	if (!src_port) {
> +		r =3D -EINVAL;
> +		goto err_src_port;
> +	}
> =20
> -	of_node_put(src_node);
> +	r =3D of_property_read_u32(src_port, "reg", &reg);
> +	if (r) {
> +		r =3D 0;
> +		reg =3D 0;
> +	}
> =20
> +	src =3D omap_dss_find_output_by_node_and_reg(src_node, reg);
>  	if (!src)
> -		return ERR_PTR(-EPROBE_DEFER);
> +		r =3D -EPROBE_DEFER;

Hmm, maybe the above function, and the helper functions, should be
changed a bit more, so that this function would do:

ep =3D omapdss_of_get_first_endpoint(node);
src_port =3D omapdss_of_get_remote_port(ep);
src =3D omap_dss_find_output_by_port_node(src_port);

 Tomi



--3wLVptKweKOLwdbKwWDBuRt6wf30qs4E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThE4UAAoJEPo9qoy8lh71BD0P/i53F1RbAapsY554VsHg7BbN
sYCaD5nI4hyU28LH8mpg17DjFJmHvgGBJMt2Vu2LpWYbKpdG+vQrAPxQsDPZVvkK
GUoHRQHP5hhiWAfdx1RbtYIwvVjIkxO7Fd9JFWRpZhjWJsv1HpiBFa0mAouN+WBS
wnzKGx6RLCO2AtSRYM1FSf7uFW1kUGPETHk3FFmjUQHV99b/vO4XNSXKLKRV7f3f
8wbNqy0+PmlCRUtycOyscRYLAqEpbZChejlV4QCCkRjYmx0kj9WU6/QaY89cVdwk
mTtKLoY3QYGSOt4//90QiVkbhMh2LAxO0hOXGOcgnJm5wRe2Rjxcz8X1AeDqt3FR
rwGzEBJLkVK1oo819Z/VOD96zbyI0TXHVrLOOlhEW0j62QcwMf6/p7ov3xL40CWo
3PEv7oIyjENlKTLRDfB4DH+A1iVVvczRGNmM75lFOqyZNitx+baqzK+XX+6FtYd8
pzZEXVFOdN2blr53jdBbRoH+EOYYxHwbqlWoCWYMAXFc2L906kz0GhUCOxpLEbd6
LIGkISNdw27CrysdVqA5U+M1sDJUxprtyRuw4vN0UiUkL+6iC7kCYMZ52oyOlZCj
GU1S5Wi6Id5CUyXm8Gf8kyR1nJNaKDRQAg7YefcMQv3X7vyTXUpMhmv78F6ZcxSK
apUoSCR8r+b0SWU9yH5G
=Uer8
-----END PGP SIGNATURE-----

--3wLVptKweKOLwdbKwWDBuRt6wf30qs4E4--
