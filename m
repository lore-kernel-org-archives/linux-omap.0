From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 9/9] usb: dwc3: core: don't break during
 suspend/resume while we're dual-role
Date: Wed, 2 Sep 2015 09:48:12 -0500
Message-ID: <20150902144812.GJ8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-10-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-10-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 05:24:24PM +0300, Roger Quadros wrote:
> We can't rely just on dr_mode to decide if we're in host or gadget
> mode when we're configured as otg/dual-role. So while dr_mode is
> OTG, we find out from  the otg state machine if we're in host
> or gadget mode and take the necessary actions during suspend/resume.
>=20
> Also make sure that we disable OTG irq and events during system suspend
> so that we don't lockup the system during system suspend/resume.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 654aebf..25891e3 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1455,18 +1455,15 @@ static int dwc3_suspend(struct device *dev)
>  		dwc->octl =3D dwc3_readl(dwc->regs, DWC3_OCTL);
>  		dwc->oevt =3D dwc3_readl(dwc->regs, DWC3_OEVT);
>  		dwc->oevten =3D dwc3_readl(dwc->regs, DWC3_OEVTEN);
> +		dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
> +		disable_irq(dwc->otg_irq);

you don't need disable_irq() here. In fact, it causes problems since
you're calling it with IRQs disabled.

>  	}
> =20
> -	switch (dwc->dr_mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -	case USB_DR_MODE_OTG:
> +	if (dwc->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL ||
> +	    ((dwc->dr_mode =3D=3D USB_DR_MODE_OTG) && (dwc->fsm->protocol =3D=
=3D PROTO_GADGET)))
>  		dwc3_gadget_suspend(dwc);
> -		/* FALLTHROUGH */
> -	case USB_DR_MODE_HOST:
> -	default:
> -		dwc3_event_buffers_cleanup(dwc);
> -		break;
> -	}
> +
> +	dwc3_event_buffers_cleanup(dwc);
> =20
>  	dwc->gctl =3D dwc3_readl(dwc->regs, DWC3_GCTL);
>  	spin_unlock_irqrestore(&dwc->lock, flags);
> @@ -1506,18 +1503,12 @@ static int dwc3_resume(struct device *dev)
>  		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
>  		dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);
>  		dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
> +		enable_irq(dwc->otg_irq);
>  	}
> =20
> -	switch (dwc->dr_mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -	case USB_DR_MODE_OTG:
> +	if (dwc->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL ||
> +	    ((dwc->dr_mode =3D=3D USB_DR_MODE_OTG) && (dwc->fsm->protocol =3D=
=3D PROTO_GADGET)))
>  		dwc3_gadget_resume(dwc);
> -		/* FALLTHROUGH */
> -	case USB_DR_MODE_HOST:
> -	default:
> -		/* do nothing */
> -		break;
> -	}
> =20
>  	spin_unlock_irqrestore(&dwc->lock, flags);
> =20
> --=20
> 2.1.4
>=20

--=20
balbi

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5wwsAAoJEIaOsuA1yqREA2AP/0vBSUv5E34nqJQypdiFVQ3b
8QMQCrNaQtvPhVstEU0tdIBDkWd3XvRazEVjsoY/lvQ20dL9PCQg8UeHJnoOHPZ5
o8U0HuBxIVPAhmzYTEKyIuWNddK1VFRrFS9wwG1NHeMSBHvCfC3yq++73nqRB2tl
AmEyCZXFTktxJDjK8P/SL1Zz3/mdawC16h8eWh2YryZR+YNIoju3+O1eCHtps//E
4rNujFvAjg+34C0G7toreLHItQRnYCGDTx1qRkqCsLvmyPFJc0DLK517IbH83OOk
z7NYur7NV50T/g0EKK/oJmmN2HHpP/39dAXenh6WR6/nEB5gX0XesX6vsKVxRgAf
PUFzJqkHUpE+IfxkL/FOPeh7Ak6pRfL/iod5bJY4PmL3ArG1ciaNDLB/qBt3ER/n
996p2sKqlu6F82szNtHkhGeBq8s+hVQjKfrlZQeHABb7zhZOYPMMw7/TsutrL7TS
hUrvd2b6ZWvpC/CQkxA8x01MGvCdAWAEmLIrVokaZPybcIwOfnS9ndcWgUJwgk8E
ii2TbTwymN5mmGCn6wBivLhHxqX10sxr9+KVghCylPSn2hBxy6cHE1ck40d0GlEW
M33ecRugZMl+hxiHCoEMBu626acAUoNYqi0DKuPWG5OJBwKZuMDCleniGeE/oerg
CWqnQjv8GSBgIrCuF9KA
=I90N
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
