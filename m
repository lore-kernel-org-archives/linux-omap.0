From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 06:16:49 -0800
Message-ID: <20181211141649.GL6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 06:14]:
> 
> Hi Tony
> 
> > > And, your [2/2] patch,
> > > I guess you are misunderstanding about "port" vs "endpoint",
> > > or omap-mcbsp driver side need to update ?
> > 
> > Yes omap-mcbsp driver needs to be updated for multiple endpoints.
> > 
> > Adding Jarkko and Peter also to Cc, below is the WIP patch that I'm
> > currently using for omap-mcbsp to add more DAIs.
> > 
> > So far nothing else to do in the omap-mcbsp as it's the cpcap hardware
> > that configures the TDM timeslots. And I'm currently assuming the
> > first instance is the master, I guess that should be parsed from the
> > the frame-master dts property instead.
> (snip)
> > +	if (np)
> > +		mcbsp->dai_count = of_graph_get_endpoint_count(np);
> 
> OK, you have multi DAI.
> Then, you need to count is "port", not "endpoint".

The issue I have with that it does not then follow the binding doc :)

See this part in Documentation/devicetree/bindings/graph.txt:

 "If a single port is connected to more than one remote device, an
 'endpoint' child node must be provided for each link."

Isn't the I2C TDM case the same as "single port connecected to
more than one remote device" rather than multiple ports?

To me it seems we're currently only handling the multiple ports
case, and not multiple endpoints for a port. Other than fixing
that, things should work just as earlier with my two patches.
That is unless I accidentally broke something.

So just trying to correct the binding usage. Or am I missing
something?

Regards,

Tony
