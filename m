From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
 driver
Date: Thu, 25 Feb 2010 09:06:58 +0000
Message-ID: <1267088818.3255.42.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
	 <1267007881.3274.136.camel@odin>
	 <1889FA7136B567478A67D4B0F85B0CCE65DD22C9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:37675 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab0BYJHF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 04:07:05 -0500
Received: by fxm19 with SMTP id 19so5997779fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 01:07:04 -0800 (PST)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD22C9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Wed, 2010-02-24 at 17:37 -0600, Olaya, Margarita wrote:
> 
> > -----Original Message-----
> > From: Liam Girdwood [mailto:lrg@slimlogic.co.uk]
> > Sent: Wednesday, February 24, 2010 4:38 AM
> > To: Olaya, Margarita
> > Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com
> > Subject: Re: [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec driver
> >
> > On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> > > From: Misael Lopez Cruz <x0052729@ti.com>
> > >
> > > Initial version of TWL6030 codec driver.
> > >
> > > The TWL6030 codec uses a propietary PDM-based digital audio interface.
> > > Audio paths supported are:
> > >
> > > - Input: Main Mic, Sub Mic, Headset Mic, Auxiliary-FM Left/Right
> > > - Output: Headset Left/Right, Handsfree Left/Right

> > > +
> > > +/*
> > > + * read from twl6030 hardware register
> > > + */
> > > +static int twl6030_read(struct snd_soc_codec *codec,
> > > +                       unsigned int reg)
> > > +{
> > > +       u8 value;
> > > +
> > > +       if (reg >= TWL6030_CACHEREGNUM)
> > > +               return -EIO;
> > > +
> > > +       twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &value, reg);
> > > +       twl6030_write_reg_cache(codec, reg, value);
> >
> >
> > You probably want to read from the cache if the register is not
> > volatile. This saves a slow I2C read.
> >
> 
> This function is called for volatile registers; if the register is not volatile we call twl6030_read_reg_cache. I could merge those two functions with a case for those.
> 

Ok, could amend the name or comment so it's obvious this is for
volatiles.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

