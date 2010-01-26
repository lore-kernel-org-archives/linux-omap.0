From: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Subject: RE: [alsa-devel] [PATCHv2 6/6] ASoC: OMAP4: Add McPDM platform
 driver
Date: Tue, 26 Jan 2010 11:55:46 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8C569C02@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B5@dlee01.ent.ti.com>
	<1264210638.3480.127.camel@odin>
	<2256F256009DAA4CBE661E9F41EAC84B8C4CEF36@dlee01.ent.ti.com>
 <20100126102748.3b9fb04d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab0AZR4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 12:56:00 -0500
In-Reply-To: <20100126102748.3b9fb04d.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

 

Jarkko Nikula wrote:
> Hi
> 
> On Mon, 25 Jan 2010 15:06:44 -0600
> "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com> wrote:
> 
> > > > +static int omap_mcpdm_dai_startup(struct snd_pcm_substream 
> > > *substream,
> > > > +				  struct snd_soc_dai *dai)
> > > > +{
> > > > +	struct snd_soc_pcm_runtime *rtd = 
> substream->private_data;
> > > > +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> > > > +	int err = 0;
> > > > +
> > > > +	if (!cpu_dai->active)
> > > > +		err = omap_mcpdm_request();
> > > 
> > > Will anything else use this hw interface other than ALSA audio ?
> > > If not, the request is probably better in the machine 
> driver probe().
> > 
> > omap_mcpdm_request will enable the functional clock. Isn't it better
> > for the clock to be enabled only when is about to get used?
> > 
> Definitely yes if there is no any need to keep block active after the
> request. That would help the power-management if there are no active
> clocks when the streams are suspended with omap_mcpdm_stop() but the
> block remains reserved (i.e. omap_mcpdm_free is not called).
> 
> The current McBSP implementation is not the best example here but
> hopefully that will get fixed at some point.
> 
> > > stream is either PLAYBACK or CAPTURE here.
> > 
> > Downlink and uplink were chosen instead to avoid confusion
> > because that is how it is referred in McPDM technical
> > documentation. But I do understand that we are talking
> > about ALSA stream, not McPDM...
> ...
> > Here, however, the methods set_uplink & set_downlink are
> > Named after McPDM data paths. In this case is it preferred
> > to name everything using ALSA convention? Or would it be ok
> > to use downlink/uplink on certain cases?
> > 
> I think something like below is clear enough. It is easy to 
> see that we
> are dealing with ALSA playback stream which corresponds to 
> downlink path
> in HW.
> 
> if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> 	omap_mcpdm_downlink_opxxx();
> 
> Also for the user(-space) standard playback and capture naming is more
> clear than downlink/uplink terminology.

So the idea would be to show that ALSA playback/capture correspond
to McPDM downlink/uplink paths. Sounds good, I can try this for all
downlink/uplink operations.

> 
> 
> -- 
> Jarkko
> 