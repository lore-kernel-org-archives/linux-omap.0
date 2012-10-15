From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Mon, 15 Oct 2012 15:11:00 +0300
Message-ID: <20121015121100.GI24333@arwen.pp.htv.fi>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
 <1350133825-24181-2-git-send-email-vikas.sajjan@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39763 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab2JOMQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 08:16:31 -0400
Content-Disposition: inline
In-Reply-To: <1350133825-24181-2-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2012 at 06:40:23PM +0530, Vikas Sajjan wrote:
> Adding the suspend and resume funtionality to DWC3 core.
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/dwc3/core.c |   54 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b415c0c..0699061 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -622,11 +622,65 @@ static int __devexit dwc3_remove(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int dwc3_resume(struct device *dev)
> +{
> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
> +	int	ret;
> +
> +	usb_phy_init(dwc->usb2_phy);
> +	usb_phy_init(dwc->usb3_phy);
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
> +static int dwc3_suspend(struct device *dev)
> +{
> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
> +
> +	dwc3_event_buffers_cleanup(dwc);
> +
> +	usb_phy_shutdown(dwc->usb2_phy);
> +	usb_phy_shutdown(dwc->usb3_phy);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dwc3_pm_ops =3D {
> +	.suspend		=3D dwc3_suspend,
> +	.resume			=3D dwc3_resume,
> +};

one extra comment:

SET_SYSTEM_SLEEP_PM_OPS()

--=20
balbi

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe/1UAAoJEIaOsuA1yqREO6UQAKnp0xFC9ZU/6RPmCHFhO4IN
AO5rwAj1b5pP9uNz3faM/PEpu98BfAbDkig1F8HyIrmf1Kg1fm3Ousr9/0eeAxEr
uqYX8Fi6llj3WdlMrnhjxgY+cDp3edwnDx0e76CZl4gSV6PV0/XAh4LaoE56I2fQ
X+G6D+eZUhRYBHpj1ZF3FcZH6VYLQUJqfiZJuGlG9rvBa2r3cX5ihfFMPtCuITrk
sr7rg4JHi0sZ6niIQy/+1SmRcX+TLbtkEk+qd0gCMNLWAyaRQsNb/bgcsPqI4JGV
Bjfql2EGr4lSePgN2IVC7jpEHVIJm57by7bc69vVppWzDZ5m1DHGApYxs4r/5cK4
8DbJtRcAajFNOgad3SKqW++hND/qKNk5Cx7haZhuNE+/VE35esyBRDD9+lo9lVus
FCe9JJyEJKpSkMD0tpYOwT8kT+IrOwLX+SPiBKxHgX4TSGSy6a8jpXud3dfO15Lo
tZpNsqlZp6T8Ef/D1GTPn25NyYhy3hvqzcELZEpDEyeyanCFO5VlaTUNr9E0AopR
InGOb+USc8m9FSL94noJG7fXzwKy6WlJEwuSiv9/z8RFkkBWuC2LVzXZfqUwNDha
cdy0mErhd4qKohlSdEGRqZ+yGsw2iuRJZ/NSpF0yn8AcLQ1UIyk9aeMrxTtsN5vE
4UYo4wadWWcKQpAgy/BA
=rFKN
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
