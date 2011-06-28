From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/7] OMAP4: hwmod data: Replace main_clk with the real
 input clock
Date: Tue, 28 Jun 2011 11:37:56 +0300
Message-ID: <1309250276.1825.58.camel@deskari>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
	 <1309192391-12410-5-git-send-email-b-cousson@ti.com>
	 <1309243240.1825.24.camel@deskari>  <4E098C69.90203@ti.com>
	 <1309248860.1825.43.camel@deskari>  <4E09907A.5020308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:50132 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756143Ab1F1IiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 04:38:03 -0400
Received: by bwa18 with SMTP id 18so1776bwa.24
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 01:38:00 -0700 (PDT)
In-Reply-To: <4E09907A.5020308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-06-28 at 10:27 +0200, Cousson, Benoit wrote:
> On 6/28/2011 10:14 AM, Valkeinen, Tomi wrote:
> > On Tue, 2011-06-28 at 10:10 +0200, Cousson, Benoit wrote:
> >> Hi Tomi,
> >>
> >> On 6/28/2011 8:40 AM, Valkeinen, Tomi wrote:
> >>> On Mon, 2011-06-27 at 18:33 +0200, Benoit Cousson wrote:
> >>>> Previously, main_clk was a fake clock node that was accessing the
> >>>> PRCM modulemode register. Since the module mode is directly
> >>>> controlled by the hwmod fmwk, these fake clock node are not
> >>>> needed anymore. The hwmod main_clk will point directly to the
> >>>> input clock node if applicable.
> >>>> For example, some IPs, like the GPIOs, do not have any functional
> >>>> clock and are using only the iclk. In that case, the main_clk
> >>>> field will be empty.
> >>>>
> >>>> In the case of the DSS, we can now consider all the optional clock as
> >>>> main clock.
> >>>> That will simplify greatly the driver management and the integration
> >>>> with hwmod.
> >>>>
> >>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>>> Cc: Tomi Valkeinen<tomi.valkeinen@ti.com>
> >>>> Cc: Paul Walmsley<paul@pwsan.com>
> >>>> Cc: Rajendra Nayak<rnayak@ti.com>
> >>>> ---
> >>>>    arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  111 +++++++++++++---------------
> >>>>    1 files changed, 51 insertions(+), 60 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >>>> index e10d3f7..5c196a1 100644
> >>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >>>
> >>> <snip>
> >
> >>>> @@ -1456,7 +1455,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
> >>>>    	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_irqs),
> >>>>    	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
> >>>>    	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_sdma_reqs),
> >>>> -	.main_clk	= "dss_fck",
> >>>> +	.main_clk	= "dss_sys_clk",
> >>>>    	.prcm = {
> >>>>    		.omap4 = {
> >>>>    			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
> >>>
> >>> Hmm... I don't think this is right. By default the DSI uses dss_dss_clk
> >>> as the functional clock. sys_clk goes to the DSI PLL, and the output of
> >>> which can be later used as the fclk for DSI. But that requires setup.
> >>
> >> OK, it was not super clear from the DSS clock tree which one should be
> >> the main one.
> >> So you'd prefer to have the dss_dss_clk as main clock and keep the
> >> dss_sys_clk as a opt_clock?
> >
> > Yes, I think that makes more sense.
> >
> > My patch set had dss_dss_clk as the mainclock for all DSS blocks. You
> > have it a bit differently for venc, hdmi, rfbi.
> 
> Yep, I saw that but, I don't think it should be done like that.
> 
> > It's a bit difficult to
> > verify those, as the DSS and DISPC are anyway enabled before
> > venc/hdmi/rfbi, so the dss_dss_clk is anyway enabled. But they do make
> > sense by looking at the clock tree.
> 
> Mmm, I'm not sure of that. In theory the dss_dss_clk is mainly the 
> functional clock for the DISPC. It can be used as the source clock for 
> some other module like DSI, but it is not mandatory.

It is not mandatory for DSS/DISPC either, in the same way it's not
mandatory for DSI. But I think, for the time being, having dss_dss_clk
as the main_clk is the only way to get things working properly. (And I
mean for the hwmods that require it, not venc/rfbi/hdmi).

> In the case of venc, rfbi and hdmi, that dss_dss_clk is not even 
> connected to them.
> You do have a functional dependency between the DISPC and all the DSS 
> IPs, but that does not mean that the dss_dss_clk should be affected to 
> all the sub IPs.

Yep, I agree. It does look correct to me also. I just wanted to point
out the difference, which may cause problems if your analysis is not
correct.

And I also don't know how to test it, as it won't be visible in normal
use (as the DISPC is always enabled first, enabling dss_dss_clk).
Perhaps it'd be possible with lauterbach, or perhaps hacking around,
enabling only certain clks and DSS parts, to see if the modules wake up
correctly.

> This is up to your driver stack to handle that functional dependency.
> That's why here I was trying to focus only on the main functionnal clock 
> for each IP. There is no point to expose the dss_dss_clk to every hwmod 
> if the driver does not have anything to do with them.

Yep. No disagreement =).

 Tomi


