From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCHv4 1/7] OMAP4: PMIC: Add support for twl6030 codec
Date: Wed, 24 Feb 2010 12:13:29 +0100
Message-ID: <20100224111328.GA2950@sortiz.org>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B13@dlee06.ent.ti.com>
 <1267006169.3274.88.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:33920 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756588Ab0BXLOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 06:14:17 -0500
Content-Disposition: inline
In-Reply-To: <1267006169.3274.88.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Hi Liam,

On Wed, Feb 24, 2010 at 10:09:29AM +0000, Liam Girdwood wrote:
> On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> > From: Misael Lopez Cruz <x0052729@ti.com>
> > 
> > In order to have TWL6030 CODEC driver as a platform driver, codec data
> > should be passed through twl_platform_data structure.
> > 
> > For twl6030 audio codec, the following data may be passed:
> >     - audpwron_gpio: gpio line used to power-up/down the codec. A low-to-high
> >       transition powers codec up. Setting audpwron_gpio to a negative value
> >       means that codec will use manual power sequence instead of automatic
> >       sequence
> >     - naudint_irq: irq line for audio interrupt. twl6030 drives NAUDINT line
> >       to low when an interrupt (codec ready, plug insertion/removal, etc) is
> >       detected
> > 
> > However, codec driver can operate if any or none of them are passed.
> > 
> > Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> > Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> > Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> 
> It would be good to get Samuel's Ack on this as it touches MFD.
> 
> Samuel are you OK with this ?
That seems fine, yes.
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.


> > ---
> >  drivers/mfd/twl-core.c  |   18 +++++++++++++++---
> >  include/linux/i2c/twl.h |    4 ++++
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 514e1e4..7e3b0d7 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -118,7 +118,8 @@
> >  #define twl_has_watchdog()        false
> >  #endif
> >  
> > -#if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_MODULE)
> > +#if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_MODULE) ||\
> > +	defined(CONFIG_SND_SOC_TWL6030) || defined(CONFIG_SND_SOC_TWL6030_MODULE)
> >  #define twl_has_codec()	true
> >  #else
> >  #define twl_has_codec()	false
> > @@ -735,8 +736,19 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
> >  			return PTR_ERR(child);
> >  	}
> >  
> > -	if (twl_has_codec() && pdata->codec) {
> > -		child = add_child(1, "twl4030_codec",
> > +	if (twl_has_codec() && pdata->codec && twl_class_is_4030()) {
> > +		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
> > +		child = add_child(sub_chip_id, "twl4030_codec",
> > +				pdata->codec, sizeof(*pdata->codec),
> > +				false, 0, 0);
> > +		if (IS_ERR(child))
> > +			return PTR_ERR(child);
> > +	}
> > +
> > +	/* Phoenix*/
> > +	if (twl_has_codec() && pdata->codec && twl_class_is_6030()) {
> > +		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
> > +		child = add_child(sub_chip_id, "twl6030_codec",
> >  				pdata->codec, sizeof(*pdata->codec),
> >  				false, 0, 0);
> >  		if (IS_ERR(child))
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index 9cf6cd7..d943c8b 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -556,6 +556,10 @@ struct twl4030_codec_data {
> >  	unsigned int	audio_mclk;
> >  	struct twl4030_codec_audio_data		*audio;
> >  	struct twl4030_codec_vibra_data		*vibra;
> > +
> > +	/* twl6030 */
> > +	int audpwron_gpio;      /* audio power-on gpio */
> > +	int naudint_irq;        /* audio interrupt */
> >  };
> >  
> >  struct twl4030_platform_data {
> 
> Liam
> 
> -- 
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
