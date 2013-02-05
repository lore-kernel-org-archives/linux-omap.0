From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Tue, 5 Feb 2013 09:26:37 +0200
Message-ID: <20130205072637.GA32118@arwen.pp.htv.fi>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-2-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39612 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab3BEH0w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 02:26:52 -0500
Content-Disposition: inline
In-Reply-To: <1359993540-20780-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 04, 2013 at 05:58:48PM +0200, Roger Quadros wrote:
> The PHY clock, clock rate, VCC regulator and RESET regulator
> can now be provided via device tree.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++=
++++++
>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++++=
++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Do=
cumentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> new file mode 100644
> index 0000000..d7e2726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -0,0 +1,34 @@
> +USB NOP PHY
> +
> +Required properties:
> +- compatible: should be usb-nop-xceiv
> +
> +Optional properties:
> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
> +  /bindings/clock/clock-bindings.txt
> +  This property is required if clock-frequency is specified.
> +
> +- clock-names: Should be "main_clk"
> +
> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must
> +  be configured to.
> +
> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.
> +
> +- reset-supply: phandle to the regulator that provides power to the PHY.
> +
> +Example:
> +
> +	hsusb1_phy {
> +		compatible =3D "usb-nop-xceiv";
> +		clock-frequency =3D <19200000>;
> +		clocks =3D <&osc 0>;
> +		clock-names =3D "main_clk";
> +		vcc-supply =3D <&hsusb1_vcc_regulator>;
> +		reset-supply =3D <&hsusb1_reset_regulator>;
> +	};
> +
> +hsusb1_phy is a NOP USB PHY device that gets its clock from an oscillator
> +and expects that clock to be configured to 19.2MHz by the NOP PHY driver.
> +hsusb1_vcc_regulator provides power to the PHY and hsusb1_reset_regulator
> +controls RESET.
> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xc=
eiv.c
> index ac027a1..adbb7ab 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/of.h>
> =20
>  struct nop_usb_xceiv {
>  	struct usb_phy		phy;
> @@ -138,8 +139,19 @@ static int nop_set_host(struct usb_otg *otg, struct =
usb_bus *host)
>  	return 0;
>  }
> =20
> +static void nop_xeiv_get_dt_pdata(struct device *dev,

asking to remove, but xeiv !=3D xceiv :-)

> +				struct nop_usb_xceiv_platform_data *pdata)
> +{
> +	struct device_node *node =3D dev->of_node;
> +	u32 clk_rate;
> +
> +	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
> +		pdata->clk_rate =3D clk_rate;
> +}
> +
>  static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct nop_usb_xceiv_platform_data *pdata =3D pdev->dev.platform_data;
>  	struct nop_usb_xceiv	*nop;
>  	enum usb_phy_type	type =3D USB_PHY_TYPE_USB2;
> @@ -153,6 +165,17 @@ static int nop_usb_xceiv_probe(struct platform_devic=
e *pdev)
>  	if (!nop->phy.otg)
>  		return -ENOMEM;
> =20
> +	if (dev->of_node) {
> +		pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata) {
> +			dev_err(dev, "Memory allocation failure\n");
> +			return -ENOMEM;
> +		}
> +		nop_xeiv_get_dt_pdata(dev, pdata);

actually, I would prefer to not create pdata at all. I mean, ideally
pdata would be used to initialize fields in your own structure, so first
move clk_rate to your own private structure, copy pdata's clk_rate value
to that, then you don't need this hackery when using DT.

--=20
balbi

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRELQtAAoJEIaOsuA1yqRE4aUP/AiNF/nAIIabOysgjOfU2gxA
qMKNO3RebVwbzKPXY5PmXeBAkaLPpAObP0zv0/GHrO+0ormL8Hy/YjD+MyRsRyqY
QpLJi2xMbZYu2IwBgphTCDMZY6OeoyZOaKQAlzYy1VLuLKocNtAQ7FsvSyDu+30K
73ZAJ/bak+dxB+otGpZCpUs5YQGb4DQtN5a7zYc7qM4QZALXL/fMd9pCkAcsksKd
frnqB8KPzQe5n8fvbxOCh8o2RhuL5JRuN1QrJPNkZe2Z1ZLXUl3umHZE5qhquBSj
STrsYFa+aAUmxtQdsgThSNq0ZAAjq0ptPei6V9AHh1pO+FxzZDjklS2zurrR4D79
yVh4MMLzefKh8HUMTkCPllFKFGWIviNRDBeJhaNGWAuifMEgYH/o1qL9awrLfjXl
1VzVpF0A7winjLLhLkd9yaImHKBmHDK7wx3GZbbymHyloLWLLZwDeU1jEZIzR/Vm
blBK93WgeERaGFT7nULPKy9nv4PfUrMn2QkxifQPmFCAEegKZuUIvXk7ZDghvpa7
3NUUPsa2pfk29KT1n4LnUrR5UTVa0z/D0m4bHKiEp2bVS+rrCApknl1gPG2STlog
18tpEahd0O8Chq0Vlht6mOvMYIS1YjNZ7Nk0v3l3Kp+aaQ9rBLKrBaML/MRxNwem
lNhwsw+kiRQ9hlL+qlQf
=WGWf
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
