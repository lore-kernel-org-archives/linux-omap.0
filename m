From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Wed, 25 Nov 2009 19:39:34 +0000
Message-ID: <20091125193934.GA9263@rakim.wolfsonmicro.main>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <20091125133340.GB3737@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F77@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39143 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759608AbZKYTja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 14:39:30 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F77@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Nov 26, 2009 at 12:49:11AM +0530, Aggarwal, Anuj wrote:

> <snip>
>         int i;
>         u16 reg;
> 
>         /* Sync reg_cache with the hardware */
>         for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
>                 u16 val = tlv320aic23_read_reg_cache(codec, reg);
>                 tlv320aic23_write(codec, reg, val);
>         }
> </snip>

> I can see 'i' getting incremented, instead of 'reg'. Isn't this an
> infinite loop?

Yes, that does look entirely buggy - it seems fairly clear that suspend
and resume have never worked with this driver.  The fact that you were
removing the loop entirely meant I didn't read the actual code for bugs.

> > > This patch fixes the problem by correcting the resume path and
> > > properly activating/deactivating the digital interface while
> > > doing the suspend / off transitions.

> > What do you mean by "properly activating/deactivating the digital
> > interface"?

> [Aggarwal, Anuj] The driver was only deactivating the digital
> interface and not activating it. Hence added that part. 

So this is a separate issue, and should ideally be a separate patch - it
looks like you've got three different changes here, one to fix the buggy
register cache restore, one to manage the PWR bit on suspend and another
to possibly fix the bias configuration.  You certainly need to identify
all three changes in the changelog, especially for things like this
which look like they should go in as bug fixes (and bearing in mind that
it's the end of the release cycle).

Glancing at the code there's much more management required here -
there's other places where it's managed and the code needs to be joined
up with them.  The setting should only be restored if the device was
active when suspended, not unconditionally.

> > >  	case SND_SOC_BIAS_STANDBY:
> > > -		/* everything off except vref/vmid, */
> > > -		tlv320aic23_write(codec, TLV320AIC23_PWR, reg | 0x0040);
> > > +		/* Activate the digital interface */
> > > +		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);
> > >  		break;
> > >  	case SND_SOC_BIAS_OFF:
> > > -		/* everything off, dac mute, inactive */
> > > +		/* Deactivate the digital interface */
> > >  		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> > > -		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
> > >  		break;
> > 
> > This looks wrong - the driver is now no longer managing bias levels at
> > all.
> [Aggarwal, Anuj] The bias levels were wrongly managed earlier. While doing 
> a suspend, it was powering off all the interfaces and while coming up, it
> was not switching on the required interfaces. Hence no sound was coming
> out if audio was played back. 

Note that this CODEC driver impelements DAPM and so all the bits in the
power register which are controlled by DAPM will be managed by the ASoC
core without any action by the driver.

> On each bias level, which are the interfaces which need to be switched
> on / off?

The biases and any other device-wide settings, everything else should be
managed via DAPM if it's in use.
