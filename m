From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: don't try to register the main clock
 twice.
Date: Wed, 7 May 2014 23:20:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405072233470.23579@utopia.booyaka.com>
References: <1396007435-20100-1-git-send-email-wsa@the-dreams.de> <alpine.DEB.2.02.1404111829520.14347@utopia.booyaka.com> <20140417085539.GA7804@katana>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36345 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaEGXUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 19:20:20 -0400
In-Reply-To: <20140417085539.GA7804@katana>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, mporter@linaro.org, Benoit Cousson <bcousson@baylibre.com>, joelagnel@ti.com
Cc: NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@sang-engineering.com>

(+ Matt Porter, Joel Fernandes)

Hi Wolfram,

On Thu, 17 Apr 2014, Wolfram Sang wrote:

> thanks for the reply!

Always good to hear from you - 

> > > If omap_device_alloc is given 2 or more "struct omap_hwmod" it will try
> > > to register the 'main_clk' of each of them with the same alias - "fck" -
> > > against the same device.  This fails. So to avoid a warning, don't even
> > > try.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > [wsa: ported to top-of-tree]
> > > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > 
> > What devices and hwmods cause this warning on AM335x?   Ideally, there 
> > should only be one hwmod per device.  Usually when multiple hwmods are 
> > stacked up for a device, it means that something isn't right - either the 
> > hwmod data, or the device driver itself. 
> 
> I applied the patch because of the edma driver DT entry for the am335x.
> Check am33xx.dtsi, it has multiple hwmods. 

I just took a look at the EDMA DT data vis-a-vis SPRUH73J Section 11.2.2 
"Third-Party Transfer Controller (TPTC) Integration".  This section 
clearly indicates that the TPTCs have their own L3 Fast Interconnect slave 
ports, marked as "CFG Slave".  Cross-checking this with Table 2-1 "L3 
Memory Map" indeed indicates that these three devices have their own 1MB 
physical address ranges hanging off the L3.

So the EDMA DT data is flat-out wrong here and should not have been 
merged.  Looks like it was added by commit 
505975d3802f8d3a3c0905f38056213d06997b36 ("ARM: dts: AM33XX: Add EDMA 
support").  Matt, Joel, could you please fix this data?  The TPTCs are 
separate IP blocks with separate address ranges and MPU IRQs and should 
have separate DT nodes.

> I also get this message printed for the d_can driver with am335x; they 
> have two entries in drivers/clk/ti/clk-33xx.c. Probably as a workaround 
> to match the desired clock name for the d_can driver? Didn't really 
> investigate yet.

That's pretty weird.  I wonder where the second fck alias is coming from?  
The DT & hwmod data for those devices looks relatively straightforward.  
Is the hwmod code adding fck aliases for both of the entries from the 
clock file?

> > In the specific context of this patch, the problem would be: what if the 
> > two hwmods have different main_clk entries?  Which one should be 
> > associated with the "fck" alias?
> 
> Sadly, I am in a board bringup phase and can't really contribute to the
> discussions. Lots of other issues to tackle at the moment.

Understood.  Good luck with your board -


- Paul
