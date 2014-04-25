From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Fri, 25 Apr 2014 08:31:50 -0700
Message-ID: <20140425153150.GA20807@atomide.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com>
 <535A4470.2000509@ti.com>
 <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36637 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaDYPb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2014 11:31:56 -0400
Content-Disposition: inline
In-Reply-To: <535A6C40.10609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140425 07:08]:
> On 25/04/14 15:58, Archit Taneja wrote:
> > On Friday 25 April 2014 04:48 PM, Tomi Valkeinen wrote:
> >> On 25/04/14 14:11, Archit Taneja wrote:
> >>> Hi,
> >>>
> >>> On Thursday 24 April 2014 03:47 PM, Tomi Valkeinen wrote:
> >>>> Add support to set OMAP5 DSI pin muxing.
> >>>>
> >>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>>> Cc: Tony Lindgren <tony@atomide.com>
> >>>> ---
> >>>>    arch/arm/mach-omap2/display.c | 35
> >>>> ++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 34 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-omap2/display.c
> >>>> b/arch/arm/mach-omap2/display.c
> >>>> index 16d33d831287..974461441fc3 100644
> >>>> --- a/arch/arm/mach-omap2/display.c
> >>>> +++ b/arch/arm/mach-omap2/display.c
> >>>> @@ -137,11 +137,42 @@ static int omap4_dsi_mux_pads(int dsi_id,
> >>>> unsigned lanes)
> >>>>        return 0;
> >>>>    }
> >>>>
> >>>> +#define CONTROL_PAD_BASE    0x4A002800
> >>>> +#define CONTROL_DSIPHY        0x614
> >>>> +
> >>>
> >>> I guess this is something we can move to our driver, and use sysconf to
> >>> get the register from DT.
> >>
> >> I just copied the same method as used for OMAP4.
> >>
> >> I guess sysconf is an option. But I really dislike the idea of moving
> >> omap control module code to a display driver... I'm not sure what other
> >> options we have, though. Maybe an OMAP DSI specific pinctrl driver?
> > 
> > OMAP4 has CONTROL_DSIPHY for configuring both lane enable/disbale, and
> > pull up/down, but OMAP5 has normal PAD_CONF registers for DSI lines(2
> > pins per register) for configuring pull up/down, and CONTROL_DSIPHY for
> > lane enable/disable.
> > 
> > We would have a very messed up pinctrl driver, but it would probably be
> > better than doing all this stuff in the driver.
> 
> Actually, this patch is not good. I should've looked at the code more
> carefully =).
> 
> This one does ioremap every time the function is called, which could be
> done multiple times.
> 
> And I think omap4_ctrl_pad_readl() can be used to access the registers.
> Like this (not tested):
> 
> #define OMAP5_CONTROL_DSIPHY		0x614
> 
> static int omap5_dsi_mux_pads(int dsi_id, unsigned lanes)
> {
> 	u32 enable_mask, enable_shift, reg;
> 
> 	if (dsi_id == 0) {
> 		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
> 		enable_shift = OMAP4_DSI1_LANEENABLE_SHIFT;
> 	} else if (dsi_id == 1) {
> 		enable_mask = OMAP4_DSI2_LANEENABLE_MASK;
> 		enable_shift = OMAP4_DSI2_LANEENABLE_SHIFT;
> 	} else {
> 		return -ENODEV;
> 	}
> 
> 	reg = omap4_ctrl_pad_readl(OMAP5_CONTROL_DSIPHY);
> 	reg &= ~enable_mask;
> 	reg |= (lanes << enable_shift) & enable_mask;
> 	omap4_ctrl_pad_writel(reg, OMAP5_CONTROL_DSIPHY);
> 
> 	return 0;
> }

Chances are any mux register in the syscon area already works with
pinctrl-single,pins or pinctrl-single,bits option. The ones in the
padconf area should be already mapped so the driver just has to
request them.

Regards,

Tony
