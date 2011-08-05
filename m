From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] OMAP4: HWMOD: fix DSS reset
Date: Fri, 05 Aug 2011 18:48:07 +0300
Message-ID: <1312559287.1735.13.camel@lappyti>
References: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com>
	 <1312281204-4708-4-git-send-email-tomi.valkeinen@ti.com>
	 <4E3C0498.50108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55531 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756649Ab1HEPvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 11:51:12 -0400
Received: by mail-ey0-f172.google.com with SMTP id 4so2446052eye.17
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 08:51:11 -0700 (PDT)
In-Reply-To: <4E3C0498.50108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-08-05 at 16:56 +0200, Cousson, Benoit wrote:
> Hi Tomi,
> 
> On 8/2/2011 12:33 PM, Valkeinen, Tomi wrote:
> > The HWMOD code currently fails to reset dispc and rfbi modules.
> >
> > This patch adds all DSS clocks as opt clocks for dispc, and sets
> > HWMOD_CONTROL_OPT_CLKS_IN_RESET. This seems to fix the issue, although
> > this feels like a hack.
> 
> Enabling the opt clock for a proper reset seems to be a feature in 
> several IPs. GPIO does require the same kind of trick.
> 
> > The reason why this patch fixes the reset issue is probably because 
> > dispc is the first DSS module being reset, and by enabling all the
> > clocks during dispc's reset we also allow the other DSS modules to
> > finish their reset as a side effect.
> 
> That part is a little bit unclear. Did you check that assumption with 
> the HW architect?

No. Do you know a contact we could ask this?

There's more tuning we need to do to DSS reset at some point, and while
we can discuss that later, during testing the custom DSS reset I noticed
that having a custom reset function for dss_core, which enables and
disables all the DSS clocks, the resets of dispc and rfbi go also
through fine.

So that also makes my theory sound true: there's a DSS HW reset at
power-on, but it's just "started", and doesn't proceed without the DSS
clocks. And the reset doesn't totally finish before all the DSS clocks
have been on.

So if we enable the hwmods individually one by one, we never get all the
clocks enabled at the same time, but the DSS reset has probably finished
after enabling/disabling all the hwmods as all clocks have been turned
on at some point. But, for example, dispc is being reset first, and at
that point only the ick and the main fck have been turned on, and the
DSS is still in some kind of "not-quite-reseted" state, causing dispc
reset fail.

> > Cc: Benoit Cousson<b-cousson@ti.com>
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++++
> >   1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 21f03d4..4731f6b 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -1349,8 +1349,15 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
> >   	&omap44xx_l4_per__dss_dispc,
> >   };
> >
> > +static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
> > +	{ .role = "sys_clk", .clk = "dss_sys_clk" },
> > +	{ .role = "tv_clk", .clk = "dss_tv_clk" },
> > +	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
> > +};
> > +
> 
> It seems that your are adding back the optional clocks your remove the 
> patch before. Is it done on purpose?

Yes. It's an extra remove/add, true, but I wanted to make the patches
independent. The previous patch removes the opt-clocks, because they are
extra in a sense that the driver doesn't use them. Then we are left with
the reset problem. This patch tries to fix the reset problem by adding
these opt-clocks back and setting the flag.

So my point was mainly to make this fourth patch easily changeable to
something else, if this approach is not good.

And I've been thinking that perhaps a simple custom reset function for
dss_core would be cleaner here. We would add the opt-clocks to dss_core
(instead of dss_dispc), and the custom reset function would enable all
DSS clocks, check the DSS reset status, and disable the clocks. Then it
would be somewhat similar than OMAP2/3. Or can the HWMOD fmwk do that
already? Is it possible to have a reset which only enables the clocks
and checks the reset status?

I can try that out and send a patch, if it sounds ok to you.

 Tomi


