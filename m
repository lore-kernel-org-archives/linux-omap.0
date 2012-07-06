From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: miscellaneous PRCM & hwmod patches for
 3.6
Date: Fri, 6 Jul 2012 01:09:43 -0700
Message-ID: <20120706080943.GL1122@atomide.com>
References: <alpine.DEB.2.00.1207040935070.6760@utopia.booyaka.com>
 <20120705084002.GU1122@atomide.com>
 <CAMQu2gwuXnV7E8-+x9EN0qRF9B2OOgY3KMW-nd0GAqHUwHXkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14474 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab2GFIJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 04:09:47 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gwuXnV7E8-+x9EN0qRF9B2OOgY3KMW-nd0GAqHUwHXkGw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120705 04:26]:
>
> Looks like the merge has not happened correctly.
> I see from the commit log that, you had a merge conflict in omap_hwmod.c
> and probably while resolving that the below change got missed.
> 
> Tarun Kanti DebBarma (1):
>       ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
> 
> So I tried pulling Paul's branch again on "cleanup-part2" at commit 8cb8de5d87
> and it got merged without any conflicts.
> 
> Do you want to re-merge Paul's series in cleanup-part2 or re-apply the above
> patch ?

Hmm weird, I wonder how I managed to mess up the resolve like that..
I'll (re)apply the following fix as the branch has been pushed out already.

Regards,

Tony


Author: Tony Lindgren <tony@atomide.com>
Date:   Fri Jul 6 00:58:43 2012 -0700

    ARM: OMAP2+: Fix mismerge for omap_hwmod_get_main_clk() API
    
    Commit ac5b0ea3d (Merge tag 'omap-devel-f-for-3.6'...) had a merge
    conflict that somehow got incorrecly resolved in a lossy way for
    commit bed9d1bb (ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API).
    Fix the issue by applying the missing pieces.
    
    Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ebdf001..ff76ef1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3633,3 +3633,18 @@ void __init omap_hwmod_init(void)
 
 	inited = true;
 }
+
+/**
+ * omap_hwmod_get_main_clk - get pointer to main clock name
+ * @oh: struct omap_hwmod *
+ *
+ * Returns the main clock name assocated with @oh upon success,
+ * or NULL if @oh is NULL.
+ */
+const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return NULL;
+
+	return oh->main_clk;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 30f55eb..6132972 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -648,6 +648,8 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
 
 extern void __init omap_hwmod_init(void);
 
+const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
