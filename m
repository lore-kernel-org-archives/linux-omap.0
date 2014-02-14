From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 02/12] mfd: omap-usb-host: Get clocks based on
 hardware revision
Date: Fri, 14 Feb 2014 10:07:01 +0000
Message-ID: <20140214100701.GC7380@lee--X1>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
 <1392200333-28397-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:48952 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaBNKHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 05:07:35 -0500
Received: by mail-we0-f175.google.com with SMTP id q59so8677229wes.34
        for <linux-omap@vger.kernel.org>; Fri, 14 Feb 2014 02:07:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392200333-28397-3-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, nm@ti.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> Not all revisions have all the clocks so get the necessary clocks
> based on hardware revision.
>=20
> This should avoid un-necessary clk_get failure messages that were
> observed earlier.
>=20
> Be more strict and always fail on clk_get() error.

It might have been clearer if you'd broken these two pieces of
functionality changes into two different patches. In future it would
be preferred.

> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 92 +++++++++++++++++++++++++++++++----=
----------
>  1 file changed, 64 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index 0c3c9a0..60a3bed 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -665,22 +665,41 @@ static int usbhs_omap_probe(struct platform_dev=
ice *pdev)
>  		goto err_mem;
>  	}
> =20
> -	need_logic_fck =3D false;
> +	/* Set all clocks as invalid to begin with */
> +	omap->ehci_logic_fck =3D omap->init_60m_fclk =3D ERR_PTR(-ENODEV);
> +	omap->utmi_p1_gfclk =3D omap->utmi_p2_gfclk =3D ERR_PTR(-ENODEV);
> +	omap->xclk60mhsp1_ck =3D omap->xclk60mhsp2_ck =3D ERR_PTR(-ENODEV);
> +

=46or readability you should probably do these one per line.

>  	for (i =3D 0; i < omap->nports; i++) {
> -		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
> -			is_ehci_hsic_mode(i))
> -				need_logic_fck |=3D true;
> +		omap->utmi_clk[i] =3D ERR_PTR(-ENODEV);
> +		omap->hsic480m_clk[i] =3D ERR_PTR(-ENODEV);
> +		omap->hsic60m_clk[i] =3D ERR_PTR(-ENODEV);
>  	}
> =20
> -	omap->ehci_logic_fck =3D ERR_PTR(-EINVAL);
> -	if (need_logic_fck) {
> -		omap->ehci_logic_fck =3D devm_clk_get(dev, "ehci_logic_fck");

Has this clock been renamed, or is it no longer required?

Perhaps you should be explicit in the commit log as to which clocks
you're removing.

> -		if (IS_ERR(omap->ehci_logic_fck)) {
> -			ret =3D PTR_ERR(omap->ehci_logic_fck);
> -			dev_dbg(dev, "ehci_logic_fck failed:%d\n", ret);
> +	/* for OMAP3 i.e. USBHS REV1 */
> +	if (omap->usbhs_rev =3D=3D OMAP_USBHS_REV1) {
> +		need_logic_fck =3D false;
> +		for (i =3D 0; i < omap->nports; i++) {
> +			if (is_ehci_phy_mode(pdata->port_mode[i]) ||
> +			    is_ehci_tll_mode(pdata->port_mode[i]) ||
> +			    is_ehci_hsic_mode(pdata->port_mode[i]))
> +
> +				need_logic_fck |=3D true;
> +		}
> +
> +		if (need_logic_fck) {
> +			omap->ehci_logic_fck =3D clk_get(dev, "usbhost_120m_fck");

devm_clk_get()?

<snip>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
