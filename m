From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Mon, 10 Dec 2018 21:44:37 -0800
Message-ID: <20181211054437.GK6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <87zhtcabc0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zhtcabc0.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 05:30]:
> 
> Hi Tony, again
> 
> > >  	mcbsp3_port: port {
> > > -		cpu_dai3: endpoint {
> > > +		cpu_dai3: endpoint@0 {
> > >  			dai-format = "dsp_a";
> > >  			frame-master = <&cpcap_audio_codec1>;
> > >  			bitclock-master = <&cpcap_audio_codec1>;
> > >  			remote-endpoint = <&cpcap_audio_codec1>;
> > >  		};
> > > +		cpu_dai_mdm: endpoint@1 {
> > > +			dai-format = "dsp_a";
> > > +			frame-master = <&cpcap_audio_codec1>;
> > > +			bitclock-master = <&cpcap_audio_codec1>;
> > > +			remote-endpoint = <&mot_mdm6600_audio_codec0>;
> > > +		};
> 
> audio-graph-scu-card and my posting merged audio-graph-card
> are assuming multi-endpoint will be used for DPCM purpose.
> 
> But, above endpoint connection seems you want to is
> not DPCM (?), I'm not sure.

Yes DPCM should work nicely here :)

So to recap, Sebastian already added the cpcap codec a while back,
please see arch/arm/boot/dts/omap4-droid4-xt894.dts for the soundcard
node. Then see the link below for an earlier email describing how the
various components are wired for TDM [0].

Hope that clarifies things a bit more,

Tony

[0] https://lkml.org/lkml/2018/3/28/405
