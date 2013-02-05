From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Tue, 5 Feb 2013 11:07:48 +0200
Message-ID: <20130205090748.GG32118@arwen.pp.htv.fi>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-2-git-send-email-rogerq@ti.com>
 <20130205072637.GA32118@arwen.pp.htv.fi>
 <5110C339.7080109@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5110C339.7080109-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2013 at 10:30:49AM +0200, Roger Quadros wrote:
> On 02/05/2013 09:26 AM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Feb 04, 2013 at 05:58:48PM +0200, Roger Quadros wrote:
> >> The PHY clock, clock rate, VCC regulator and RESET regulator
> >> can now be provided via device tree.
> >>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 +++++++++++=
+++++++++
> >>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 +++++++++++=
+++++++
> >>  2 files changed, 65 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xcei=
v.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b=
/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> >> new file mode 100644
> >> index 0000000..d7e2726
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> >> @@ -0,0 +1,34 @@
> >> +USB NOP PHY
> >> +
> >> +Required properties:
> >> +- compatible: should be usb-nop-xceiv
> >> +
> >> +Optional properties:
> >> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetr=
ee
> >> +  /bindings/clock/clock-bindings.txt
> >> +  This property is required if clock-frequency is specified.
> >> +
> >> +- clock-names: Should be "main_clk"
> >> +
> >> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must
> >> +  be configured to.
> >> +
> >> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.
> >> +
> >> +- reset-supply: phandle to the regulator that provides power to the P=
HY.
> >> +
> >> +Example:
> >> +
> >> +	hsusb1_phy {
> >> +		compatible =3D "usb-nop-xceiv";
> >> +		clock-frequency =3D <19200000>;
> >> +		clocks =3D <&osc 0>;
> >> +		clock-names =3D "main_clk";
> >> +		vcc-supply =3D <&hsusb1_vcc_regulator>;
> >> +		reset-supply =3D <&hsusb1_reset_regulator>;
> >> +	};
> >> +
> >> +hsusb1_phy is a NOP USB PHY device that gets its clock from an oscill=
ator
> >> +and expects that clock to be configured to 19.2MHz by the NOP PHY dri=
ver.
> >> +hsusb1_vcc_regulator provides power to the PHY and hsusb1_reset_regul=
ator
> >> +controls RESET.
> >> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb=
-xceiv.c
> >> index ac027a1..adbb7ab 100644
> >> --- a/drivers/usb/otg/nop-usb-xceiv.c
> >> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> >> @@ -34,6 +34,7 @@
> >>  #include <linux/slab.h>
> >>  #include <linux/clk.h>
> >>  #include <linux/regulator/consumer.h>
> >> +#include <linux/of.h>
> >> =20
> >>  struct nop_usb_xceiv {
> >>  	struct usb_phy		phy;
> >> @@ -138,8 +139,19 @@ static int nop_set_host(struct usb_otg *otg, stru=
ct usb_bus *host)
> >>  	return 0;
> >>  }
> >> =20
> >> +static void nop_xeiv_get_dt_pdata(struct device *dev,
> >=20
> > asking to remove, but xeiv !=3D xceiv :-)
> >=20
> >> +				struct nop_usb_xceiv_platform_data *pdata)
> >> +{
> >> +	struct device_node *node =3D dev->of_node;
> >> +	u32 clk_rate;
> >> +
> >> +	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
> >> +		pdata->clk_rate =3D clk_rate;
> >> +}
> >> +
> >>  static int nop_usb_xceiv_probe(struct platform_device *pdev)
> >>  {
> >> +	struct device *dev =3D &pdev->dev;
> >>  	struct nop_usb_xceiv_platform_data *pdata =3D pdev->dev.platform_dat=
a;
> >>  	struct nop_usb_xceiv	*nop;
> >>  	enum usb_phy_type	type =3D USB_PHY_TYPE_USB2;
> >> @@ -153,6 +165,17 @@ static int nop_usb_xceiv_probe(struct platform_de=
vice *pdev)
> >>  	if (!nop->phy.otg)
> >>  		return -ENOMEM;
> >> =20
> >> +	if (dev->of_node) {
> >> +		pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> >> +		if (!pdata) {
> >> +			dev_err(dev, "Memory allocation failure\n");
> >> +			return -ENOMEM;
> >> +		}
> >> +		nop_xeiv_get_dt_pdata(dev, pdata);
> >=20
> > actually, I would prefer to not create pdata at all. I mean, ideally
> > pdata would be used to initialize fields in your own structure, so first
> > move clk_rate to your own private structure, copy pdata's clk_rate value
> > to that, then you don't need this hackery when using DT.
> >=20
> OK, got it. Will revise.

Cool, after that you can add my:

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREMvkAAoJEIaOsuA1yqREBnsP/2pF4RvgMlGpjOHs31Sj3F0G
DsXfiDysmOSidxZvT2E6Svn2JQmD1y6G0voz4Aevc1BMhIB+RqVaD2KL+OXVDz7W
baicaaPCP0ekZylZhrZuDnNO+HgOQdQjxpY17bX+P8CNirBn0nCR/o1z8X7SkqpT
M9QcVKDKyU16JtOSingeySUmxrAWUXBbcFsFMRu3ZPNfO9aXR3iCNX9NyCM6p6r1
ZiFcumWMuwK49HtXsETA/8tZlxUyOiMy/Kp1iDb2t6TA+2jsX5ByxUhcVcYaCEQL
794WjicsGPfaYwXYCQFJqfCPbVaGLmjefiooKfAXnt7W509aCKLLSXIwu64YjkBj
VEwWiLHR/2IVk07IIwx7ZedfA/Z3o51tnePmby+2ib9I5ItVtTsRdsPTdO+3wlRI
8lkDXN72eIuCrm95xAqEiXxoF2s59Ddtffypm1EjNBmy5txhupKlBvinwjMBXH6e
avIVGoqnvfJiQMKWJewd8nu0l8Xezzfn+5zHSFVjW2LLq24AEKxu8+hLsm1kHzzF
rQQpkoNth/3MOrXJRICXMCIJM3ml863jEmueFItvhEUuE4JPCNfleyVhdsT4tr4z
yX7V5KhW+9W5cW99+14rMiuyk5AE54fw53HOJaEatBrwLp2rE+ZPdPxJrsYgxZRg
roRFkEpR2kkD1C3cOTy+
=hVeM
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
