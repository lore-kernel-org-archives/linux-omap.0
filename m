From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/9] mfd: omap-usb-host: Get clocks based on hardware
 revision
Date: Fri, 10 Jan 2014 10:22:51 +0000
Message-ID: <20140110102251.GH28141@lee--X1>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389269303-30465-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, arnd@arndb.de, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

> Not all revisions have all the clocks so get the necessary clocks
> based on hardware revision.
>=20
> This should avoid un-necessary clk_get failure messages that were
> observed earlier.
>=20
> Be more strict and always fail on clk_get() error.
>=20
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 93 +++++++++++++++++++++++++++++++----=
----------
>  1 file changed, 64 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index 1c9bca2..7202cc6 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -92,7 +92,6 @@
>  #define is_ehci_tll_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_TLL)
>  #define is_ehci_hsic_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_HSIC)
> =20
> -

Sneaky! ;)

>  struct usbhs_hcd_omap {
>  	int				nports;
>  	struct clk			**utmi_clk;
> @@ -665,22 +664,41 @@ static int usbhs_omap_probe(struct platform_dev=
ice *pdev)
>  		goto err_mem;
>  	}
> =20
> -	need_logic_fck =3D false;
> +	/* Set all clocks as invalid to begin with */
> +	omap->ehci_logic_fck =3D omap->init_60m_fclk =3D ERR_PTR(-EINVAL);
> +	omap->utmi_p1_gfclk =3D omap->utmi_p2_gfclk =3D ERR_PTR(-EINVAL);
> +	omap->xclk60mhsp1_ck =3D omap->xclk60mhsp2_ck =3D ERR_PTR(-EINVAL);

I don't think this is the correct error code.

-EINVAL means 'invalid parameter'.

You probably want -ENODEV or -ENOSYS ('function not implemented'
probably isn't ideal either tbh, but you get the idea). Perhaps you
can set them as NULL and check for IS_ERR_OR_NULL() instead?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
