From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: dwc3: gadget: Fix TRB preparation during SG
Date: Mon, 22 Dec 2014 10:04:31 -0600
Message-ID: <20141222160431.GC12815@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <1908f9be4bfb2148b4d2efa2dbc6de88c204e7f4.1418972323.git.amit.virdi@st.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075AbaLVQEw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Dec 2014 11:04:52 -0500
Content-Disposition: inline
In-Reply-To: <1908f9be4bfb2148b4d2efa2dbc6de88c204e7f4.1418972323.git.amit.virdi@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, pratyush.anand@gmail.com, ajay.khandelwal@st.com

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 12:40:15PM +0530, Amit Virdi wrote:
> When scatter gather is used, multiple TRBs are prepared from one DWC3 req=
uest.
> Hence, we must set the 'last' flag when the SG is last as well as the TRB=
 is
> last. The current implementation uses list_is_last to check if the dwc3_r=
equest
> is the last request in the request_list.
>=20
> This doesn't work when SG is used. This is because, when it is the last r=
equest,
> the first TRB preparation (in dwc3_prepare_one_trb) modifies the dwc3_req=
uest
> list's next and prev pointers while moving the URB to req_queued.
>=20
> Hence, list_is_last always return false no matter what. The correct way i=
s not
> to access the modified pointers of dwc3_request but to use list_empty mac=
ro
> instead.
>=20
> Fixes: e5ba5ec833aa4a76980b512d6a6779643516b850 ("usb: dwc3: gadget: fix =
scatter
> gather implementation"
>=20
> Signed-off-by: Amit Virdi <amit.virdi@st.com>

you need to Cc stable here and make sure you point out which kernel
versions this should be backported to. Looks like this sould be:

Cc: <stable@vger.kernel.org> # v3.9+

Also, how have you tested this ? I need a test case to make sure it
fails here and this patch really fixes the problem.

> ---
>  drivers/usb/dwc3/gadget.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index f03b136ecfce..0eec2e917994 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bo=
ol starting)
> =20
>  				if (i =3D=3D (request->num_mapped_sgs - 1) ||
>  						sg_is_last(s)) {
> -					if (list_is_last(&req->list,
> -							&dep->request_list))
> +					if (list_empty(&dep->request_list))
>  						last_one =3D true;
>  					chain =3D false;
>  				}
> --=20
> 1.8.0
>=20

--=20
balbi

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmEEPAAoJEIaOsuA1yqRE3YUP/18sGFFD28fb7mjy5f8gYRww
g4IihSyMS/3PXydcAX++0dxXlQeGPeWq5Xh1kZ77K5dFduKB7nmmJ8K+gdkQ15aY
4oK90N4Yq2SQbXTjD3P2b+kwLo9bKfehkVyV+E+nzABokLP3OH02bBwjVaUhBYqh
qq6MPWffH9xX/zCu3YX/Ue2nHOXpwThAh/vZIMDPVOdCVZIIEhOGPme0Dkl5rAPr
eWXdd2x9sV3y9g1Tym5+wdqYP/dj0gXZVZ8N/w7YveAlAg4zU17h2JkLNMehC2Rk
s10Nt7Md9ajxnobPtHD1rDt+4MazMuoDGwQ/Tr8ezUo2TsEgDainMNnroXQJO8pn
kIjRKc9Kcq/FBtOdUkMP6FkozNZ5WaI4HLnp9h9FdiygnrsLpq0187b+nqyXmcfT
irUy2RjO7PGZfBIc1Fd3RD0iDDGGKUnralqcDWsx98vPtyWTlefZe9I3lgPKNjYK
VW1LFcxp8vV7htjofeNWI35QzXjRLTO3Vde+MdYcS1KUp192JD6FeKDOnKxn7cEw
wPSaY5oz7auHQSniF5sIrUqh72SULo0lth2VvByPPeVdQxTozcz09aZdnshdePZk
BrCgKlMITnSx00qnHs7iZKFm3yLsD+ujcf5L8V3irgUY1DAR9gbixvJ60CQHHj8x
6oZ/AhRkV66NNJFKP1Wx
=HUSy
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
