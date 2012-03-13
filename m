From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP DSS device tree design problems
Date: Tue, 13 Mar 2012 23:47:00 +0100
Message-ID: <4F5FCE64.5070902@ti.com>
References: <1331559930.2097.100.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab2CMWrL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 18:47:11 -0400
In-Reply-To: <1331559930.2097.100.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Turquette, Mike" <mturquette@ti.com>

+ devicetree list and Mike T. for the clock aspect

Hi Tomi,

On 3/12/2012 2:45 PM, Tomi Valkeinen wrote:
> Hi,
>
> I'm struggling with the design of the DT data for OMAP display subsystem
> driver, and any thoughts and ideas are welcome. This mail is a rather
> long one, where I'm trying to show the different approaches I've
> thought.
>
> So the .dts format would be something like this, taking 4430SDP as an
> example. It's just an outline, missing dispc, hwmods,
> compatible-properties etc, which are not so relevant here.
>
> ocp {
> 	dss {
> 		dsi1 {
> 			taal {
>
> 			};
> 		};
> 	};
> };
>
> So there we have a Taal panel, connected to DSI1 output interface, which
> is part of the OMAP display subsystem.
>
> One thing to note here is that although there's only one panel under
> dsi1 in this case, the current SW supports having multiple panels under
> one output interface. And while the output can support only one active
> panel at a time, we do have boards where two panels are connected to one
> output, and there's some kind of HW switch used to select which panel is
> enabled.
>
> The first problem here is that I don't know how to manage the switch
> part. With current SW we have had the switch handling in the board
> files, in functions called when a display is enabled/disabled. I guess
> one option is to have the switch related code in their own drivers,
> totally apart from the dss code, perhaps offering a sysfs interface or
> such. And then, if the switch happens to be in the wrong position, the
> panel will fail in some way.

DT is supposed to reflect the HW capability, so if you do have two 
panels on a board, then both should be described in the DTS.

I'm just wondering if the multiple panels is something supported by the 
DSI protocol or it is a HW hacks done on TI board only?

Maybe in that case the DSI mux HW will have to be represented in the DT 
hierarchy as well.

> The second problem is about the DT properties. With multiple panels it's
> not possible to do this:
>
> dsi1 {
> 	dsi-ddr-clk =<250000000>;
>
> 	taal {
> 	};
>
> 	some-other-panel {
> 	};
> };
>
> because the panels could require different dsi clock rates. So we need
> something like this:
>
> dsi1 {
> 	taal {
> 		dsi-ddr-clk =<250000000>;
> 	};
>
> 	some-other-panel {
> 		dsi-ddr-clk =<350000000>;
> 	};
> };
>
> However, here the problem is that while ultimately we're interested in
> the ddr-clk rate, calculation of the rate is non-trivial and may need
> customizations at times. So instead of the clock rate we actually need
> to define a bunch of dividers/multipliers.

Well, in theory you should not. This is up to the clock provider to 
convert the clock rate in the proper n/m value. This is how it is done 
for the regular OMAP DPLLs.

> But these dividers are OMAP specific things, and do not belong to Taal
> driver. So this bring the question: is the general rule about DT node
> properties such that only the driver handling the particular node should
> read the properties in that node? So, in the example above, should the
> dsi driver only read props in the dsi1 and dsi2 nodes, and never look at
> props in the taal nodes?

Yes, because the taal parameters should be relative to the Taal HW spec 
that should not have a clue about the current DSI bus in used.

This is the clock provider that will have to handle that.

> So basically, can we do this:
>
> dsi1 {
> 	taal {
> 		omap-specific-clk-divs =<1 2 3 4 5 6 7>;
> 	};
>
> 	some-other-panel {
> 		omap-specific-clk-divs =<7 6 5 4 3 2 1>;
> 	};
> };
>
> and the Taal driver would ignore those, but dsi driver would use them?
> This looks like quite easy solution to this, but also doesn't feel
> right. So my current idea is to have clk-div tables in the dsi node,
> something like this:
>
> dsi1 {
> 	omap-specific-clk-divs =<
> 		250 1 2 3 4 5 6 7 /* divs that produce 250MHz clk */
> 		350 7 6 5 4 3 2 1 /* divs that produce 350MHz clk */
> 	>;

That's the idea, except that this will represent the clock provider.

>
> 	taal {
> 		dsi-ddr-clk =<250000000>;

And here you will have a phandle to the clock provider. And use it to 
set the proper clock rate.

> 	};
>
> 	some-other-panel {
> 		dsi-ddr-clk =<350000000>;
> 	};
> };
>
> Here the panel drivers would ask the DSI driver to configure DSI DDR clk
> of 250/350MHz, and the DSI driver would then use the lookup table to
> find the dividers. If the lookup fails, the DSI driver could fail or try
> to calculate the dividers itself. Other platforms could handle the DDR
> clk configuration however they see best.
>

Grant was working on the clock device tree binding. I'm not sure it got 
merged yet. But that should not there soon.

> ---
>
> Another thing related to DSI command mode panels is the DSI lane
> configuration, and I can't make my mind if they belong to the panel
> driver in some way or not.
>
> So, again taking SDP board and Taal as an example, we have 6 pads on
> OMAP which are used for communicating with Taal. The pads need to be
> muxed to DSI mode like any other OMAP pads. Currently the pad muxing is
> not touched by the driver, but I think it's doable in the DSI driver (as
> long as the DSI driver knows the required pad config).
>
> However, that's not enough.
>
> DSI uses differential pairs for communication (a "lane" consists of two
> wires), and we have always one clock lane, and a number of data lanes.
> In Taal's case we have a clock lane and two data lanes, which means 6
> pads/wires.
>
> We need to configure which of the OMAPs pads is used for which function,
> so, for example, pad x and x+1 are used for clock lane, and x is the
> negative pair and x+1 is the positive pair. And this configuration has
> to match the wiring going to the panel, so that clk+ from OMAP goes to
> clk+ in the panel.
>
> So it dts data we need something, perhaps, like below. Here we define
> the pad numbers and polarities in an array, where the first cell-pair is
> for clk, then data1, then data2 and so on (if there are more than two
> data lanes).
>
> lanes =<
> 	/* pad-pair number, polarity */
> 	1 0	/* DSI pad pair 1 is used for clk, pol +/-  */
> 	2 1	/* DSI pad pair 2 is used for data1, pol -/+ */
> 	0 0	/* DSI pad pair 0 is used for data2, pol +/- */
>> ;
>
> Now, I don't quite know where this data should be. If it's in the
> dsi-node, it doesn't work with multiple panels.

Is the lane configuration only dependent of the panel?

> But then, it's quite
> OMAP specific thing. While other platforms probably need some kind of
> pad configuration also, it may be something totally different. And so it
> doesn't feel right in the taal-node either.
>
> And a look-up table like in the clock case doesn't make much sense
> either, as we don't have a key here, as we had in the clock case (the
> dsi-ddr-clk).

The lane configuration code will belong to the DSI driver. The data will 
belong to the panel. The panel might use some phandle to the various DSI 
lane config a provide the needed information.

This look pretty similar to the pinmux device tree binding that is 
currently under discussion.

> So basically the only option I've come up with is to define the lane
> configuration in the panel's data, and let the dsi driver peek there and
> configure the HW. And this doesn't feel right.

This is fine, except for the last part. The panel driver should retrieve 
the data from the panel node, and call some DSI configuration API using 
the DSI phandle retrieved from the panel node as well or using the 
parent node directly if the hierarchy is always the same.

You should have a look at pinmux and clock binding discussion. Even the 
way GPIO binding is working should give you some hints.

Regards,
Benoit
