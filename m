From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Mon, 11 Mar 2013 16:52:55 +0100
Message-ID: <513DFDD7.7000801@pengutronix.de>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-2-git-send-email-rogerq@ti.com>
 <20130205072637.GA32118@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2379932592556398070=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130205072637.GA32118-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2379932592556398070==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2AISTNMOIBMODXPLCFXXO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2AISTNMOIBMODXPLCFXXO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/05/2013 08:26 AM, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Feb 04, 2013 at 05:58:48PM +0200, Roger Quadros wrote:
>> The PHY clock, clock rate, VCC regulator and RESET regulator
>> can now be provided via device tree.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 +++++++++++=
+++++++++
>>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 +++++++++++=
+++++++
>>  2 files changed, 65 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xcei=
v.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b=
/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> new file mode 100644
>> index 0000000..d7e2726
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> @@ -0,0 +1,34 @@
>> +USB NOP PHY
>> +
>> +Required properties:
>> +- compatible: should be usb-nop-xceiv
>> +
>> +Optional properties:
>> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetr=
ee
>> +  /bindings/clock/clock-bindings.txt
>> +  This property is required if clock-frequency is specified.
>> +
>> +- clock-names: Should be "main_clk"
>> +
>> +- clock-frequency: the clock frequency (in Hz) that the PHY clock mus=
t
>> +  be configured to.
>> +
>> +- vcc-supply: phandle to the regulator that provides RESET to the PHY=
=2E
>> +
>> +- reset-supply: phandle to the regulator that provides power to the P=
HY.
>> +
>> +Example:
>> +
>> +	hsusb1_phy {
>> +		compatible =3D "usb-nop-xceiv";
>> +		clock-frequency =3D <19200000>;
>> +		clocks =3D <&osc 0>;
>> +		clock-names =3D "main_clk";
>> +		vcc-supply =3D <&hsusb1_vcc_regulator>;
>> +		reset-supply =3D <&hsusb1_reset_regulator>;
>> +	};
>> +
>> +hsusb1_phy is a NOP USB PHY device that gets its clock from an oscill=
ator
>> +and expects that clock to be configured to 19.2MHz by the NOP PHY dri=
ver.
>> +hsusb1_vcc_regulator provides power to the PHY and hsusb1_reset_regul=
ator
>> +controls RESET.
>> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb=
-xceiv.c
>> index ac027a1..adbb7ab 100644
>> --- a/drivers/usb/otg/nop-usb-xceiv.c
>> +++ b/drivers/usb/otg/nop-usb-xceiv.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/clk.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/of.h>
>> =20
>>  struct nop_usb_xceiv {
>>  	struct usb_phy		phy;
>> @@ -138,8 +139,19 @@ static int nop_set_host(struct usb_otg *otg, stru=
ct usb_bus *host)
>>  	return 0;
>>  }
>> =20
>> +static void nop_xeiv_get_dt_pdata(struct device *dev,
>=20
> asking to remove, but xeiv !=3D xceiv :-)
>=20
>> +				struct nop_usb_xceiv_platform_data *pdata)
>> +{
>> +	struct device_node *node =3D dev->of_node;
>> +	u32 clk_rate;
>> +
>> +	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
>> +		pdata->clk_rate =3D clk_rate;
>> +}
>> +
>>  static int nop_usb_xceiv_probe(struct platform_device *pdev)
>>  {
>> +	struct device *dev =3D &pdev->dev;
>>  	struct nop_usb_xceiv_platform_data *pdata =3D pdev->dev.platform_dat=
a;
>>  	struct nop_usb_xceiv	*nop;
>>  	enum usb_phy_type	type =3D USB_PHY_TYPE_USB2;
>> @@ -153,6 +165,17 @@ static int nop_usb_xceiv_probe(struct platform_de=
vice *pdev)
>>  	if (!nop->phy.otg)
>>  		return -ENOMEM;
>> =20
>> +	if (dev->of_node) {
>> +		pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +		if (!pdata) {
>> +			dev_err(dev, "Memory allocation failure\n");
>> +			return -ENOMEM;
>> +		}
>> +		nop_xeiv_get_dt_pdata(dev, pdata);
>=20
> actually, I would prefer to not create pdata at all. I mean, ideally
> pdata would be used to initialize fields in your own structure, so firs=
t
> move clk_rate to your own private structure, copy pdata's clk_rate valu=
e
> to that, then you don't need this hackery when using DT.

As far as I can see, clk_rate is never used, but in the probe function.
Why should it be saved into the private data structure at all?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2AISTNMOIBMODXPLCFXXO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE9/dcACgkQjTAFq1RaXHPajwCghjLyalOjrTMlYSNsUwSMMYRb
YcAAoJMCPIGP1TmRB4YQ3usOp5314hXN
=DSyg
-----END PGP SIGNATURE-----

------enig2AISTNMOIBMODXPLCFXXO--

--===============2379932592556398070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2379932592556398070==--
