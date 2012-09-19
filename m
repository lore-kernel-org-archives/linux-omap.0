From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/4] usb: phy: omap-usb2: enable 960Mhz clock for omap5
Date: Wed, 19 Sep 2012 16:45:01 +0200
Message-ID: <5059DA6D.4070205@pengutronix.de>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-5-git-send-email-kishon@ti.com>
 <20120919115647.GI3772@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3420536434621150533=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120919115647.GI3772-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3420536434621150533==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8BAD9F4C4B5FB973A617E59"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8BAD9F4C4B5FB973A617E59
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/19/2012 01:56 PM, Felipe Balbi wrote:
> On Wed, Sep 19, 2012 at 05:00:29PM +0530, Kishon Vijay Abraham I wrote:=

>> "usb_otg_ss_refclk960m" is needed by usb2 phy present in omap5. For
>> omap4, the clk_get of this clock will fail since it does not have this=

>> clock.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-phy.txt |    3 +++
>>  drivers/usb/phy/omap-usb2.c                       |   28 ++++++++++++=
++++++++-
>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Docum=
entation/devicetree/bindings/usb/usb-phy.txt
>> index 7c5fd89..d5626de 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-phy.txt
>> @@ -24,6 +24,9 @@ Required properties:
>>  add the address of control module phy power register until a driver f=
or
>>  control module is added
>> =20
>> +Optional properties:
>> + - has960mhzclk: should be added if the phy needs 960mhz clock
>> +
>>  This is usually a subnode of ocp2scp to which it is connected.
>> =20
>>  usb3phy@4a084400 {
>> diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c=

>> index d36c282..d6612ba 100644
>> --- a/drivers/usb/phy/omap-usb2.c
>> +++ b/drivers/usb/phy/omap-usb2.c
>> @@ -146,6 +146,7 @@ static int __devinit omap_usb2_probe(struct platfo=
rm_device *pdev)
>>  	struct omap_usb			*phy;
>>  	struct usb_otg			*otg;
>>  	struct resource			*res;
>> +	struct device_node		*np =3D pdev->dev.of_node;
>> =20
>>  	phy =3D devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
>>  	if (!phy) {
>> @@ -190,6 +191,15 @@ static int __devinit omap_usb2_probe(struct platf=
orm_device *pdev)
>>  	}
>>  	clk_prepare(phy->wkupclk);
>> =20
>> +	if (of_property_read_bool(np, "has960mhzclk")) {
>> +		phy->optclk =3D devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
>> +		if (IS_ERR(phy->optclk)) {
>> +			dev_err(&pdev->dev, "unable to get refclk960m\n");
>> +			return PTR_ERR(phy->optclk);
>> +		}
>> +		clk_prepare(phy->optclk);
>> +	}
>=20
> instead, can't you just always try to get the clock but ignore the erro=
r
> if it fails ?

On imx we add no-op dummy clocks, so that the drivers will always find
all needed clocks. If a clk_get fails it's an error.

> If it works you can set a flag to let you know that you can use that
> optional clock.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD8BAD9F4C4B5FB973A617E59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBZ2m0ACgkQjTAFq1RaXHPPdgCdFO1wLR3sxdcc6SHpwW+tQiUU
65cAnAvRbGjcx9DoMtNs77nrEuCWOTCe
=4qmd
-----END PGP SIGNATURE-----

--------------enigD8BAD9F4C4B5FB973A617E59--

--===============3420536434621150533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3420536434621150533==--
