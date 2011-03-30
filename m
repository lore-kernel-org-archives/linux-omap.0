From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Wed, 30 Mar 2011 15:58:50 +0300
Message-ID: <1301489930.15095.51.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+1XMYzvfJEMsesrkPJ16"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36563 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754785Ab1C3M65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 08:58:57 -0400
Received: by yxa15 with SMTP id 15so578122yxa.23
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 05:58:55 -0700 (PDT)
In-Reply-To: <4D931E21.8090305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>


--=-+1XMYzvfJEMsesrkPJ16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-03-30 at 14:12 +0200, Cousson, Benoit wrote:
> On 3/30/2011 1:03 PM, Valkeinen, Tomi wrote:
> > On Wed, 2011-03-30 at 11:32 +0200, Cousson, Benoit wrote:
> >> Hi Tomi,
> >>
> >> On 3/30/2011 8:48 AM, Valkeinen, Tomi wrote:
> >>> Hi Benoit, Paul,
> >>>
> >>> I've been discussing with Sumit and Archit to understand how the DSS
> >>> clocks are set up on OMAP4. I think I now have some idea how things
> >>> work, but I'm still at loss why things are the way they are.
> >>>
> >>> So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
> >>> clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
> >>> and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
> >>> controllable, but it is affected by MODULEMODE bit.
> >>>
> >>> Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
> >>> and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
> >>> the TRM's DSS_FCLK.
> >>>
> >>> Was that correct?
> >>
> >> Yes. For the moment, but this is not the final state.
> >>
> >>> If so, from DSS driver's perspective, the dss_fck sounds very much like
> >>> an interface clock (it's always needed when DSS is used) and dss_dss_clk
> >>> sounds very much like functional clock (it's always needed, except if
> >>> DSI PLL is used for DSS functional clock).
> 
> dss_dss_fck is one of the possible functional clocks, hence the optional 
> attribute. You can run the DSS only for sys_clk is you want.

We can? I remember this was possible on OMAP2, but I can't seem to find
it on OMAP4 TRM...

Ah right, you mean sys_clk goes to DSI PLL, and the output from DSI PLL
can be used as functional clock?

We _always_ need DSS_FCLK to get DSS up and running, and to configure
DSI PLL if we want to get the clocks from there. So it's not quite that
optional. But it's true that we can turn it off later.

> That's why the hwmod fmwk cannot choose for you which one you will need 
> depending of your panel. It is up to the driver to select the correct one.

But isn't that DSS internal thing? (I'm looking again at the DSS clock
tree figure). DSS_FCLK from the PRCM should always be the same from
DSS's point of view, it doesn't change. If we use the clock from DSI
PLL, we'll get clock for LCD2_CLK, LCD1_CLK and DISPC_FCLK. But
DSS_FCLK/DSS_CLK is always the same.

> >>> If "dss_fck" would control DSS_FCLK and "dss_ick" would control
> >>> MODULEMODE, they would be about the same as the clocks in OMAP2 and 3,
> >>> and we wouldn't need any omap4 spesific trickery in the DSS driver.
> >>> ("dss_dss_clk" wouldn't be needed).
> >>
> >> You cannot play with iclk, because this clock is supposed to be handled
> >> automatically by the HW. This was the case on OMAP2&  3 as well BTW.
> >
> > Right.
> >
> > But now we have 1) dss_fck, which isn't the DSS_FCLK in TRM, and in fact
> > not fck at all, or even clock at all 2) dss_dss_clk, a new clock whose
> > name doesn't match to anything in TRM, and is in fact the DSS_FCLK.
> >
> > So they both sound like they are confusingly named.
> 
> The naming convention is simple: opt clock are using the module name + 
> the original clock name: "dss_XXX", whereas the modulemode is using the 
> module name + fck, because it is for the moment similar to the fclk we 
> have on simpler module. iclk_en is not exposed at all on OMAP4.
> 
> optional clocks:
> 
> static struct clk dss_sys_clk = {
> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
> 	.enable_bit	= OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,
> 
> static struct clk dss_tv_clk = {
> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
> 	.enable_bit	= OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,
> 
> static struct clk dss_dss_clk = {
> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
> 	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
> 
> static struct clk dss_48mhz_clk = {
> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
> 	.enable_bit	= OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
> 
> 
> MODULEMODE:
> 
> static struct clk dss_fck = {
> 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
> 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,

Okay, the naming makes sense now that you explained the convention.

I think I'm finally starting to get this =).

> > If we had dss_fck matching to DSS_FCLK and dss_ick for MODULEMODE, they
> > would, in my opinion, be much more understandable and in many ways
> > relate to the way things are in the HW. Additionally this would match
> > the way clocks are on OMAP2/3 and things would just work.
> 
> No, because you should not have to play with iclk at all.
> BTW, for my point of view you have such issue because your are still not 
> using the pm_runtime API.
> As soon as you will switch to pm_runtime, iclk_en and fclk_en (OMAP2&3 
> name) or MODULEMODE will be handle by the fmwk. The driver will just 
> have to handle the optional clock.
> 
> > So while I understand that neither the current way and my suggestion
> > exactly match the HW, and also that things are not ready yet and the
> > clocks will change, I don't understand why such a strange method to name
> > the clocks was used, when there's a simpler and backward compatible way.
> 
> The point is that this automated method works for every IPs in the OMAP 
> except the DSS that is not managing its clocks like other modules.

With this do you mean that the SW does not manage clocks like other
modules (should use pm_runtime?), or the HW is somehow different?

> Moreover, since the clock fmwk is creating aliases for these clock 
> nodes, you should never see at all that dss_dss_clk node that seems to 
> bother you.

Oh, that doesn't bother me =). What bothers me is that DSS did not
suddenly work because the clocks were set up in this manner.

Perhaps the aliases should have been setup differently, at least
temporarily, to get things working more easily.

Currently we have these aliases for OMAP4:

"dss_clk" -> dss_dss_clk
"fck" -> dss_fck
"ick" -> dummy_ck

If that would be changed to:

"fck" -> dss_dss_clk
"ick -> dss_fck

The driver would work the same way for all OMAPs.

> > And if this current way to handle OMAP4 DSS clocks is for some reason
> > better and can't be changed, could the OMAP2/3 clocks also be changed to
> > keep things consistent between OMAPs? Because the inconsistency between
> > platforms is the biggest problem for me.
> 
> As I said previsously, pm_runtime should fix these issues.

Ok. I really need to find time to look at that. Sumit has been working
on it, I hope it'll be ready soon =).

Anyway. To get things working for rc2 (DSS currently crashes due to not
enabling dss_clk) we need to either:
1) Change the clock aliases as above
2) Add something like Sumit's patch (attached) to handle dss_clk. While
the patch is not that complex, it feels rather hacky.

What's your opinion?

 Tomi


--=-+1XMYzvfJEMsesrkPJ16
Content-Disposition: attachment; filename="0001-OMAP4-DSS2-add-dss_dss_clk.patch"
Content-Type: text/x-patch; name="0001-OMAP4-DSS2-add-dss_dss_clk.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 0722361a0921296c980cb9011dad42f56c929007 Mon Sep 17 00:00:00 2001
From: Sumit Semwal <sumit.semwal@ti.com>
Date: Tue, 1 Mar 2011 14:23:09 +0530
Subject: [PATCH] OMAP4:DSS2: add dss_dss_clk.

dss_dss_clk is a new clock needed in OMAP4 as an opt-clock.
Adding the same in dss clock handling.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/dss.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3d0277d..6c1a090 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -67,6 +67,7 @@ static struct {
 	struct clk	*dss_sys_clk;
 	struct clk	*dss_tv_fck;
 	struct clk	*dss_video_fck;
+	struct clk	*dss_dss_clk;
 	unsigned	num_clks_enabled;
 
 	unsigned long	cache_req_pck;
@@ -706,6 +707,7 @@ static int dss_get_clocks(void)
 	dss.dss_sys_clk = NULL;
 	dss.dss_tv_fck = NULL;
 	dss.dss_video_fck = NULL;
+	dss.dss_dss_clk	= NULL;
 
 	r = dss_get_clock(&dss.dss_ick, "ick");
 	if (r)
@@ -738,6 +740,12 @@ static int dss_get_clocks(void)
 			goto err;
 	}
 
+	if (pdata->opt_clock_available("dss_clk")) {
+		r = dss_get_clock(&dss.dss_dss_clk, "dss_clk");
+		if (r)
+			goto err;
+	}
+
 	return 0;
 
 err:
@@ -751,7 +759,8 @@ err:
 		clk_put(dss.dss_tv_fck);
 	if (dss.dss_video_fck)
 		clk_put(dss.dss_video_fck);
-
+	if (dss.dss_dss_clk)
+		clk_put(dss.dss_dss_clk);
 	return r;
 }
 
@@ -763,6 +772,8 @@ static void dss_put_clocks(void)
 		clk_put(dss.dss_tv_fck);
 	if (dss.dss_sys_clk)
 		clk_put(dss.dss_sys_clk);
+	if (dss.dss_dss_clk)
+		clk_put(dss.dss_dss_clk);
 	clk_put(dss.dss_fck);
 	clk_put(dss.dss_ick);
 }
@@ -810,8 +821,16 @@ static void dss_clk_enable_no_ctx(enum dss_clock clks)
 
 	if (clks & DSS_CLK_ICK)
 		clk_enable(dss.dss_ick);
-	if (clks & DSS_CLK_FCK)
+	/*
+	 * XXX: tie dss_dss_clk to FCK - this will change with following
+	 * pm_runtime patches. Needed for OMAP4 boot up due to stricter
+	 * clock cutting in pm framework post 2.6.38-rc5.
+	 */
+	if (clks & DSS_CLK_FCK) {
 		clk_enable(dss.dss_fck);
+		if (dss.dss_dss_clk)
+			clk_enable(dss.dss_dss_clk);
+	}
 	if ((clks & DSS_CLK_SYSCK) && dss.dss_sys_clk)
 		clk_enable(dss.dss_sys_clk);
 	if ((clks & DSS_CLK_TVFCK) && dss.dss_tv_fck)
@@ -838,8 +857,16 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
 
 	if (clks & DSS_CLK_ICK)
 		clk_disable(dss.dss_ick);
-	if (clks & DSS_CLK_FCK)
+        /*
+         * XXX: tie dss_dss_clk to FCK - this will change with following
+         * pm_runtime patches. Needed for OMAP4 boot up due to stricter
+         * clock cutting in pm framework post 2.6.38-rc5.
+         */
+	if (clks & DSS_CLK_FCK) {
 		clk_disable(dss.dss_fck);
+		if (dss.dss_dss_clk)
+			clk_disable(dss.dss_dss_clk);
+	}
 	if ((clks & DSS_CLK_SYSCK) && dss.dss_sys_clk)
 		clk_disable(dss.dss_sys_clk);
 	if ((clks & DSS_CLK_TVFCK) && dss.dss_tv_fck)
-- 
1.7.1


--=-+1XMYzvfJEMsesrkPJ16--

