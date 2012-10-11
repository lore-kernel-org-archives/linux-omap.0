From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Thu, 11 Oct 2012 10:47:02 +0300
Message-ID: <20121011074702.GJ10030@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-2-git-send-email-vikas.sajjan@linaro.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58338 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757441Ab2JKHwZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 03:52:25 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1009847lag.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 00:52:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349877949-18872-2-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas C Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 10, 2012 at 07:35:47PM +0530, Vikas C Sajjan wrote:
> From: Vikas Sajjan <vikas.sajjan@linaro.org>
>=20
> Adding the suspend and resume funtionality to DWC3 core.
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/dwc3/core.c |  268 +++++++++++++++++++++++++++++------------=
-----
>  1 files changed, 169 insertions(+), 99 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b415c0c..58b51e1 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -70,51 +70,20 @@ MODULE_PARM_DESC(maximum_speed, "Maximum supported sp=
eed.");
> =20
>  static DECLARE_BITMAP(dwc3_devs, DWC3_DEVS_POSSIBLE);
> =20
> -int dwc3_get_device_id(void)
> -{
> -	int		id;
> -
> -again:
> -	id =3D find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
> -	if (id < DWC3_DEVS_POSSIBLE) {
> -		int old;
> -
> -		old =3D test_and_set_bit(id, dwc3_devs);
> -		if (old)
> -			goto again;
> -	} else {
> -		pr_err("dwc3: no space for new device\n");
> -		id =3D -ENOMEM;
> -	}
> -
> -	return id;
> -}
> -EXPORT_SYMBOL_GPL(dwc3_get_device_id);
> -
> -void dwc3_put_device_id(int id)
> -{
> -	int			ret;
> -
> -	if (id < 0)
> -		return;
> -
> -	ret =3D test_bit(id, dwc3_devs);
> -	WARN(!ret, "dwc3: ID %d not in use\n", id);
> -	smp_mb__before_clear_bit();
> -	clear_bit(id, dwc3_devs);
> -}
> -EXPORT_SYMBOL_GPL(dwc3_put_device_id);
> -
> -void dwc3_set_mode(struct dwc3 *dwc, u32 mode)

why are you even moving all this code around ? Doesn't look necessary.

> +static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
>  {
> -	u32 reg;
> +	struct dwc3_hwparams	*parms =3D &dwc->hwparams;
> =20
> -	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> -	reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> -	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +	parms->hwparams0 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
> +	parms->hwparams1 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
> +	parms->hwparams2 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
> +	parms->hwparams3 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
> +	parms->hwparams4 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
> +	parms->hwparams5 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
> +	parms->hwparams6 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
> +	parms->hwparams7 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
> +	parms->hwparams8 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
>  }
> -
>  /**
>   * dwc3_core_soft_reset - Issues core soft reset and PHY reset
>   * @dwc: pointer to our context structure
> @@ -160,6 +129,102 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>  }
> =20
> +static int dwc3_core_reset(struct dwc3 *dwc)

this looks unnecessary.

> +{
> +	unsigned long	timeout;
> +	u32	reg;
> +
> +	/* issue device SoftReset too */
> +	timeout =3D jiffies + msecs_to_jiffies(500);
> +	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> +	do {
> +		reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
> +		if (!(reg & DWC3_DCTL_CSFTRST))
> +			break;
> +
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(dwc->dev, "Reset Timed Out\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		cpu_relax();
> +	} while (true);
> +
> +	dwc3_core_soft_reset(dwc);
> +
> +	dwc3_cache_hwparams(dwc);
> +
> +	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> +	reg &=3D ~DWC3_GCTL_SCALEDOWN_MASK;
> +	reg &=3D ~DWC3_GCTL_DISSCRAMBLE;
> +
> +	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> +	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> +		reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> +		break;
> +	default:
> +		dev_dbg(dwc->dev, "No power optimization available\n");
> +	}
> +
> +	/*
> +	 * WORKAROUND: DWC3 revisions <1.90a have a bug
> +	 * where the device can fail to connect at SuperSpeed
> +	 * and falls back to high-speed mode which causes
> +	 * the device to enter a Connect/Disconnect loop
> +	 */
> +	if (dwc->revision < DWC3_REVISION_190A)
> +		reg |=3D DWC3_GCTL_U2RSTECN;
> +
> +	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +
> +	return 0;
> +}
> +
> +int dwc3_get_device_id(void)
> +{
> +	int		id;
> +
> +again:
> +	id =3D find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
> +	if (id < DWC3_DEVS_POSSIBLE) {
> +		int old;
> +
> +		old =3D test_and_set_bit(id, dwc3_devs);
> +		if (old)
> +			goto again;
> +	} else {
> +		pr_err("dwc3: no space for new device\n");
> +		id =3D -ENOMEM;
> +	}
> +
> +	return id;
> +}
> +EXPORT_SYMBOL_GPL(dwc3_get_device_id);
> +
> +void dwc3_put_device_id(int id)
> +{
> +	int			ret;
> +
> +	if (id < 0)
> +		return;
> +
> +	ret =3D test_bit(id, dwc3_devs);
> +	WARN(!ret, "dwc3: ID %d not in use\n", id);
> +	smp_mb__before_clear_bit();
> +	clear_bit(id, dwc3_devs);
> +}
> +EXPORT_SYMBOL_GPL(dwc3_put_device_id);
> +
> +void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> +{
> +	u32 reg;
> +
> +	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> +	reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> +	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
> +	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +}
> +
>  /**
>   * dwc3_free_one_event_buffer - Frees one event buffer
>   * @dwc: Pointer to our controller context structure
> @@ -303,20 +368,7 @@ static void dwc3_event_buffers_cleanup(struct dwc3 *=
dwc)
>  	}
>  }
> =20
> -static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
> -{
> -	struct dwc3_hwparams	*parms =3D &dwc->hwparams;
> =20
> -	parms->hwparams0 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
> -	parms->hwparams1 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
> -	parms->hwparams2 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
> -	parms->hwparams3 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
> -	parms->hwparams4 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
> -	parms->hwparams5 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
> -	parms->hwparams6 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
> -	parms->hwparams7 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
> -	parms->hwparams8 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
> -}
> =20
>  /**
>   * dwc3_core_init - Low-level initialization of DWC3 Core
> @@ -326,7 +378,6 @@ static void __devinit dwc3_cache_hwparams(struct dwc3=
 *dwc)
>   */
>  static int __devinit dwc3_core_init(struct dwc3 *dwc)
>  {
> -	unsigned long		timeout;
>  	u32			reg;
>  	int			ret;
> =20
> @@ -339,49 +390,9 @@ static int __devinit dwc3_core_init(struct dwc3 *dwc)
>  	}
>  	dwc->revision =3D reg;
> =20
> -	/* issue device SoftReset too */
> -	timeout =3D jiffies + msecs_to_jiffies(500);
> -	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> -	do {
> -		reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
> -		if (!(reg & DWC3_DCTL_CSFTRST))
> -			break;
> -
> -		if (time_after(jiffies, timeout)) {
> -			dev_err(dwc->dev, "Reset Timed Out\n");
> -			ret =3D -ETIMEDOUT;
> -			goto err0;
> -		}
> -
> -		cpu_relax();
> -	} while (true);
> -
> -	dwc3_core_soft_reset(dwc);
> -
> -	dwc3_cache_hwparams(dwc);
> -
> -	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> -	reg &=3D ~DWC3_GCTL_SCALEDOWN_MASK;
> -	reg &=3D ~DWC3_GCTL_DISSCRAMBLE;
> -
> -	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> -	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> -		reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> -		break;
> -	default:
> -		dev_dbg(dwc->dev, "No power optimization available\n");
> -	}
> -
> -	/*
> -	 * WORKAROUND: DWC3 revisions <1.90a have a bug
> -	 * where the device can fail to connect at SuperSpeed
> -	 * and falls back to high-speed mode which causes
> -	 * the device to enter a Connect/Disconnect loop
> -	 */
> -	if (dwc->revision < DWC3_REVISION_190A)
> -		reg |=3D DWC3_GCTL_U2RSTECN;
> -
> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +	ret =3D dwc3_core_reset(dwc);
> +	if (ret < 0)
> +		goto err0;
> =20
>  	ret =3D dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);

I would rather move dwc3_alloc_event_buffers() outside of
dwc3_core_init() and use that directly on ->resume(). dwc3_core_init()
shouldn't be doing any memory allocations, so we can re-use it, and it
doesn't matter when we allocate the event buffers anyway.

> @@ -622,11 +633,70 @@ static int __devexit dwc3_remove(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int dwc3_core_resume(struct device *dev)
> +{
> +	struct dwc3	*dwc;
> +	int	ret;
> +
> +	dwc =3D dev_get_drvdata(dev);

can be done together with declaration.

> +	if (!dwc)
> +		return -EINVAL;

unnecessary.

> +	ret =3D dwc3_core_reset(dwc);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D dwc3_event_buffers_setup(dwc);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (dwc->mode) {
> +	case DWC3_MODE_DEVICE:
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +		break;
> +	case DWC3_MODE_HOST:
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +		break;
> +	case DWC3_MODE_DRD:
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +	}
> +
> +	/* runtime set active to reflect active state. */
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int dwc3_core_suspend(struct device *dev)
> +{
> +	struct dwc3	*dwc;
> +
> +	dwc =3D dev_get_drvdata(dev);
> +	if (!dwc)
> +		return -EINVAL;
> +
> +	dwc3_event_buffers_cleanup(dwc);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dwc3_core_pm_ops =3D {

A little nit-picky, but I would rather you remove the _core part of the
prefix :-p likewise for suspend and resume callbacks.

> +	.suspend		=3D dwc3_core_suspend,
> +	.resume			=3D dwc3_core_resume,
> +};

#define DWC3_PM_OPS	&(dwc3_pm_ops)
#else
#define DWC3_PM_OPS	NULL

> +#endif /* CONFIG_PM */
> +
>  static struct platform_driver dwc3_driver =3D {
>  	.probe		=3D dwc3_probe,
>  	.remove		=3D __devexit_p(dwc3_remove),
>  	.driver		=3D {
>  		.name	=3D "dwc3",
> +#ifdef CONFIG_PM
> +		.pm =3D &dwc3_core_pm_ops,
> +#endif

remove ifdef:

		.pm =3D DWC3_PM_OPS,

--=20
balbi

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQdnl1AAoJEIaOsuA1yqREHPsQALKgGhUHqWj5TtIsW2ZE6b1t
y1QiupSj78gMrpN/tqllzOC4GImg2hjCb/oT7Rohewm27cY1hxXL3EUjGHPOWfOz
PFfzI+/wYyJwO2GzxLOXdU+OeS4iMDbpK+DDisAhcd4sUmEWKgJTqhyGpCw0N9zJ
zjG8Z6hLHF2nspc2+oKfSWo433+G5701BwP5iz4pHcWB02R0Wk7/BLmKLF3o0fOr
ExJ06gilesxRxjKksxHiXOk+6fwULmC697E20ciIGRoI8iI7W5qqK7f4tnYw1GSf
mVQySopgJvOJQyUq+OiEr8Q6gBCYG2g7kYwFn0Ox+P19wA6i/6If4JQ8eq/v19xO
qHtIu6tj0LFT3QkxYbaRikwG0cSHDVzGuQqvB36cA6J/0ry9aFpecQpSa3U14NVr
y4QuYqAjTxA+R+A/uzVvwse3omfj9WetKA82gP2qTWVUHvLnxq1e5lx2/0G5oRWK
Xm/wyTgJqxStyA0HNjclktRTjCItZZckARhdaUXq4NCXb7C2hCUPHV7o9H1BM//8
dXQSrpcf/WfpaeDoydR8L/6GlPmVK6f7xF+zy8rzTpWOoORE41WSl0oy17LoVlbJ
65jjoljsv47DmrlFOnyvqDH4N/ud96YQfjjzxXRCUil9Dw3E/aGIyyga4b+PmnOw
LP5BEdG1iI9rhQW1oZPk
=7Nr4
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
