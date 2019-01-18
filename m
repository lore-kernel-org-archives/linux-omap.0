From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Date: Fri, 18 Jan 2019 10:36:30 -0800
Message-ID: <20190118183630.GX5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118181827.7163bee4@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190118 17:18]:
> On Fri, 18 Jan 2019 07:48:07 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190116 22:04]:
> > > Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> > > that makes hwmods working properly which cannot handle
> > > autoidle properly in lower power states.  
> > 
> > Sorry if I'm still missing something :)
> > 
> > But doesn't this now block autoidle for all modules
> > with OCPIF_SWSUP_IDLE even if they work just fine with
> > autoidle?
> 
> According to the code comments, it was just meant for that.
>              if (os->flags & OCPIF_SWSUP_IDLE) {
> -                       /* XXX omap_iclk_deny_idle(c); */
> +                       /*

Hmm..

> I guess there are workarounds for the other modules in place,
> or critical situations were not found yet. 
> The other affected module is e.g. DSS. And we had some trouble
> in initialisation order for omap3 in the past and did some
> quirks. Probably we also fixed issues in reality caused by
> having the autoidle bit set.

Yes this is rather confusing plus we can't do anything
from the interconnect or reset device drivers to block
autoidle for a clock currently.

So I'd like to have a generic interfaces for clk_deny_idle()
and clk_allow_idle() in place for a proper hardware based
solution instead of the hackish PM QoS DMA latency tinkering
and other workarounds. Anything else feels just like kicking
the can until the next workaround.

> That flags also causes the iclk being enabled/disabled
> manually.

Yes but SWSUP_IDLE for the interface clock to me currently
just means:

"manually enable and disable ocp interface clock"

and with your changes it becomes:

"manually enable and disable ocp interface clock and block
 autoidle while in use".

So aren't we now changing the way things behave in general
for SWSUP_IDLE?

> Did you see any regressions? The patch is now 3 month old
> and nobody complained. I checked module idlest bits and did
> not see any changes.

Sorry for all the delays. But I also need to consider how
this is going to make things easier for moving to use
drivers/reset for example. And it seems we're just now
piling up more dependencies and don't have a generic
interface that keeps preventing doing proper device
drivers. I don't see issue with your patches except for
the few open questions in this email.

> > I think what you want to do is keep clocks enabled
> > while in use?
> > 
> > If so, how about using HWMOD_CLKDM_NOAUTO:
> > 
> > "HWMOD_CLKDM_NOAUTO: Allows the hwmod's clockdomain to
> >  be prevented from entering HW_AUTO while hwmod is
> >  active."
> 
> That is about iclk. I think we should have clear wording here
> between all the idle things.

Do you mean HWMOD_CLKDM_NOAUTO is about the module clock
while your patches are about the ocp interface clock?
Yup that's confusing between ocp interface clock and the
module clock..

Then we also have SWSUP_IDLE vs SWSUP_SIDLE that can get
confused :)

BTW, is the ocp module interface clock also the module
clock in your case?

> > > Affected is e. g. the omap_hdq.  
> > 
> > Have you already tried what happens if you just tag
> > omap_hdq with HWMOD_CLKDM_NOAUTO?
> > 
> Well, I am just happy with having that single bit cleared.
> But having two flags for the same things makes no sense to me.

To me it seems there are at least the following case where we
need to block autoidle for clocks:

1. Modules that need to stay active and don't automatically
   block SoC idle states (mcbsp, hdq) where this should
   happen automatically when pm_runtime_get() is done.

2. Any drivers/reset driver while doing a reset

Regards,

Tony
