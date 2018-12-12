From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [PATCH 0/2] Graph fixes for using multiple
        endpoints per port
Date: Wed, 12 Dec 2018 07:27:25 -0800
Message-ID: <20181212152725.GE6707@atomide.com>
References: <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <20181212001950.GX6707@atomide.com>
 <877egf33m9.wl-kuninori.morimoto.gx@renesas.com>
 <87k1kfs0u5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1kfs0u5.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181212 06:52]:
> 
> Hi Tony, again
> 
> > > > 	https://patchwork.kernel.org/patch/10712877/
> > > 
> > > Hmm, so do you have multiple separate ports at the "&sound" node
> > > hardware? If so then yeah multiple ports make sense.
> > >
> > > But if you only a single physical (I2S?) port at the
> > > "&sound" node hardware, then IMO you should only have one
> > > port and multiple endpoints there according to the graph.txt
> > > binding doc.
> > > 
> > > In my McBSP case there is only a single physical I2S port
> > > that can be TDM split into timeslots.
> > 
> > Mine has 4 DAIs. Each DAI can output 2ch.
> > These will be merged and wil be 8ch TDM and goes to Codec.
> > But hmm.. it is 4 DAIs, but 1 "physical" interface...
> > 
> > So, your patch seems correct, but will breaks DPCM...
> > I will confirm it.
> 
> I thought "port" = "DAI", but yeah, "port" = "physical interface".

OK good to hear :)

> Then, my issue is that we can't judge DAI size from DT.
> For example, MIXer case, 2 CPU DAIs are connected to 1 Codec.
> 
> 	DAI0 --- CPU --- Codec
> 	DAI1 /
> 
> In this case, CPU side needs 2 DAIs,
> Codec side needs 1 DAI only.

Oh so the other way around compared to my use case. Hmm.

> For both CPU/Codec case, OF graph will be like below,
> and we can't judge DAIs size from this.
> 
> 	port {
> 		ep0: endpint@0 {
> 			remote-endpoint = <xxx>;
> 		};
> 		ep1: endpint@1 {
> 			remote-endpoint = <xxx>;
> 		};
> 	}

Hmm I too need to add secondary DAIs for McBSP in addition to the
primary DAI controlling the McBSP hardware resources.

> To solve this issue, we need to use "reg" for it.
> Then, we can get correct DAI ID.

Hmm yeah maybe. Just to think of other options, maybe also the
#size-cells could be used?

As the binding allows adding #address-cells and #size-cells to
the port node.. Usually if you refer a subnode of a device you
just use #address=cells = <2> where the second field would be for
the offset. So maybe this could be used for 1 DAI this way:

 	/* Codec has 1 DAI */
 	Codec {
 		port {
			#address-cells = <2>;
			#size-cells = <1>;

 			ep: endpoint {
 				remote-endpoint = <xxx>;
 			};
 		};
 	}

Where this codec would then need to be referenced with just an
additional instance number:

foo = <&ep 0>;
bar = <&ep 1>;
...

And then for a codec with 2 DAIs the usual #size-cells = <1>
would be used with numbered endpoints for each DAI the way
you already described:

 	port {
 		ep0: endpint@0 {
 			remote-endpoint = <xxx>;
 		};
 		ep1: endpint@1 {
 			remote-endpoint = <xxx>;
 		};
 	}

Do you think that would work?

> Can you agree this ? we need extra patch,
> but it can solve your / my problem.

Yes it's starting to make sense :)

> Now I'm posting patches to merging
> "audio-graph-card" and "DPCM ver audio-graph-card".
> If you are OK, I will include above solution patch
> to this patch-set.

Sure, maybe please first check if the #size-cells = <2>
option would work though?

> Current audio-graph doesn't expect your use-case,
> and I want to avoid conflict.
> 
> So, "merged" audio-graph should solve your use-case.
> If you can agree about this, I will post patch-set.

Yeah I agree, just still wondering what might be the best
way to represent 1 DAI vs 2 DAIs.

Regards,

Tony
