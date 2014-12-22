From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Mon, 22 Dec 2014 10:06:26 -0600
Message-ID: <20141222160626.GD12815@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60428 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280AbaLVQGr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Dec 2014 11:06:47 -0500
Content-Disposition: inline
In-Reply-To: <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, pratyush.anand@gmail.com, ajay.khandelwal@st.com

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 12:40:16PM +0530, Amit Virdi wrote:
> When SG is used, there are two loops iterating to prepare TRBs:
>  - Outer loop over the request_list
>  - Inner loop over the SG list
>=20
> The driver must stop preparing TRBs when the max TRBs have been prepared.=
 The
> code was missing break to get out of the outer loop.
>=20
> Signed-off-by: Amit Virdi <amit.virdi@st.com>

which bug is this fixing ? Which kernels are affected ? This need to be
backported to which kernel ? Which commit introduced this bug ? How can
I validate this to be a valid fix ?

> ---
>  drivers/usb/dwc3/gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 0eec2e917994..8f65ab3a3b92 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -900,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bo=
ol starting)
>  				if (last_one)
>  					break;
>  			}
> +
> +			if (last_one)
> +				break;
>  		} else {
>  			dma =3D req->request.dma;
>  			length =3D req->request.length;
> --=20
> 1.8.0
>=20

--=20
balbi

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmEGCAAoJEIaOsuA1yqRE4d8P/1KgZijCIGZZrXsKJOR17Q05
TCvxU8xcJqAO4v98+UcH7QpLnXuCM0Wk8zFVI76gPcEgLwZ01CG3ndeXVGDUUVrp
bIFgZoouodDNccwReuMUDvYaki6ZzTWY4QfENtaQA77VhU3TR1j1QB6+cr4koRLT
1Ju+pcWHSFu+yPq9h9nFnlyGrHlWVhZ5dfwX/seqfSTovlujL1enHvoba723AP7X
yQq3OgVI/DFIFsaKbPjru+49dFWZ56m/J/mvViNAII+JiFbOYsy0ETLcIklcskd8
sclKIzRG+7NcVvlJahnCn1E4sVq07wvwEBzKehSvQ9ZJRVlyx7W1LSBhd8stn3gc
RcAF3NtYdhGB1jpCzEKpF6FntTCBKfH3DXEMStUkb3FV95flHw8ccJ4cL4x8QiY0
CdU9FbuGgvTLjUdLN1ACqtHSUajLXveq+CZv65pH2Q0/NRFaBWwpY/DXneLgGHpH
1aR1ERnOAx2E+kzlzlWKOs0BKy/Au1tHTavkwnHdeK+99m4I6GwivVonwxe091O+
7v5wjS66gWnk8sbyP4Jq1WSi2KEdHSDYvsiYJ8K5sWfTEpCHw3qARYm0GdAwz+yJ
awX4QToB6FZw0LJlWgJBHtq36m73eebKFfB1RkTHZPwQVvA8iZYGVBVCCZc655m5
MbAGTeBjRCKKU3axF3OQ
=fFTf
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
