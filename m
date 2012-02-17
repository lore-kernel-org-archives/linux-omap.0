From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 17 Feb 2012 12:21:25 -0800
Message-ID: <20120217202125.GF18185@atomide.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <4F3E6323.9020101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39581 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab2BQUVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 15:21:30 -0500
Content-Disposition: inline
In-Reply-To: <4F3E6323.9020101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [120217 05:53]:
> Tony,
> 
> On Wednesday 15 February 2012 11:58 PM, Tony Lindgren wrote:
> >Hi all,
> >
> >This series fixes up the issues noted by Russell on omap2_hsmmc_init()
> >where if TWL PMIC is compiled as a module we can't keep a bunch of
> >functions marked as __init like they should be. This series fixes
> >the issues by splitting omap2_hsmmc_init() into two functions.
> 
> I have a re-spin of this series ready with all the fixes I did
> while testing the insmod/unbind/bind test suggested by Russell.
> I could not figure out what branch your original patches were
> based on. So let me know what branch of your tree you want me
> to post this series on.

I have them on mainline commit a269c2f5a5ad2b24a19fdd723363daf18394ec85.

Note that we should fix what Russell noted separately for the -rc
series for the issue where reloading gpio-twl4030.ko calls
omap2_hsmmc_init() twice, maybe something like below for that.

Regards,

Tony

--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -428,6 +428,7 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	return 0;
 }
 
+static int omap_hsmmc_done;
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
 void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
@@ -491,6 +492,11 @@ void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
+	if (omap_hsmmc_done)
+		return;
+
+	omap_hsmmc_done = 1;
+
 	if (!cpu_is_omap44xx()) {
 		if (cpu_is_omap2430()) {
 			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
