From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT support
Date: Fri, 2 Sep 2011 13:43:48 +0200
Message-ID: <4E60C174.50604@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com> <1314897912-18178-7-git-send-email-b-cousson@ti.com> <20110902080944.GP3548@atomide.com> <4E609800.9090402@ti.com> <20110902104330.GR3548@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab1IBLoD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 07:44:03 -0400
In-Reply-To: <20110902104330.GR3548@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

On 9/2/2011 12:43 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110902 11:13]:
>> Hi Tony,
>>
>> On 9/2/2011 10:09 AM, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Benoit Cousson<b-cousson@ti.com>   [110901 19:52]:
>>>> Create an OMAP3 generic board to start the DT migration.
>>>
>>> I don't think this needs to be SoC specific, we can add multiple
>>> DT_MACHINE_START entries into a single file. So it should be
>>> just board-omap-dt.c.
>>
>> I do agree, it should not, I made that comment into the
>> board-omap4-dt.c, but for the moment we still have dedicated OMAP
>> specifics stuff at board level, like the map_io.
> 
> Well map_io can also be set in DT_MACHINE_START. For most part
> it already is generic like omap3_map_io and omap4_map_io.
> So that should not stop anything.

OK, I think I was trying to be a little bit more extreme, meaning only one omap_map_io for every OMAPs.
Then, inside omap_map_io we can use the DT compatible information to retrieve the proper OMAPs revision and thus use the proper init table.

Whereas in your case you are still relying on the various DT_MACHINE entries to detect which OMAP revision is used.

It looks to me that relying on several DT_MACHINE_START to identify a SoC version is a little bit more a hack. 
I will let the device-tree experts answering that question :-)
For my point of view, using DT compatible in the various place where the OMAP revision is important, might allow a finer granularity.

>> I have an other series that make the map_io DT aware to get rid of
>> that, but it still not finalized.
> 
> Hmm maybe take a look again? We've already sorted out quite a bit
> of the init stuff over past few merge windows. If there's still
> something blocking that, let's clear it out ASAP.

Now that I understand your approach, it is fine. Please find below an example of what I was trying to achieve, and why that point was an issue.
The clear advantage of your method is that not further effort will be require for this part. At least for the moment.

>> My goal was have a single DT_MACHINE_START for every OMAPs.
>> But, meanwhile, if you prefer one file with many board descriptors,
>> that's fine.
> 
> Yes that's better. We should only need a separate DT_MACHINE_START
> for major SoC variants.

OK, I'll try that.

Thanks,
Benoit

---
>From a8edcd113b6fa38620dae11bcbb55daa84dfb07c Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Mon, 22 Aug 2011 11:10:38 +0200
Subject: [PATCH] OMAP2+: Add a common method to init globals using DT compatible

Thanks to the DT root node compatible information, we can extract
the compatible SoC and use it to select the proper globals.
Create a common omap2_set_globals API that can be used by every
OMAP2+ platforms.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.c             |   73 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    1 +
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 3f20cbb..ee5a225 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_fdt.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
@@ -140,3 +141,75 @@ void __init omap2_set_globals_443x(void)
 }
 #endif
 
+#ifdef CONFIG_OF
+/*
+ * DT method to get the proper globals configuration
+ */
+static const struct of_device_id omap_soc_match[] = {
+#if defined(CONFIG_ARCH_OMAP4)
+        {
+                .compatible = "ti,omap4",
+                .data = &omap4_globals,
+        },
+#endif
+#if defined(CONFIG_ARCH_OMAP3)
+        {
+                .compatible = "ti,omap3",
+                .data = &omap3_globals,
+        },
+#endif
+#if defined(CONFIG_SOC_OMAP2430)
+        {
+                .compatible = "ti,omap2430",
+                .data = &omap243x_globals,
+        },
+#endif
+#if defined(CONFIG_SOC_OMAP2420)
+        {
+                .compatible = "ti,omap2420",
+                .data = &omap242x_globals,
+        },
+#endif
+	{},
+};
+
+/* Helper to find the proper of_device_id from a FDT */
+static __init const struct of_device_id *_fdt_match_node(
+					const struct of_device_id *matches,
+					int fdt_node)
+{
+	unsigned int score = 0;
+
+	if (!matches)
+		return NULL;
+
+	while (matches->compatible[0]) {
+		score = of_flat_dt_is_compatible(fdt_node, matches->compatible);
+		if (score > 0)
+			return matches;
+		matches++;
+	}
+	return NULL;
+}
+
+void __init omap2_set_globals(void)
+{
+        unsigned long fdt_root;
+	const struct of_device_id *match;
+
+	/* the DT is still flat at map_io time... */
+        fdt_root = of_get_flat_dt_root();
+	match = _fdt_match_node(omap_soc_match, fdt_root);
+	if (!match) {
+		pr_err("%s(): Cannot initialize the platform globals data\n",
+		       __func__);
+	}
+
+	pr_info("%s(): %s\n", __func__, match->compatible);
+
+	omap2_set_globals_tap(match->data);
+	omap2_set_globals_sdrc(match->data);
+	omap2_set_globals_control(match->data);
+	omap2_set_globals_prcm(match->data);
+}
+#endif
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 4564cc6..fb79269 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -67,6 +67,7 @@ void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
 void omap2_set_globals_ti816x(void);
+void omap2_set_globals(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
-- 
1.7.0.4



