From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [alsa-devel] [PATCHv2 1/1] OMAP_TWL4030 SoC Audio driver.
Date: Thu, 27 Nov 2008 23:56:05 +0800
Message-ID: <1227801365.14497.136.camel@localhost>
References: <1227790257-14221-1-git-send-email-stanley.miao@windriver.com>
	 <1227790257-14221-2-git-send-email-stanley.miao@windriver.com>
	 <20081127131923.GC3933@sirena.org.uk>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34322 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbYK0PuA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2008 10:50:00 -0500
In-Reply-To: <20081127131923.GC3933@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, 2008-11-27 at 13:19 +0000, Mark Brown wrote:
> On Thu, Nov 27, 2008 at 08:50:57PM +0800, Stanley.Miao wrote:
> 
> > Add a shared omap_twl4030 driver to avoid reduplicate code among omap drivers.
> > This drive also provides a extended interface for some board specific features.
> 
> As discussed in the thread following your initial submission it'd be
> better to do something like having flags specifying which outputs are
> connected up rather than just leaving all that stuff to per-board code.
> At the minute all that's being shared is a bit of boiler plate (which
> will get smaller) and the hw_params function at the source code level.
> 
> As I said in response to your original posting I'd strongly urge you to
> look at the s3c24xx_uda134x driver for an example of how something like
> this can be implemented.

I tried to make it work whether there is platform_data or not. If I
write it according to s3c24xx_uda134x style, every board should register
a platform_device. 

> 
> Some more specific comments below...
> 
> > +config SND_OMAP_TWL4030_SPECIFIC
> > +	bool
> > +	default n
> > +
> 
> This really needs some documentation.  I think a better name should be
> possible too but see my comments below for the header...
> 
<snip>
> 
> > +#ifdef CONFIG_SND_OMAP_TWL4030_SPECIFIC
> > +extern void omap_twl4030_specific_init(struct snd_soc_device *);
> > +#else
> > +static inline void omap_twl4030_specific_init(struct snd_soc_device *snd_dev)
> > +{
> > +	if(snd_dev == NULL)
> > +		return;
> > +	/* McBSP2 */
> > +	*(unsigned int *)snd_dev->machine->dai_link->cpu_dai->private_data = 1;
> > +	omap_twl4030_data = NULL;
> > +}
> > +#endif
> 
> This still has the previous problem with your use of ifdefs: it means
> that it's not possible to build the driver for configurations that both
> do and don't need this.

This is why there is a SND_OMAP_TWL4030_SPECIFIC in Kconfig. If there
are some board specific features, SND_OMAP_TWL4030_SPECIFIC should be
selected under a board config, and omap_twl4030_specific_init() will be
difined in the board specific file.

Stanley.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
