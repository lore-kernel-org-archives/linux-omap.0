From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [alsa-devel] [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Wed, 7 Oct 2009 10:50:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436CF92F8@dbde02.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
 <200910061146.05080.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44317 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbZJGFV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 01:21:27 -0400
In-Reply-To: <200910061146.05080.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

> >  #define twl_has_mmc()   false
> >  #endif
> >
> > +#if defined(CONFIG_SND_SOC_TWL6030) ||
defined(CONFIG_SND_SOC_TWL6030_MODULE) ||
defined(CONFIG_SND_SOC_TWL4030) ||
defined(CONFIG_SND_SOC_TWL4030_MODULE)

> > +#define twl_has_codec()	true
> > +#else
> > +#define twl_has_codec()	false
> > +#endif
> > +
> >  #if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODU=
LE)
> >  #define twl_has_usb()	true
> >  #else
> > @@ -190,6 +196,7 @@
> >  #define BCI_SUB_CHIP_ID		SUB_CHIP_ID1
> >  #define GPIO_SUB_CHIP_ID	0 /* NOT SUPPORTED IN TWL6030 */
> >  #define KEYPAD_SUB_CHIP_ID	0 /* ADDED FOR COMPILATION ONLY */
> > +#define CODEC_SUB_CHIP_ID	SUB_CHIP_ID3
>=20
> TWL4030 codec is under ID2 address group.
To pick the sub chip id from structure twl_mapping twl6030_map or twl40=
30_map at=20
Runtime. =20
>=20
> >
> >  /* subchip/slave 0 0x48 - POWER */
> >  #define TWL6030_BASEADD_RTC		0x0000
> > @@ -632,6 +639,14 @@ add_children(struct twl_platform_data *pdata, =
unsigned
> >  long features) if (IS_ERR(child))
> >  			return PTR_ERR(child);
> >  	}
> > +
> > +	if (twl_has_codec()) {
> > +		child =3D add_child(CODEC_SUB_CHIP_ID, "twl6030_codec",
> > +			pdata->codec, sizeof(*pdata->codec), false,
> > +			0, 0);
> > +		if (IS_ERR(child))
> > +			return PTR_ERR(child);
> > +	}
after [PATCH v3 0/4] TWL6030 patch series
Will now become something like
+	if (twl_has_codec() && twl_class_is_6030()) {
+		sub_chip_id =3D twl_map[TWL_MODULE_AUDIO_VOICE].sid;=09
+		child =3D add_child(sub_chip_id, "twl6030_codec",
+			pdata->codec, sizeof(*pdata->codec), false,
+			0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
And similarly for 4030 code
+	if (twl_has_codec() && twl_class_is_4030()) {
+		sub_chip_id =3D twl_map[TWL_MODULE_AUDIO_VOICE].sid;=09
+		child =3D add_child(sub_chip_id, "twl4030_codec",
+			pdata->codec, sizeof(*pdata->codec), false,
+			0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}

>=20
> We are going to have the twl4030 as child as well.
>=20
> >  #endif
> >
> >  	if (twl_has_usb() && pdata->usb) {
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index b687a8b..e76ca9b 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -472,6 +472,12 @@ struct twl_usb_data {
> >  	enum twl_usb_mode	usb_mode;
> >  };
> >
> > +struct twl_codec_data {
4030 and 6030 codec common fields can be added here
> > +	/* twl6030 */
> > +	int audpwron_gpio;	/* audio power-on gpio */
> > +	int naudint_irq;	/* audio interrupt */
Here twl4030 specific fields can be added
> > +};
>=20
CONFIG_TWL6030_CORE and CONFIG_TWL4030_CORE is merged to CONFIG_TWL_COR=
E
As two different build config was not encouraged.  Now switch=20
twl_class_is_6030() will be used to decide at runtime time to support f=
or 6030=20
related drivers, Similarly twl_class_is_4030() for 4030 drivers

> These are not applicable for the twl4030 codec, should we have differ=
ent
> twl_codec_data for twl6030 and twl4030 series?
> Should I merge here the things which will be used for the twl4030 cod=
ec?
> At the moment, I only have audio_mclk in my codec_data, but most prob=
ably the
> HS
> ramp related things will be also merged here in the future.
>=20
> > +
> >  struct twl_platform_data {
> >  	unsigned				irq_base, irq_end;
> >  	struct twl_bci_platform_data	*bci;
> > @@ -479,6 +485,7 @@ struct twl_platform_data {
> >  	struct twl_madc_platform_data	*madc;
> >  	struct twl_keypad_data		*keypad;
> >  	struct twl_usb_data			*usb;
> > +	struct twl_codec_data		*codec;
> >
> >  	/* LDO regulators common to TWL4030/TWL6030 */
> >  	struct regulator_init_data		*vdac;
> >
>=20
> --
> P=E9ter

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
