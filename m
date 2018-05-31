From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/6] ARM: dra762: hwmod: Add MCAN support
Date: Thu, 31 May 2018 09:39:21 -0700
Message-ID: <20180531163921.GO5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-2-faiz_abbas@ti.com>
 <20180530145047.GC5705@atomide.com>
 <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
 <20180530152825.GG5705@atomide.com>
 <b0476932-a6e9-6ef1-69ad-c9a8c55d9739@ti.com>
 <20180530155448.GH5705@atomide.com>
 <98c989ca-0694-5150-f74b-35f3e4bf20c0@ti.com>
 <20180531152623.GN5705@atomide.com>
 <f74763ed-7e27-146b-6856-6be1b2ba630d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f74763ed-7e27-146b-6856-6be1b2ba630d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180531 16:36]:
> Hi,
> 
> On Thursday 31 May 2018 08:56 PM, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [180531 06:18]:
> >> On 30/05/18 18:54, Tony Lindgren wrote:
> >>> * Tero Kristo <t-kristo@ti.com> [180530 15:44]:
> >>>> On 30/05/18 18:28, Tony Lindgren wrote:
> >>>>> * Tero Kristo <t-kristo@ti.com> [180530 15:18]:
> >>>>>> For the OCP if part, I think that is still needed until we switch over to
> >>>>>> full sysc driver. clkctrl_offs you probably also need because that is used
> >>>>>> for mapping the omap_hwmod against a specific clkctrl clock. Those can be
> >>>>>> only removed once we are done with hwmod (or figure out some other way to
> >>>>>> assign the clkctrl clock to a hwmod.)
> >>>>>
> >>>>> Hmm might be worth testing. I thought your commit 70f05be32133
> >>>>> ("ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available")
> >>>>> already parses the clkctrl from dts?
> >>>>
> >>>> It maps the clkctrl clock to be used by hwmod, if those are available. We
> >>>> didn't add any specific clock entries to DT for mapping the actual clkctrl
> >>>> clock without the hwmod_data hints yet though, as that was deemed temporary
> >>>> solution only due to transition to interconnect driver. I.e., you would need
> >>>> something like this in DT for every device node:
> >>>>
> >>>> &uart3 {
> >>>>    clocks = <l4per_clkctrl UART3_CLK 0>;
> >>>>    clock-names = "clkctrl";
> >>>> };
> >>>>
> >>>> ... which is currently not present.
> >>>
> >>> Hmm is that not the "fck" clkctrl clock we have already in
> >>> the dts files for the interconnect target modules?
> >>
> >> Oh okay, yeah, we could parse that one, but currently it is not done, and is
> >> not present for everything either I believe.
> >>
> >>> We can also use pdata callbacks to pass the clock node if
> >>> needed. But I guess I don't quite still understand what we
> >>> are missing :)
> >>
> >> So, what is missing is the glue logic only from the hwmod codebase. Right
> >> now this is not supported but should be relatively trivial thing to add if
> >> we really want to do this.
> > 
> > OK let's think about this a bit for v4.19 then.
> > 
> 
> I am not sure what the conclusion is. Should I try removing the
> clkctrl_offsets, clkdm_name, and main_clk?

No need to, it's not going to work currently without them.

Regards,

Tony
