From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Thu, 26 Nov 2009 00:49:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F77@dbde02.ent.ti.com>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <20091125133340.GB3737@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47522 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759001AbZKYTTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 14:19:15 -0500
In-Reply-To: <20091125133340.GB3737@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, November 25, 2009 7:04 PM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
> 
> On Wed, Nov 25, 2009 at 06:40:31PM +0530, Anuj Aggarwal wrote:
> 
> > System hang is observed While trying to do suspend. It was because
> > of an infinite loop in the AIC23 resume path which was trying to
> > restore AIC23 register values from the register cache.
> 
> This doesn't appear to tie in with the actual patch - where's the
> infinite loop?  The register cache restore loop has a constant bound and
> I can't see anything that would make it spin infinitely.
[Aggarwal, Anuj] Here is the original code:

<snip>
        int i;
        u16 reg;

        /* Sync reg_cache with the hardware */
        for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
                u16 val = tlv320aic23_read_reg_cache(codec, reg);
                tlv320aic23_write(codec, reg, val);
        }
</snip>

I can see 'i' getting incremented, instead of 'reg'. Isn't this an
infinite loop?
> 
> > This patch fixes the problem by correcting the resume path and
> > properly activating/deactivating the digital interface while
> > doing the suspend / off transitions.
> 
> What do you mean by "properly activating/deactivating the digital
> interface"?
[Aggarwal, Anuj] The driver was only deactivating the digital
interface and not activating it. Hence added that part. 
> 
> >  	case SND_SOC_BIAS_STANDBY:
> > -		/* everything off except vref/vmid, */
> > -		tlv320aic23_write(codec, TLV320AIC23_PWR, reg | 0x0040);
> > +		/* Activate the digital interface */
> > +		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);
> >  		break;
> >  	case SND_SOC_BIAS_OFF:
> > -		/* everything off, dac mute, inactive */
> > +		/* Deactivate the digital interface */
> >  		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> > -		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
> >  		break;
> 
> This looks wrong - the driver is now no longer managing bias levels at
> all.
[Aggarwal, Anuj] The bias levels were wrongly managed earlier. While doing 
a suspend, it was powering off all the interfaces and while coming up, it
was not switching on the required interfaces. Hence no sound was coming
out if audio was played back. 
Moreover, I referred twl4030 codec and there also the driver was only
handling the codec power control bit in _STANDBY. So based my patch
on that. 
On each bias level, which are the interfaces which need to be switched
on / off?
> 
> > -	u16 reg;
> > -
> > -	/* Sync reg_cache with the hardware */
> > -	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
> > -		u16 val = tlv320aic23_read_reg_cache(codec, reg);
> > -		tlv320aic23_write(codec, reg, val);
> > -	}
> 
> This also looks wrong, the register cache restore has been completely
> removed so if the power to the device is cut during suspend then the
> device will go back to register defaults and no longer function
> correctly after resume.
[Aggarwal, Anuj] I can add that register cache restore again with the
necessary checks.
