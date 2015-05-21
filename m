From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Thu, 21 May 2015 03:06:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505210254330.7960@utopia.booyaka.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com> <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com> <555C744C.6070901@ti.com> <555C74E8.5010105@ti.com> <555CE1BF.4050506@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53088 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbEUDGQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 23:06:16 -0400
In-Reply-To: <555CE1BF.4050506@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org

On Wed, 20 May 2015, Stephen Boyd wrote:

> On 05/20/15 04:50, Tero Kristo wrote:
> >
> >>>
> >>> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
> >>>       if (rc)
> >>>           pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
> >>>
> >>> +    hdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
> >>> +    rc = clk_prepare_enable(hdcp_ck);
> >>> +    if (rc)
> >>> +        pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
> >>> +
> >>>       return rc;
> >>>   }
> >>>
> >>
> >> You should rather use the assigned-clock properties in DT to accomplish
> >> this, the manual clock tweaks under the drivers/clk/ti/clk-* files
> >> should be converted to DT setup also.
> >
> > Now that I sent this, I realize we only have support to set_parent /
> > set_rate through the assigned-clock props, no enable. Any plans to
> > extend this support Mike/Stephen?
> >
> >
> 
> Enable falls under the "critical clocks" discussion that is ongoing. I
> assume that this is some sort of critical clock that can't be turned off?

It only needs to be enabled for this particular display IP subsystem to 
function:

http://marc.info/?l=linux-omap&m=142071550111482&w=2

I believe Tomi is taking this approach (enabling it unconditionally) to 
avoid adding support for a secondary IP block "main clock" to the hwmod 
code.  Apparently, the chips that contain this clock gating bit are not 
intended to be used for power-critical use cases, so there's not much 
motivation to switch it on and off with the display controller.


- Paul
