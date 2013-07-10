From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] musb: omap: Fix: pass all the resources to musb core
Date: Wed, 10 Jul 2013 14:27:46 +0300
Message-ID: <20130710112746.GA18966@arwen.pp.htv.fi>
References: <51DAAEEA.60409@cogentembedded.com>
 <1373453962-21344-1-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373453962-21344-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, inux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 04:29:22PM +0530, Kishon Vijay Abraham I wrote:
> commit 09fc7d (usb: musb: fix incorrect usage of resource pointer)
> assumes musb core will always have only 2 resources. But for OMAP
> platforms there can be 3 resources (2 irq resource and 1 iomem
> resource). Fixed it here.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
> Changes from v1:
> *) Removed redundant initialization of *i*
>=20
>  drivers/usb/musb/omap2430.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 5b6113a..5bbef78 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -481,7 +481,7 @@ static u64 omap2430_dmamask =3D DMA_BIT_MASK(32);
> =20
>  static int omap2430_probe(struct platform_device *pdev)
>  {
> -	struct resource			musb_resources[2];
> +	struct resource			musb_resources[3];
>  	struct musb_hdrc_platform_data	*pdata =3D pdev->dev.platform_data;
>  	struct omap_musb_board_data	*data;
>  	struct platform_device		*musb;
> @@ -489,6 +489,7 @@ static int omap2430_probe(struct platform_device *pde=
v)
>  	struct device_node		*np =3D pdev->dev.of_node;
>  	struct musb_hdrc_config		*config;
>  	int				ret =3D -ENOMEM;
> +	int				i;
> =20
>  	glue =3D devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
>  	if (!glue) {
> @@ -571,15 +572,12 @@ static int omap2430_probe(struct platform_device *p=
dev)
>  	memset(musb_resources, 0x00, sizeof(*musb_resources) *
>  			ARRAY_SIZE(musb_resources));
> =20
> -	musb_resources[0].name =3D pdev->resource[0].name;
> -	musb_resources[0].start =3D pdev->resource[0].start;
> -	musb_resources[0].end =3D pdev->resource[0].end;
> -	musb_resources[0].flags =3D pdev->resource[0].flags;
> -
> -	musb_resources[1].name =3D pdev->resource[1].name;
> -	musb_resources[1].start =3D pdev->resource[1].start;
> -	musb_resources[1].end =3D pdev->resource[1].end;
> -	musb_resources[1].flags =3D pdev->resource[1].flags;
> +	for (i =3D 0; i < ARRAY_SIZE(musb_resources); i++) {

then this is not enough, what if one device using omap2430.c has 2
resources and the other has 3 ? and what if a new one has 4 ?

How about using pdev->num_resources to dynamically allocate
musb_resources array and using the same thing iterate here ?

Something like:

	struct resource		*musb_resources;

	musb_resources =3D kcalloc(pdev->num_resources, struct resource, GPF_KERNE=
L);
	if (!musb_resources)
		bail();

	for (i =3D 0; i < pdev->num_resources, i++) {
		musb_resources[i].name =3D pdev->resource[i].name;
		musb_resources[i].start =3D pdev->resource[i].start;
		musb_resources[i].end =3D pdev->resource[i].end;
		musb_resources[i].flags =3D pdev->resource[i].flags;
	}

cheers

--=20
balbi

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3UUyAAoJEIaOsuA1yqREvyAP/i0pdnWHE6PbzkpzRPqssHRS
P9nq/YStbjHSC5wDSkJfoNVHf1xQIWrbPAP711Hzav5oKjK7rg1ZmHk2oD4gAsu9
DdfTdDClMks3XkGkPRbNTVcmYNXgcernwgjWRQy95l3uFbFpvlWMvBHkI+wx1xcW
MNlDwrzYAjoZDuyUvvurL/j9FMuB6A1U00H6wMB9ksNFscOyj8QiFsjP+Z/jz5vD
WFqfLfeMe/TxfQs48iTvVZ2DfTOiKOOyRnJExd/DnqZewrfaXo+Gs4M0YktNBa9A
BvCrs7Bhya9tSzGaLsPqSGYY9Cb3+UPnNnNFHGItFJIEp5bQ+Q0ZGsBWaNO03fvU
acDF55qhjsyx2/vVRzO+XFNoQs9TN94iuBc+AhdJYXErxtQLNdPnIfeDOLmVtpTm
q6reeLNd6FRW3y5c43pFc2FPb9i+NETUrfF4gfVHhSMvyYmbdFTs2rmClvUiXDV5
7n+Bef/W/Nn2fpbkfdJYnTFEauhTgFcNCwkpsMlaQxLO8XA89w+HfrmYK7UEmupT
OsQ3gCh4xNAqG4KQEloLajodRT+PcEdYdYXbYqYFU/EH+EtcF6UwPXgkX1dWOBki
u10IPBA/RGUufYf6eramGLyuO5flNZ9z54jSYC9olBsQqxIbgAgLCZF+Kxtvdwpy
yaqP2JmLBrve6ASuZeTP
=APEF
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
