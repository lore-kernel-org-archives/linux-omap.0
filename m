From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 8/9] usb: dwc3: core: Prevent otg events from
 disabling themselves
Date: Wed, 2 Sep 2015 09:47:05 -0500
Message-ID: <20150902144705.GI8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-9-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-9-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 05:24:23PM +0300, Roger Quadros wrote:
> There is a race happening during dwc3_drd_init() that causes
> otg events to get disabled. This is what happens.
>=20
> dwc3_otg_irq() happens immediately when PRTCAP is set to OTG,
> even though OEVTEN is 0. This is because BIT 31 IRQ of
> OEVT can't be disabled by OEVTEN.
> We configure OEVTEN in dwc3_otg_init() but dwc3_otg_irq() has
> already saved OEVTEN as 0 into dwc->oevten. So finally when
> dwc3_irq_thread_irq() is called we save 0 into OEVTEN
> thus disabling OTG irqs forever.
>=20
> We fix this by disabling IRQs when configuring OEVTEN in
> dwc3_otg_init().
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

can't you just merge this patch into the one which introduced the bug to
start with ?

> ---
>  drivers/usb/dwc3/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 684010c..654aebf 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -921,6 +921,7 @@ static int dwc3_drd_init(struct dwc3 *dwc)
>  	int ret, id, vbus;
>  	struct usb_otg_caps *otgcaps =3D &dwc->otg_config.otg_caps;
>  	u32 reg;
> +	unsigned long flags;
> =20
>  	otgcaps->otg_rev =3D 0;
>  	otgcaps->hnp_support =3D false;
> @@ -993,6 +994,8 @@ try_otg_core:
>  		goto error;
>  	}
> =20
> +	spin_lock_irqsave(&dwc->lock, flags);
> +
>  	/* we need to set OTG to get events from OTG core */
>  	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>  	/* GUSB2PHYCFG0.SusPHY=3D0 */
> @@ -1018,6 +1021,8 @@ try_otg_core:
>  	/* OCTL.PeriMode =3D 1 */
>  	dwc3_writel(dwc->regs, DWC3_OCTL, DWC3_OCTL_PERIMODE);
> =20
> +	spin_unlock_irqrestore(&dwc->lock, flags);
> +
>  	dwc3_otg_fsm_sync(dwc);
>  	usb_otg_sync_inputs(dwc->fsm);
> =20
> --=20
> 2.1.4
>=20

--=20
balbi

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5wvpAAoJEIaOsuA1yqREhgQP/RUhDhQZJCvaeKkyOMA7gXOs
VbLt3ymtkPiJh29q3LkKka1PufA7oxK/rmCMtxFdDu94VwMWKc5Q2iRYpvcdBPvl
uT6niPlGip9BXpukZydfBFbpZALlLVPTVlPS8K+t4KndkZa0i8myVWpN6LmPwiV8
ah+pQF96tdZAZU9d7/+lKFFZMh+aLy1/LeDq2Gzj4c6orSqt63xLw5Ea76VSETyS
J+xdy+OWAmM/FbXQhxYgRA1rBZcqiXTCwV80W+v+Ry4Qx8+FW1b1pq6vYukBxsQn
uanyi5iavwvKfHxReaskpmuYIQx6aL8mNR1K76jHooFLO24EUhPzULvkLpDafJ4g
eBozJYQh5wJ9eQX1y3pxwaVVk1LTgsbpW5rqfpmScVKrp07jnRitvtzEQBzaVBsH
cRMd4F+SvZgBEGmj/qB/536+eycsjilNYWeu4M2Rob+tYNqmbR8lF56qnQqtBMWB
PERo1f1btHfrx5hl0DSS1LEPa9qvOJlPrv6+WRfOTYagIGDbV6RWGrU/9CNfWVnL
6ifJR49vs/eln1PauFZO06RKqMD9aFgjXYtgoiBRE0mDN2qysKP461OyFhgpLWDi
35jnrV1vtWDtJHdlojCa2+EyBlCCbwRc32zZ70+y6dBminqL95Clljeg0cY5gE6D
PlagW0xjysXsh80P7Kfg
=didd
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
