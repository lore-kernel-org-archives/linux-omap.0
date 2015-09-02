From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 6/9] usb: dwc3: save/restore OTG registers during
 suspend/resume
Date: Wed, 2 Sep 2015 09:44:32 -0500
Message-ID: <20150902144432.GH8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-7-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-7-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 05:24:21PM +0300, Roger Quadros wrote:
> Without this we loose OTG controller register context and malfunction
> after a system suspend-resume.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.c | 17 +++++++++++++++++
>  drivers/usb/dwc3/core.h |  6 +++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 632ee53..684010c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -56,6 +56,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>  	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
>  	reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
>  	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
> +	dwc->current_mode =3D mode;
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>  }
> =20
> @@ -1443,6 +1444,14 @@ static int dwc3_suspend(struct device *dev)
> =20
>  	spin_lock_irqsave(&dwc->lock, flags);
> =20
> +	/* Save OTG state only if we're really using it */
> +	if (dwc->current_mode =3D=3D DWC3_GCTL_PRTCAP_OTG) {
> +		dwc->ocfg =3D dwc3_readl(dwc->regs, DWC3_OCFG);
> +		dwc->octl =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> +		dwc->oevt =3D dwc3_readl(dwc->regs, DWC3_OEVT);

oevt is what you use to clear pending IRQs, which means that ...

> +		dwc->oevten =3D dwc3_readl(dwc->regs, DWC3_OEVTEN);
> +	}
> +
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
>  	case USB_DR_MODE_OTG:
> @@ -1486,6 +1495,14 @@ static int dwc3_resume(struct device *dev)
>  	dwc3_event_buffers_setup(dwc);
>  	dwc3_writel(dwc->regs, DWC3_GCTL, dwc->gctl);
> =20
> +	/* Restore OTG state only if we're really using it */
> +	if (dwc->current_mode =3D=3D DWC3_GCTL_PRTCAP_OTG) {
> +		dwc3_writel(dwc->regs, DWC3_OCFG, dwc->ocfg);
> +		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
> +		dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);

=2E.. you could be clearing pending IRQs right here.

> +		dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
> +	}
> +
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
>  	case USB_DR_MODE_OTG:
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 129ef37..1115ce0 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -737,6 +737,7 @@ struct dwc3_scratchpad_array {
>   * @regs: base address for our registers
>   * @regs_size: address space size
>   * @oevten: otg interrupt enable mask copy
> + * @current_mode: current mode of operation written to PRTCAPDIR
>   * @nr_scratch: number of scratch buffers
>   * @num_event_buffers: calculated number of event buffers
>   * @u1u2: only used on revisions <1.83a for workaround
> @@ -858,9 +859,12 @@ struct dwc3 {
>  	/* used for suspend/resume */
>  	u32			dcfg;
>  	u32			gctl;
> -
> +	u32			ocfg;
> +	u32			octl;
> +	u32			oevt;
>  	u32			oevten;
> =20
> +	u32			current_mode;
>  	u32			nr_scratch;
>  	u32			num_event_buffers;
>  	u32			u1u2;
> --=20
> 2.1.4
>=20

--=20
balbi

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5wtQAAoJEIaOsuA1yqREtLMP/1Imo+MlV1lIoNsNMHIFGUQx
ttPrH4M9dUMdcN91jKza6QT2rQEk/S2WbHouAMpWZhfcmm+F+q/wLE07RsTWC0Tb
4wE2isC8tJe9gw8ZUuk7IM2AcZguhMqN49Nwqaz0It0XKdnfPZTdGnqKsWE26Jxv
kGGu8CmI4a/ekqaqnGwwnXa1KP4UYUjn4uImPx0Oxq4CoW0i1rpq8qTA3d9rWXKk
oLZLc/HRbJXZBqLHIDR6fJhnnbKufaoQcd2ZBdBWTfBC3hR3EA1jXjEbfl1L02iJ
45VJxBZ/Qb1L2A4aD1MtznWckBQBB1xa5PAJeE2aTst0at2ChckQsl797JfbjwvN
EolYdavbca8w2Rj1xRZmKwhbmnrDUYCvGhuWJuoDiXFi2J/hdwnQrFdQWT4LZ6dq
GR5UKD3Z4QkrjKOy7NlKYUgW2Fyf/VdJFZJGKoi+n3sqcd25cQYU7gEuH8tUSWrG
mOZ6ywnaAVUFr1cpoYp3QwXoKFvQMp2EshnwZvtOhIQEivks5uOdkbaYNjDg1ycS
Uw/Jn8gyxHlDczEQO1a1nJJggVhBrX/nRmaUXehy57KIrXHszgh3mstuaSjmPL/4
ZoXQ//Obh6Oc5xHV+kJlGhskHM2w+zpAEcK9B7RbaJnJXR/qBKjkcIWb3GN2gvJt
7oz7UjFv/6TT8fRIQUsE
=Zqtr
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
