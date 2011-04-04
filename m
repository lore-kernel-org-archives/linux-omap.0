From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 04 Apr 2011 09:53:42 +0300
Message-ID: <1301900022.2715.12.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40838 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760Ab1DDGxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 02:53:48 -0400
Received: by ewy8 with SMTP id 8so1755216ewy.40
        for <linux-omap@vger.kernel.org>; Sun, 03 Apr 2011 23:53:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Paul, Benoit,

On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:

> Based on the E-mail thread so far, I'd say that changing the clock aliases 
> is the way to go for right now.  The clock aliases are not hardware data; 
> they just control how the clock hardware is mapped to the drivers.

I'd very much prefer this option. Below is a patch for this.

If Benoit doesn't complain too much about this, I'd like to get this
merged as soon as possible, as OMAP4 DSS is currently crashing in the
mainline kernel.

I can either handle it myself if I get your acks, or you can send a pull
request for this if you have some other patches going in also.

> Of course, at some point soon, those clock aliases are going to go away.  
> But hopefully you all will have converted the driver over to PM runtime at 
> that point.
> 
> Once that happens, there's another problem: omap_hwmod_enable() is defined 
> that the hardware registers should be accessible by the MPU after it 
> completes.  So by that definition, the hwmod code should be 
> enabling/disabling that dss_clk clock too when it enables/idles/shuts down 
> the hwmod.  Probably we'd need to mark that struct omap_hwmod_opt_clk with 
> some flag.  Then we'd need some kind of way for the DSS to tell the hwmod 
> code whether it is or isn't reliant on the PRCM-provided functional clock 
> for its internal functional clock.  Maybe something like 
> omap_hwmod_{release,require}_system_fclk()?

Hmm, right. I guess no other HW module has clock setups like this?

Currently DSS can use clk_enable/disable() for the system fclk when its
using DSI PLL for the fclk. So omap_hwmod_{release,require}_system_fclk
sounds like a simple solution to this.

Not directly related, but something I've been wondering about is how to
abstract the DSI/HDMI PLLs in DSS. What do you think, would it be
possible/worth it to create struct clks for the clocks coming out of
those PLLs? These would, of course, be DSS internal clks. I'm not very
familiar with the clock framework, so I don't really have any idea what
this would require and what would be the pros and cons.

---

>From f9999ceb48b2e22217dccc85b33362b6a17e5a00 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 4 Apr 2011 09:26:19 +0300
Subject: [PATCH] OMAP4: clock data: Change DSS clock aliases

DSS driver has used fck and ick clocks on OMAP2/3 to get DSS HW up and
running, and also to get the pixel clock's source clock rate from the
fck.

On OMAP4 the clock data is set up in a different way, as there's no ick,
dss_fck points to a fake clock which just affects DSS's MODULEMODE, and
dss_dss_clk if the DSS_FCK.

>From DSS driver's point of view the dss_fck sounds like an ick, and
dss_dss_clk is the fck. While this is not entirely correct from HW point
of view, especially for the ick, configuring the clock aliases that way
makes DSS "just work" with OMAP4's clock setup.

In the (hopefully near) future DSS driver will be reworked to use
pm_runtime support which should clean up the clock code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 276992d..8c96567 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3116,14 +3116,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
 	CLK("omapdss_dss",	"sys_clk",			&dss_sys_clk,	CK_443X),
 	CLK("omapdss_dss",	"tv_clk",			&dss_tv_clk,	CK_443X),
-	CLK("omapdss_dss",	"dss_clk",			&dss_dss_clk,	CK_443X),
 	CLK("omapdss_dss",	"video_clk",			&dss_48mhz_clk,	CK_443X),
-	CLK("omapdss_dss",	"fck",				&dss_fck,	CK_443X),
-	/*
-	 * On OMAP4, DSS ick is a dummy clock; this is needed for compatibility
-	 * with OMAP2/3.
-	 */
-	CLK("omapdss_dss",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omapdss_dss",	"fck",				&dss_dss_clk,	CK_443X),
+	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
-- 
1.7.1



