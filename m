From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Add chained TRB support for ep0
Date: Fri, 6 Feb 2015 08:48:41 -0600
Message-ID: <20150206144841.GB16783@saruman.tx.rr.com>
References: <1423223735-32512-1-git-send-email-kishon@ti.com>
 <1423223735-32512-2-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423223735-32512-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 06, 2015 at 05:25:35PM +0530, Kishon Vijay Abraham I wrote:
> dwc3 can do only max packet aligned transfers. So in case request length
> is not max packet aligned and is bigger than DWC3_EP0_BOUNCE_SIZE
> two chained TRBs is required to handle the transfer.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> *) Did eumeration testing with g_zero in kernel
> *) Similar patch was added in u-boot. With DFU, was able to create a scen=
ario
> where the request length is not max packet aligned and is bigger than
> DWC3_EP0_BOUNCE_SIZE (512 bytes). In that case, 2 chained TRBs will be us=
ed.

I really need a test case for this. If you have to patch g_zero to have
a configuration descriptor so large that it's over 512, so be it, but I
really need to have a test case exposing the problem.

I also need you to run full USB30CV (for USB2 and USB3 device), together
with Link Layer Tests (on USB3-only, clearly) using USB30CV and LeCroy's
compliance suite (there's a slight difference from USB30CV and LeCroy's
compliance, we must work with both because both are accepted test
vectors per USB-IF).

> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 24b7925..3b728b8 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_=
state state)
>  }
> =20
>  static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t b=
uf_dma,
> -		u32 len, u32 type)
> +		u32 len, u32 type, unsigned chain)
>  {
>  	struct dwc3_gadget_ep_cmd_params params;
>  	struct dwc3_trb			*trb;
> @@ -70,7 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 e=
pnum, dma_addr_t buf_dma,
>  		return 0;
>  	}
> =20
> -	trb =3D dwc->ep0_trb;
> +	trb =3D &dwc->ep0_trb[dep->free_slot];
> +
> +	if (chain)
> +		dep->free_slot++;
> =20
>  	trb->bpl =3D lower_32_bits(buf_dma);
>  	trb->bph =3D upper_32_bits(buf_dma);
> @@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 =
epnum, dma_addr_t buf_dma,
>  	trb->ctrl =3D type;
> =20
>  	trb->ctrl |=3D (DWC3_TRB_CTRL_HWO
> -			| DWC3_TRB_CTRL_LST
> -			| DWC3_TRB_CTRL_IOC
>  			| DWC3_TRB_CTRL_ISP_IMI);
> =20
> +	if (chain)
> +		trb->ctrl |=3D DWC3_TRB_CTRL_CHN;
> +	else
> +		trb->ctrl |=3D (DWC3_TRB_CTRL_IOC
> +				| DWC3_TRB_CTRL_LST);
> +
> +	if (chain)
> +		return 0;
> +
>  	memset(&params, 0, sizeof(params));
>  	params.param0 =3D upper_32_bits(dwc->ep0_trb_addr);
>  	params.param1 =3D lower_32_bits(dwc->ep0_trb_addr);
> @@ -302,7 +312,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>  	int				ret;
> =20
>  	ret =3D dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
> -			DWC3_TRBCTL_CONTROL_SETUP);
> +			DWC3_TRBCTL_CONTROL_SETUP, false);
>  	WARN_ON(ret < 0);
>  }
> =20
> @@ -817,6 +827,22 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
> =20
>  	maxp =3D ep0->endpoint.maxpacket;
> =20
> +	/* Handle the first TRB before handling the bounce buffer if the request
> +	 * length is greater than the bounce buffer size
> +	 */
> +	if (!IS_ALIGNED(ur->length, maxp) &&
> +	    ur->length > DWC3_EP0_BOUNCE_SIZE) {
> +		transfer_size =3D (ur->length / maxp) * maxp;

you can use ALIGN() for this which is more efficient. Note however that
this is not safe, see below.

> +		transferred =3D transfer_size - length;
> +		buf =3D (u8 *)buf + transferred;
> +		ur->actual +=3D transferred;

this is dangerous. The extra size is because you *must* align OUT to
wMaxPacketSize, so you cannot allow more than the original req->length
to be copied into buf. That bounce buffer, is really supposed to be a
throw-away buffer and should never have data in it. You should really
add a big fat WARN() if transferred > req->length.

The thing is that if host sends more data than we were expecting, this
could be someone trying to use our driver as an exploit vector, trying
to send more data than it should. We must be robust against that.

> +
> +		trb++;
> +		length =3D trb->size & DWC3_TRB_SIZE_MASK;
> +
> +		ep0->free_slot =3D 0;
> +	}
> +
>  	if (dwc->ep0_bounced) {
>  		transfer_size =3D roundup((ur->length - transfer_size),
>  					maxp);
> @@ -844,7 +870,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
> =20
>  			ret =3D dwc3_ep0_start_trans(dwc, epnum,
>  					dwc->ctrl_req_addr, 0,
> -					DWC3_TRBCTL_CONTROL_DATA);
> +					DWC3_TRBCTL_CONTROL_DATA, false);
>  			WARN_ON(ret < 0);
>  		}
>  	}
> @@ -928,7 +954,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *d=
wc,
>  	if (req->request.length =3D=3D 0) {
>  		ret =3D dwc3_ep0_start_trans(dwc, dep->number,
>  				dwc->ctrl_req_addr, 0,
> -				DWC3_TRBCTL_CONTROL_DATA);
> +				DWC3_TRBCTL_CONTROL_DATA, false);
>  	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
>  			&& (dep->number =3D=3D 0)) {
>  		u32	transfer_size =3D 0;
> @@ -941,22 +967,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 =
*dwc,
>  			return;
>  		}
> =20
> -		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
> -
>  		maxpacket =3D dep->endpoint.maxpacket;
> +
> +		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
> +			transfer_size =3D (req->request.length / maxpacket) *
> +						maxpacket;
> +			ret =3D dwc3_ep0_start_trans(dwc, dep->number,
> +						   req->request.dma,
> +						   transfer_size,
> +						   DWC3_TRBCTL_CONTROL_DATA,
> +						   true);

I would prefer to split this even further. First add the new chain
parameter, then make use of it. This means that anywhere chain is false,
would not be part of $subject.

--=20
balbi

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1NRJAAoJEIaOsuA1yqREehMP/1UTrWsjs3LL0sFf4O3ZMb/J
5senPv7vLMzOFljyIXSBODGzyX7bT4GBu7viTH/YD0JJNQL1OlXLcM4MkAzppruO
7HzfUL/uA0Bu6Np+BLzO70CsmofGHtXszCdTCrtM3uXPzzD/cSbIhKZtRnYLRuYT
k3W9rwvvJlbdqSls6hfJkbtpJuSLzbLEbX08s9xBF0G5PHlsu203gvYY2Ef3hjY/
gaIThdVwIEb+khJ9OXioLY+o1vecy6EfMJJt8zwq0F3baai69g9MU9EYAlVHwDr0
Io6/9eBfNrGi23KpfubEGdkwxsqAnRmyRkKNx9zJ5r7Cd988P+fujt4Ol8w9+/BH
JEc21wB4eznjJhOdtZrTi8OGFm3Ygu2Uqs0KJPrExLwed1v1xuIMIPBYxMOpMVVM
ZM/NsE1DdIimynQKA5GaNJou7b4BbNxmc2WSlY7dzpH+5UVSU2Nvb/4YxTQq9Uks
CfSaHmBY2nBSUJ//Jyx9BzGUeOkRBWZvZtImCnpsrhiJx7Q0+YjxChKADvVXLP+j
Ql2ZgfkwCFFt3SPGDTBos3lVigZQsLPY4uELG/l2bgsjSDR8g3pM1E590J6QJ2MC
MSqZLWxeyKIGwxUwVEMEbOPKycm6T16EopS9lzW0RvnWPVHGLi0s1EVxWnhGuvnc
Q+IhRqDKhfS1bDbN4DyE
=xDfb
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
