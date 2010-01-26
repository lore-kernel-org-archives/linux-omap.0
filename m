From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: RE: [alsa-devel] [PATCHv2 6/6] ASoC: OMAP4: Add McPDM platform
 driver
Date: Tue, 26 Jan 2010 10:33:53 +0000
Message-ID: <1264502033.3067.52.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B5@dlee01.ent.ti.com>
	 <1264210638.3480.127.camel@odin>
	 <2256F256009DAA4CBE661E9F41EAC84B8C4CEF36@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39693 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab0AZKd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 05:33:58 -0500
Received: by ewy19 with SMTP id 19so800054ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 02:33:56 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8C4CEF36@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Mon, 2010-01-25 at 15:06 -0600, Candelaria Villareal, Jorge wrote:
> From: Liam Girdwood wrote:
> > On Fri, 2010-01-22 at 17:15 -0600, Candelaria Villareal, Jorge wrote:

snip

> > > +static int omap_mcpdm_dai_hw_params(struct 
> > snd_pcm_substream *substream,
> > > +				    struct snd_pcm_hw_params *params,
> > > +				    struct snd_soc_dai *dai)
> > > +{
> > > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > > +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> > > +	struct omap_mcpdm_data *mcpdm_priv = cpu_dai->private_data;
> > > +	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
> > > +	int stream = substream->stream;
> > > +	int channels, err, link_mask = 0;
> > > +
> > > +	cpu_dai->dma_data = &omap_mcpdm_dai_dma_params[stream];
> > > +
> > > +	channels = params_channels(params);
> > > +	switch (channels) {
> > > +	case 4:
> > > +		if (stream)
> > 
> > stream is either PLAYBACK or CAPTURE here.
> 
> Downlink and uplink were chosen instead to avoid confusion
> because that is how it is referred in McPDM technical
> documentation. But I do understand that we are talking
> about ALSA stream, not McPDM...
> 
> > 
> > > +			/* up to 2 channels for uplink */
> 
> So I should refer to CAPTURE instead of UPLINK in here.

I think it's best to use both CAPTURE and UPLINK in the comments.

> 
> > > +			return -EINVAL;
> > > +		link_mask |= 1 << 3;
> > > +	case 3:
> > > +		if (stream)
> > > +			/* up to 2 channels for uplink */
> > > +			return -EINVAL;
> > > +		link_mask |= 1 << 2;
> > > +	case 2:
> > > +		link_mask |= 1 << 1;
> > > +	case 1:
> > > +		link_mask |= 1 << 0;
> > > +		break;
> > > +	default:
> > > +		/* unsupported number of channels */
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (stream) {
> > 
> > ditto
> 
> Here, however, the methods set_uplink & set_downlink are
> Named after McPDM data paths. In this case is it preferred
> to name everything using ALSA convention? Or would it be ok
> to use downlink/uplink on certain cases?

I would name after ALSA but also have comments to state mcpdm link.

Thanks

Liam

