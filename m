From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 9 May 2014 10:24:03 +0300
Message-ID: <536C8293.4070506@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-4-git-send-email-tony@atomide.com> <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vI58sMfFIcR4jq3JjchL1C5S3Sn4Jhw4L"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40241 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaEIHYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 03:24:30 -0400
In-Reply-To: <20140508233300.GI2198@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--vI58sMfFIcR4jq3JjchL1C5S3Sn4Jhw4L
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 02:33, Tony Lindgren wrote:

> We can pass the GPIO configuration for ls037v7dw01 in a standard
> gpios property.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> @@ -0,0 +1,56 @@
> +SHARP LS037V7DW01 TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "sharp,ls037v7dw01"
> +
> +Optional properties:
> +- enable-gpios: a GPIO spec for the optional enable pin
> +  this pin is the INI pin as specified in the LS037V7DW01.pdf file.
> +- reset-gpios: a GPIO spec for the optional reset pin
> +  this pin is the RESB pin as specified in the LS037V7DW01.pdf file.
> +- mode-gpios: a GPIO=20
> +  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
> +
> +This binding is compatible with the simple-panel binding, which is spe=
cified
> +in simple-panel.txt in this directory.

The video port data is required also. See for example
Documentation/devicetree/bindings/video/panel-dsi-cm.txt or
Documentation/devicetree/bindings/video/hdmi-connector.txt.

Also, all the bindings I've made are in
Documentation/devicetree/bindings/video/, and I'd rather keep the video
bindings OMAP uses in the same place.

> +This panel can have zero to five GPIOs to configure
> +to change configuration between QVGA and VGA mode
> +and the scan direction. As these pins can be also
> +configured with external pulls, all the GPIOs are
> +considered optional with holes in the array.
> +
> +Example when connected to a omap2+ based device:
> +
> +	lcd0: display {
> +		compatible =3D "sharp,ls037v7dw01";
> +		power-supply =3D <&lcd_3v3>;
> +		enable-gpios =3D <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI *=
/
> +		reset-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB *=
/
> +		mode-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> +			      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> +			      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
> +
> +		panel-timing {
> +			clock-frequency =3D <19200000>;
> +			hback-porch =3D <28>;
> +			hactive =3D <480>;
> +			hfront-porch =3D <1>;
> +			hsync-len =3D <2>;
> +			vback-porch =3D <1>;
> +			vactive =3D <640>;
> +			vfront-porch =3D <1>;
> +			vsync-len =3D <1>;
> +			hsync-active =3D <0>;
> +			vsync-active =3D <0>;
> +			de-active =3D <1>;
> +			pixelclk-active =3D <1>;
> +		};

I don't think we should define panel-timing here. We know it's
sharp,ls037v7dw01, so the driver knows the video timings. Also, if we
would extend the driver to support both resolution modes, it needs to
support two different timings, so the above doesn't work in that case
either.

Although if the MO gpio is not controlled by the driver, we should tell
the driver whether that gpio is high or low.

> +static int sharp_ls_probe_of(struct platform_device *pdev)
> +{
> +	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct omap_dss_device *in;
> +	struct display_timing timing;
> +	struct videomode vm;
> +	int r;
> +
> +	ddata->vcc =3D devm_regulator_get(&pdev->dev, "envdd");
> +	if (IS_ERR(ddata->vcc)) {
> +		dev_err(&pdev->dev, "failed to get regulator\n");
> +		return PTR_ERR(ddata->vcc);
> +	}
> +
> +	r =3D regulator_enable(ddata->vcc);
> +	if (r !=3D 0) {
> +		dev_err(&pdev->dev, "failed to enable regulator\n");
> +		return r;
> +	}

The regulator should be enabled when the panel is enabled, not at probe
time.

> +static const struct of_device_id sharp_ls_of_match[] =3D {
> +	{ .compatible =3D "sharp,ls037v7dw01", },

At the moment our display drivers are OMAP specific, and for that reason
we should prefix the compatible strings with "omapdss,". For example,
drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c:

	{ .compatible =3D "omapdss,panel-dsi-cm", },

But we should still have the right compatible string in the .dts, so we
convert the compatible name in arch/arm/mach-omap2/display.c, with
'dss_compat_conv_list' array, to which this panel's name should be added.=


 Tomi



--vI58sMfFIcR4jq3JjchL1C5S3Sn4Jhw4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbIKTAAoJEPo9qoy8lh71Q80P/1hwp0WNhOuLmu2VfPeOJ0Sv
vFgB6LslH0G1ijki32dZtjnyjkiZQxfPOQ+EVyNhq4qmu8lsT78o7OAweJ+/BWlP
4lIgfQgZ7JpJOX1Ig3r0VkN2IYhjl75bV1V2eM3cb/1MTDpqJTbr2L/PSvHqZf0G
TPUgsa+42St6LY7+kk6bXtJiHH6C+tMupR+HX8C0D32Zjw/IJMHbZavFtBY5Cc1t
uE5qxftOSDWTL+M3vb+K3w+mFUEoAkr5rdMb7FsXaBUzrrHqxpRQkJiSO4dn90Yj
51w+hy5GDwwzGllsTeM43F3tVWM06uA469cvrwa8S2+iXrxEkk7LrCZ+e3Xj1TGp
IHxAZhket2W2E3aqoNQQGyzoYUWLnyMPtNMzz1J67yHl/qSF5wjJDJfNZIE+VSZy
ZJy35ciiUPpzoqiZc74RNpbLtkK+77Nzniu5A5ZaPJ7+LftuKc13mGzfHwdXYFqS
OMoBYy7vvc/d5B/+D5laqkDxkZIJHN1u1gjZ/Gt/dGZlsrEzmh6SZDwOl3BOrHXY
UNJyzkx3HD95txwEZ9YEXkiI8sFTfAi+J2TELDPmgQpTs0nXhVJ0AREeUcmY1XsV
Ss9hmWIH7pOVMBU85ZXkLOBUqmX2tOuxLlZhlqElt4Ix0/ADNL8INHWDDr2LfrLz
iBYkswmYoWnyAHPKfdgu
=XPwt
-----END PGP SIGNATURE-----

--vI58sMfFIcR4jq3JjchL1C5S3Sn4Jhw4L--
