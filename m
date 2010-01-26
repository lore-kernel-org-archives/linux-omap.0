From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCHv2 6/6] ASoC: OMAP4: Add McPDM platform
 driver
Date: Tue, 26 Jan 2010 10:30:13 +0000
Message-ID: <1264501813.3067.48.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B5@dlee01.ent.ti.com>
	 <1264210638.3480.127.camel@odin>
	 <2256F256009DAA4CBE661E9F41EAC84B8C4CEF36@dlee01.ent.ti.com>
	 <20100126102748.3b9fb04d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34668 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab0AZKaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 05:30:23 -0500
Received: by ewy19 with SMTP id 19so796777ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 02:30:20 -0800 (PST)
In-Reply-To: <20100126102748.3b9fb04d.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Tue, 2010-01-26 at 10:27 +0200, Jarkko Nikula wrote:
> Hi
> 
> On Mon, 25 Jan 2010 15:06:44 -0600
> "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com> wrote:
> 
> > > > +static int omap_mcpdm_dai_startup(struct snd_pcm_substream 
> > > *substream,
> > > > +				  struct snd_soc_dai *dai)
> > > > +{
> > > > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > > > +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> > > > +	int err = 0;
> > > > +
> > > > +	if (!cpu_dai->active)
> > > > +		err = omap_mcpdm_request();
> > > 
> > > Will anything else use this hw interface other than ALSA audio ?
> > > If not, the request is probably better in the machine driver probe().
> > 
> > omap_mcpdm_request will enable the functional clock. Isn't it better
> > for the clock to be enabled only when is about to get used?
> > 
> Definitely yes if there is no any need to keep block active after the
> request. That would help the power-management if there are no active
> clocks when the streams are suspended with omap_mcpdm_stop() but the
> block remains reserved (i.e. omap_mcpdm_free is not called).


Ah ok, it seems that some other platforms have similar get_resource_x()
functions that do not additionally call their clk_enable_resource_x().
(last time I looked).

This is fine.

Liam 

