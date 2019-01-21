From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Date: Mon, 21 Jan 2019 11:56:31 -0800
Message-ID: <20190121195631.GG5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com>
 <20190118203832.3be7975e@aktux>
 <20190118194536.GY5544@atomide.com>
 <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
 <20190121170743.GB5544@atomide.com>
 <20190121185344.7cff9641@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121185344.7cff9641@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tero Kristo <t-kristo@ti.com>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190121 17:54]:
> Hi,
> 
> On Mon, 21 Jan 2019 09:07:43 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Tero Kristo <t-kristo@ti.com> [190121 07:13]:
> > > On 18/01/2019 21:45, Tony Lindgren wrote:  
> > > > * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]:  
> > > > > Hi,
> > > > > 
> > > > > On Fri, 18 Jan 2019 10:36:30 -0800
> > > > > Tony Lindgren <tony@atomide.com> wrote:
> > > > > 
> > > > > [...]  
> > > > > > til the next workaround.
> > > > > >   
> > > > > > > That flags also causes the iclk being enabled/disabled
> > > > > > > manually.  
> > > > > > 
> > > > > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > > > > just means:
> > > > > > 
> > > > > > "manually enable and disable ocp interface clock"
> > > > > >   
> > > > > well, if we want to manually disable it and not automatically,
> > > > > we have to disable autoidle or it will be automatically disabled.
> > > > > 
> > > > > Disabling it manually when it is already auto-disabled (by autoidle) is
> > > > > just practically a no-op towards the clock.  
> > > > 
> > > > OK I buy that :) It should be probably added to the patch
> > > > description to make it clear what it changes.
> > > > 
> > > > Tero, any comments on this change?  
> > > 
> > > Well, seeing the flag is pretty much only used for a handful of hwmods
> > > nowadays, it should be fine. OMAP3 PM should be tested with this change
> > > though, as there are couple of hwmods impacted on that platform. I wonder
> > > what happens to cpuidle when display is active...  
> > 
> > OK so that's a good test case. AFAIK, we should have DSS idle
> > and have the SoC hit at least core retention with DSI command mode
> > displays. I don't know if this patch would block DSS autoidle then
> > or not.. I'm guessing 80% chance that we still need DSS hit runtime
> > suspend to enter SoC idle states meaning this patch would not
> > affect it :)
> > 
> So this is a call to Nokia N950 owners?

Well sort of.. But the LCD command mode patches are still pending.
I've added Aaro and Sebastian to Cc in case they have it testable.

> Unfortunately, I do not have one. I have seen on non-command-mode
> displays that dss goes to idle when display is blanked.

OK. And I did a brief test on droid4 with the pending DSI
command mode patches by sprinkling some OCPIF_SWSUP_IDLE
to DSS and DSI with the hack below (that is not needed for
normal use). Things idle just fine for me when LCD is on
and I can see the SoC hit core retention the same way as
without the test patch below.

So as far as I'm concerned, these patches are good to go
and I'll go ack the patches.

Thanks,

Tony

8< --------------------
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3424,6 +3424,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "l3_div_ck",
 	.user		= OCP_USER_SDMA,
+	.flags		= OCPIF_SWSUP_IDLE,
 };
 
 /* l4_per -> dss */
@@ -3472,6 +3473,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l3_div_ck",
 	.user		= OCP_USER_SDMA,
+	.flags		= OCPIF_SWSUP_IDLE,
 };
 
 /* l4_per -> dss_dsi2 */
@@ -3480,6 +3482,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi2 = {
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l4_div_ck",
 	.user		= OCP_USER_MPU,
+	.flags		= OCPIF_SWSUP_IDLE,
 };
 
 /* l3_main_2 -> dss_hdmi */
