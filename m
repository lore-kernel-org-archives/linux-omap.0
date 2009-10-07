From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
	codec
Date: Wed, 7 Oct 2009 10:41:12 +0300
Message-ID: <200910071041.12595.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
	<200910061146.05080.peter.ujfalusi@nokia.com>
	<19F8576C6E063C45BE387C64729E73940436CF92F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436CF92F8@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Lopez Cruz, Misael" <x0052729@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 07 October 2009 08:20:35 ext Krishnamoorthy, Balaji T wrote:
> > >  #define twl_has_mmc()   false
> > >  #endif
> > >
> > > +#if defined(CONFIG_SND_SOC_TWL6030) ||
> =

> defined(CONFIG_SND_SOC_TWL6030_MODULE) ||
> defined(CONFIG_SND_SOC_TWL4030) ||
> defined(CONFIG_SND_SOC_TWL4030_MODULE)
> =

> > > +#define twl_has_codec()	true
> > > +#else
> > > +#define twl_has_codec()	false
> > > +#endif
> > > +
> > >  #if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
> > >  #define twl_has_usb()	true
> > >  #else
> > > @@ -190,6 +196,7 @@
> > >  #define BCI_SUB_CHIP_ID		SUB_CHIP_ID1
> > >  #define GPIO_SUB_CHIP_ID	0 /* NOT SUPPORTED IN TWL6030 */
> > >  #define KEYPAD_SUB_CHIP_ID	0 /* ADDED FOR COMPILATION ONLY */
> > > +#define CODEC_SUB_CHIP_ID	SUB_CHIP_ID3
> >
> > TWL4030 codec is under ID2 address group.
> =

> To pick the sub chip id from structure twl_mapping twl6030_map or
>  twl4030_map at Runtime.

Yes, it can be done.

> =

> > >  /* subchip/slave 0 0x48 - POWER */
> > >  #define TWL6030_BASEADD_RTC		0x0000
> > > @@ -632,6 +639,14 @@ add_children(struct twl_platform_data *pdata,
> > > unsigned long features) if (IS_ERR(child))
> > >  			return PTR_ERR(child);
> > >  	}
> > > +
> > > +	if (twl_has_codec()) {
> > > +		child =3D add_child(CODEC_SUB_CHIP_ID, "twl6030_codec",
> > > +			pdata->codec, sizeof(*pdata->codec), false,
> > > +			0, 0);
> > > +		if (IS_ERR(child))
> > > +			return PTR_ERR(child);
> > > +	}
> =

> after [PATCH v3 0/4] TWL6030 patch series
> Will now become something like
> +	if (twl_has_codec() && twl_class_is_6030()) {
> +		sub_chip_id =3D twl_map[TWL_MODULE_AUDIO_VOICE].sid;
> +		child =3D add_child(sub_chip_id, "twl6030_codec",
> +			pdata->codec, sizeof(*pdata->codec), false,
> +			0, 0);
> +		if (IS_ERR(child))
> +			return PTR_ERR(child);
> +	}
> And similarly for 4030 code
> +	if (twl_has_codec() && twl_class_is_4030()) {
> +		sub_chip_id =3D twl_map[TWL_MODULE_AUDIO_VOICE].sid;
> +		child =3D add_child(sub_chip_id, "twl4030_codec",
> +			pdata->codec, sizeof(*pdata->codec), false,
> +			0, 0);
> +		if (IS_ERR(child))
> +			return PTR_ERR(child);
> +	}

Sounds good.

> =

> > We are going to have the twl4030 as child as well.
> >
> > >  #endif
> > >
> > >  	if (twl_has_usb() && pdata->usb) {
> > > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > > index b687a8b..e76ca9b 100644
> > > --- a/include/linux/i2c/twl.h
> > > +++ b/include/linux/i2c/twl.h
> > > @@ -472,6 +472,12 @@ struct twl_usb_data {
> > >  	enum twl_usb_mode	usb_mode;
> > >  };
> > >
> > > +struct twl_codec_data {
> =

> 4030 and 6030 codec common fields can be added here
> =

> > > +	/* twl6030 */
> > > +	int audpwron_gpio;	/* audio power-on gpio */
> > > +	int naudint_irq;	/* audio interrupt */
> =

> Here twl4030 specific fields can be added

We can also use different twl_codec_data for 6030 and 4030.
There are not that many common things to handle, or is there?

> =

> > > +};
> =

> CONFIG_TWL6030_CORE and CONFIG_TWL4030_CORE is merged to CONFIG_TWL_CORE
> As two different build config was not encouraged.  Now switch
> twl_class_is_6030() will be used to decide at runtime time to support for
>  6030 related drivers, Similarly twl_class_is_4030() for 4030 drivers

I will hold back the patches for the twl4030 codec and twl core for now and=
 wait =

till things settled a bit. =


Thanks,
P=E9ter
