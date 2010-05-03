From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: quickly hack fix up init_opp
Date: Mon, 03 May 2010 09:15:35 -0700
Message-ID: <87hbmp6jx4.fsf@deeprootsystems.com>
References: <1272728589-5313-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50028 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161Ab0ECQPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 12:15:39 -0400
Received: by pwj9 with SMTP id 9so1273882pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 09:15:39 -0700 (PDT)
In-Reply-To: <1272728589-5313-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Sat\,  1 May 2010 10\:43\:09 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Peter Tseng <tsenpet09@gmail.com>

Nishanth Menon <nm@ti.com> writes:

> init_opp is seen to crash, in resource34xx.c BUG() causes
> a kernel oops when OPP layer is not registered!
>
> Original Report:
> http://marc.info/?l=linux-omap&m=127268352116119&w=2
>
> Cc: Peter Tseng <tsenpet09@gmail.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Reported-by: Peter Tseng <tsenpet09@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> IMPORTANT: Completely untested!! just for a dry-run and
> srf is going to go away in a month, so this is more or
> less a curio..

Tested on overo without OPP init and also needed this additional bit
below to avoid another BUG.  Will merge into your patch and add to
pm-srf branch.

With this, Overo boots, but will need OPP table init in board file to
use DVFS/CPUfreq.

Kevin

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index ae8bd09..2bc5694 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -533,7 +533,7 @@ void init_freq(struct shared_resource *resp)
 {
 	char *linked_res_name;
 	int ret = -EINVAL;
-	unsigned long freq;
+	unsigned long freq = 0;
 	resp->no_of_users = 0;
 
 	linked_res_name = (char *)resp->resource_data;
@@ -546,7 +546,8 @@ void init_freq(struct shared_resource *resp)
 	else if (strcmp(resp->name, "dsp_freq") == 0)
 		/* DSP freq in Mhz */
 		ret = opp_to_freq(&freq, OPP_DSP, curr_vdd1_opp);
-	BUG_ON(ret);
+	if (ret)
+		pr_err("%s: initializing frequency failed!\n", __func__);
 
 	resp->curr_level = freq;
 	return;
