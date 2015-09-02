From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Wed, 2 Sep 2015 09:43:38 -0500
Message-ID: <20150902144338.GG8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-6-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-6-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 02, 2015 at 05:24:20PM +0300, Roger Quadros wrote:
> If the ID pin event is not available over extcon
> then we rely on the OTG controller to provide us ID and VBUS
> information.
>=20
> We still don't support any OTG features but just
> dual-role operation.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.c | 217 ++++++++++++++++++++++++++++++++++++++++++=
++----
>  drivers/usb/dwc3/core.h |   3 +
>  2 files changed, 205 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 38b31df..632ee53 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -704,6 +704,63 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  	return 0;
>  }
> =20
> +/* Get OTG events and sync it to OTG fsm */
> +static void dwc3_otg_fsm_sync(struct dwc3 *dwc)
> +{
> +	u32 reg;
> +	int id, vbus;
> +
> +	reg =3D dwc3_readl(dwc->regs, DWC3_OSTS);
> +	dev_dbg(dwc->dev, "otgstatus 0x%x\n", reg);
> +
> +	id =3D !!(reg & DWC3_OSTS_CONIDSTS);
> +	vbus =3D !!(reg & DWC3_OSTS_BSESVLD);
> +
> +	if (id !=3D dwc->fsm->id || vbus !=3D dwc->fsm->b_sess_vld) {
> +		dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);
> +		dwc->fsm->id =3D id;
> +		dwc->fsm->b_sess_vld =3D vbus;
> +		usb_otg_sync_inputs(dwc->fsm);
> +	}

this guy shouldn't try to filter events here. That's what the FSM should
be doing.

> +}
> +
> +static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
> +{
> +	struct dwc3 *dwc =3D _dwc;
> +	unsigned long flags;
> +	irqreturn_t ret =3D IRQ_NONE;

this IRQ will be disabled pretty quickly. You *always* return IRQ_NONE

> +	spin_lock_irqsave(&dwc->lock, flags);

if you cache current OSTS in dwc3, you can use that instead and change
this to a spin_lock() instead of disabling IRQs here. This device's IRQs
are already masked anyway.

> +	dwc3_otg_fsm_sync(dwc);
> +	/* unmask interrupts */
> +	dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
> +	spin_unlock_irqrestore(&dwc->lock, flags);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
> +{
> +	struct dwc3 *dwc =3D _dwc;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	u32 reg;
> +
> +	spin_lock(&dwc->lock);

this seems unnecessary, we're already in hardirq with IRQs disabled.
What sort of race could we have ? (in fact, this also needs change in
dwc3/gadget.c).

> +
> +	reg =3D dwc3_readl(dwc->regs, DWC3_OEVT);
> +	if (reg) {
> +		dwc3_writel(dwc->regs, DWC3_OEVT, reg);
> +		/* mask interrupts till processed */
> +		dwc->oevten =3D dwc3_readl(dwc->regs, DWC3_OEVTEN);
> +		dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
> +		ret =3D IRQ_WAKE_THREAD;
> +	}
> +
> +	spin_unlock(&dwc->lock);
> +
> +	return ret;
> +}
> +
>  /* --------------------- Dual-Role management --------------------------=
----- */
> =20
>  static void dwc3_drd_fsm_sync(struct dwc3 *dwc)
> @@ -728,15 +785,44 @@ static int dwc3_drd_start_host(struct otg_fsm *fsm,=
 int on)
>  {
>  	struct device *dev =3D usb_otg_fsm_to_dev(fsm);
>  	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +	u32 reg;
> =20
>  	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
> +	if (dwc->edev) {
> +		if (on) {
> +			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +			/* start the HCD */
> +			usb_otg_start_host(fsm, true);
> +		} else {
> +			/* stop the HCD */
> +			usb_otg_start_host(fsm, false);
> +		}

		if (on)
			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
		usb_otg_start_host(fsm, on);

> +
> +		return 0;
> +	}
> +
> +	/* switch OTG core */
>  	if (on) {
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +		/* OCTL.PeriMode =3D 0 */
> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> +		reg &=3D ~DWC3_OCTL_PERIMODE;
> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> +		/* unconditionally turn on VBUS */
> +		reg |=3D DWC3_OCTL_PRTPWRCTL;
> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>  		/* start the HCD */
>  		usb_otg_start_host(fsm, true);
>  	} else {
>  		/* stop the HCD */
>  		usb_otg_start_host(fsm, false);
> +		/* turn off VBUS */
> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> +		reg &=3D ~DWC3_OCTL_PRTPWRCTL;
> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> +		/* OCTL.PeriMode =3D 1 */
> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> +		reg |=3D DWC3_OCTL_PERIMODE;
> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>  	}

it looks like you're not really following the fluxchart from SNPS
documentation, see Figure 11-4 on section 11.1.4.5

> @@ -746,15 +832,48 @@ static int dwc3_drd_start_gadget(struct otg_fsm *fs=
m, int on)
>  {
>  	struct device *dev =3D usb_otg_fsm_to_dev(fsm);
>  	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +	u32 reg;
> =20
>  	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
> -	if (on) {
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +	if (on)
>  		dwc3_event_buffers_setup(dwc);
> =20
> +	if (dwc->edev) {
> +		if (on) {
> +			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +			usb_otg_start_gadget(fsm, true);
> +		} else {
> +			usb_otg_start_gadget(fsm, false);
> +		}
> +
> +		return 0;
> +	}
> +
> +	/* switch OTG core */
> +	if (on) {
> +		/* OCTL.PeriMode =3D 1 */
> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> +		reg |=3D DWC3_OCTL_PERIMODE;
> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> +		/* GUSB2PHYCFG0.SusPHY =3D 1 */
> +		if (!dwc->dis_u2_susphy_quirk) {
> +			reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +			reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +		}
>  		/* start the UDC */
>  		usb_otg_start_gadget(fsm, true);
>  	} else {
> +		/* GUSB2PHYCFG0.SusPHY=3D0 */
> +		if (!dwc->dis_u2_susphy_quirk) {
> +			reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +			reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +		}
> +		/* OCTL.PeriMode =3D 1 */
> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> +		reg |=3D DWC3_OCTL_PERIMODE;
> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>  		/* stop the UDC */
>  		usb_otg_start_gadget(fsm, false);
>  	}
> @@ -777,10 +896,30 @@ static int dwc3_drd_notifier(struct notifier_block =
*nb,
>  	return NOTIFY_DONE;
>  }
> =20
> +static int dwc3_drd_register(struct dwc3 *dwc)
> +{
> +	int ret;
> +
> +	/* register parent as DRD device with OTG core */
> +	dwc->fsm =3D usb_otg_register(dwc->dev, &dwc->otg_config);
> +	if (IS_ERR(dwc->fsm)) {
> +		ret =3D PTR_ERR(dwc->fsm);
> +		if (ret =3D=3D -ENOTSUPP)
> +			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
> +		else
> +			dev_err(dwc->dev, "Failed to register with OTG core\n");
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int dwc3_drd_init(struct dwc3 *dwc)
>  {
>  	int ret, id, vbus;
>  	struct usb_otg_caps *otgcaps =3D &dwc->otg_config.otg_caps;
> +	u32 reg;
> =20
>  	otgcaps->otg_rev =3D 0;
>  	otgcaps->hnp_support =3D false;
> @@ -788,9 +927,10 @@ static int dwc3_drd_init(struct dwc3 *dwc)
>  	otgcaps->adp_support =3D false;
>  	dwc->otg_config.fsm_ops =3D &dwc3_drd_ops;
> =20
> +	/* If extcon device is not present we rely on OTG core for ID event */
>  	if (!dwc->edev) {
> -		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
> -		return -ENODEV;
> +		dev_dbg(dwc->dev, "No extcon device found for OTG mode\n");
> +		goto try_otg_core;
>  	}
> =20
>  	dwc->otg_nb.notifier_call =3D dwc3_drd_notifier;
> @@ -818,17 +958,9 @@ static int dwc3_drd_init(struct dwc3 *dwc)
>  		goto fail;
>  	}
> =20
> -	/* register as DRD device with OTG core */
> -	dwc->fsm =3D usb_otg_register(dwc->dev, &dwc->otg_config);
> -	if (IS_ERR(dwc->fsm)) {
> -		ret =3D PTR_ERR(dwc->fsm);
> -		if (ret =3D=3D -ENOTSUPP)
> -			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
> -		else
> -			dev_err(dwc->dev, "Failed to register with OTG core\n");
> -
> +	ret =3D dwc3_drd_register(dwc);
> +	if (ret)
>  		goto fail;
> -	}
> =20
>  	dwc3_drd_fsm_sync(dwc);
> =20
> @@ -839,6 +971,61 @@ extcon_fail:
>  	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
> =20
>  	return ret;
> +
> +try_otg_core:
> +	ret =3D dwc3_drd_register(dwc);
> +	if (ret)
> +		return ret;
> +
> +	/* disable all irqs */
> +	dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
> +	/* clear all events */
> +	dwc3_writel(dwc->regs, DWC3_OEVT, ~0);
> +
> +	ret =3D request_threaded_irq(dwc->otg_irq, dwc3_otg_irq,
> +				   dwc3_otg_thread_irq,
> +				   IRQF_SHARED, "dwc3-otg", dwc);
> +	if (ret) {
> +		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
> +			dwc->otg_irq, ret);
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	/* we need to set OTG to get events from OTG core */
> +	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +	/* GUSB2PHYCFG0.SusPHY=3D0 */
> +	if (!dwc->dis_u2_susphy_quirk) {
> +		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
> +		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +	}
> +
> +	/* Initialize OTG registers */
> +	/*
> +	 * Prevent host/device reset from resetting OTG core.
> +	 * If we don't do this then xhci_reset (USBCMD.HCRST) will reset
> +	 * the signal outputs sent to the PHY, the OTG FSM logic of the
> +	 * core and also the resets to the VBUS filters inside the core.
> +	 */
> +	reg =3D DWC3_OCFG_SFTRSTMASK;
> +	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
> +	/* Enable ID event interrupt */
> +	dwc3_writel(dwc->regs, DWC3_OEVTEN, DWC3_OEVTEN_CONIDSTSCHNGEN |
> +			DWC3_OEVTEN_BDEVVBUSCHNGE |
> +			DWC3_OEVTEN_BDEVSESSVLDDETEN);
> +	/* OCTL.PeriMode =3D 1 */
> +	dwc3_writel(dwc->regs, DWC3_OCTL, DWC3_OCTL_PERIMODE);
> +
> +	dwc3_otg_fsm_sync(dwc);
> +	usb_otg_sync_inputs(dwc->fsm);
> +
> +	return 0;
> +
> +error:
> +	usb_otg_unregister(dwc->dev);
> +
> +	return ret;
>  }
> =20
>  static void dwc3_drd_exit(struct dwc3 *dwc)
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index bd32cb2..129ef37 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -736,6 +736,7 @@ struct dwc3_scratchpad_array {
>   * @gadget_driver: pointer to the gadget driver
>   * @regs: base address for our registers
>   * @regs_size: address space size
> + * @oevten: otg interrupt enable mask copy
>   * @nr_scratch: number of scratch buffers
>   * @num_event_buffers: calculated number of event buffers
>   * @u1u2: only used on revisions <1.83a for workaround
> @@ -858,6 +859,8 @@ struct dwc3 {
>  	u32			dcfg;
>  	u32			gctl;
> =20
> +	u32			oevten;
> +
>  	u32			nr_scratch;
>  	u32			num_event_buffers;
>  	u32			u1u2;
> --=20
> 2.1.4
>=20

--=20
balbi

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5wsaAAoJEIaOsuA1yqRE+QAQAIO2BOZLRhz7B8wc0RtiAXP6
RmDyxYjlsrUAQxFyQyF6GaWbtkXHoW9Pgpi4D/T/W++3jlVHd6pnhrq7Mt2bfcCB
DLgA8ae2/moBWkWMvhRoeVMzh2qO4SxjZQRhCbskZPXlCAOcIShUfJfFQLPACPPD
zcWqfn3ClvF+jpvexVjy+NlkL/B+GN44y5jGsSk3UVHZ42fuCqzvU+B8c2ibROlM
80n2hRUs2yFEUj75etyOroQ+tvjenZcS/SHd2SKIeMz+6lMi3JjHiLBpC5EwdLSt
ejiTzVFaTV8RtS3YV3WMatGwzzfunQ7SOmvDLJ+4mgTzhMPobb/JPgYhA1yFLveM
UzmN45JiNjEZC+A/jmLGiFzUeIFpJtFzmEmYr1vaP8XWW/EWQneYF5UEhvuN4nnO
rqqD0DeoJOPl+IZ2AlWzqnEau3OAN5YcpUlDXCHJkeaOStz3Vfoarg2p62UN9RAm
MXb8KlY4x9H3eBD34cNpU3Yspg6b9uN3iJKGQ1v3hrzTdBxhgr85kg7kjORIfH3X
mvHcTsCn/oP8uY3ymt9qqAmIVBg8sg7CBrFLL/AcDQLs9Oljz83CdnupYsymzZDM
CdAkz15VKdGZf2r4lb8UTrCeLaMSws64C6nlr3Zu6t5Y93Bt5yNWuW9bMxreGw7x
0Ku8XLVz4OAQLfk5C2Ie
=ig9v
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
