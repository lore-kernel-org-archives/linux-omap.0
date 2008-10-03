From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/5 v2] ASoC Add TLV320AIC23 codec driver
Date: Fri, 03 Oct 2008 10:06:04 +0100
Message-ID: <1223024764.6814.69.camel@dell-desktop.example.com>
References: <dfeb90390810020215y605ce8a4v43331cb852bd6018@mail.gmail.com>
	 <20081003081856.GC25482@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32994 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbYJCJGX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Oct 2008 05:06:23 -0400
In-Reply-To: <20081003081856.GC25482@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arun KS <arunks@mistralsolutions.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com, troy.kisky@boundarydevices.com

On Fri, 2008-10-03 at 11:18 +0300, Tony Lindgren wrote:
> Hi,
> 
> * Arun KS <arunks@mistralsolutions.com> [081002 12:18]:
> > ASoC codec driver for TLV320AIC23 device
> 
> One comment below based on a quick browse.
> 
> <snip>
> 
> > +static void tlv320aic23_shutdown(struct snd_pcm_substream *substream)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_device *socdev = rtd->socdev;
> > +	struct snd_soc_codec *codec = socdev->codec;
> > +
> > +	/* deactivate */
> > +	if (!codec->active) {
> > +		udelay(50);
> > +		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> > +	}
> > +}
> > +
> 
> What's the purpose of the udelay() here? Looks like if needed it should
> be after the twl32aic23_write().. Otherwise the problem is probably
> somewhere else.
> 

Iirc this was found to reduce pops and clicks on shutdown on another
very similar codec in this family.

Liam

