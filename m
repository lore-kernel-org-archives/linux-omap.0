From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Date: Mon, 21 Jan 2019 09:07:43 -0800
Message-ID: <20190121170743.GB5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com>
 <20190118203832.3be7975e@aktux>
 <20190118194536.GY5544@atomide.com>
 <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190121 07:13]:
> On 18/01/2019 21:45, Tony Lindgren wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]:
> > > Hi,
> > > 
> > > On Fri, 18 Jan 2019 10:36:30 -0800
> > > Tony Lindgren <tony@atomide.com> wrote:
> > > 
> > > [...]
> > > > til the next workaround.
> > > > 
> > > > > That flags also causes the iclk being enabled/disabled
> > > > > manually.
> > > > 
> > > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > > just means:
> > > > 
> > > > "manually enable and disable ocp interface clock"
> > > > 
> > > well, if we want to manually disable it and not automatically,
> > > we have to disable autoidle or it will be automatically disabled.
> > > 
> > > Disabling it manually when it is already auto-disabled (by autoidle) is
> > > just practically a no-op towards the clock.
> > 
> > OK I buy that :) It should be probably added to the patch
> > description to make it clear what it changes.
> > 
> > Tero, any comments on this change?
> 
> Well, seeing the flag is pretty much only used for a handful of hwmods
> nowadays, it should be fine. OMAP3 PM should be tested with this change
> though, as there are couple of hwmods impacted on that platform. I wonder
> what happens to cpuidle when display is active...

OK so that's a good test case. AFAIK, we should have DSS idle
and have the SoC hit at least core retention with DSI command mode
displays. I don't know if this patch would block DSS autoidle then
or not.. I'm guessing 80% chance that we still need DSS hit runtime
suspend to enter SoC idle states meaning this patch would not
affect it :)

> > > > and with your changes it becomes:
> > > > 
> > > > "manually enable and disable ocp interface clock and block
> > > >   autoidle while in use".
> > > > 
> > > > So aren't we now changing the way things behave in general
> > > > for SWSUP_IDLE?
> > > > 
> > > Yes, we are, so proper testing is needed. But If I read those comments
> > > it was always intended this way but not fully implemented because it
> > > appeared to be more work like needing a usecounter (which my patchset
> > > also adds) for that autoidle flag.
> > 
> > OK yeah the use count seems necessary. I'll test here
> > with my PM use cases.

Regards,

Tony
