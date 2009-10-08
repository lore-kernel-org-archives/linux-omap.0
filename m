From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Use ioremap for omap_hwmod instead of
	OMAP2_IO_ADDRESS
Date: Wed, 7 Oct 2009 17:26:59 -0700
Message-ID: <20091008002659.GG29320@atomide.com>
References: <20091008002506.GF29320@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63938 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbZJHA1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 20:27:44 -0400
Content-Disposition: inline
In-Reply-To: <20091008002506.GF29320@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

>From f05ba4e3427bc0dc216f2fca32a9b1e8f0e38695 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 7 Oct 2009 17:10:18 -0700
Subject: [PATCH] omap: Use ioremap for omap_hwmod instead of OMAP2_IO_ADDRESS

Otherwise we cannot get rid of OMAP2_IO_ADDRESS.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d2e0f1c..8ac8798 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -496,6 +496,7 @@ static void __iomem *_find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
 	struct omap_hwmod_addr_space *mem;
 	int i;
 	int found = 0;
+	void __iomem *va_start;
 
 	if (!oh || oh->slaves_cnt == 0)
 		return NULL;
@@ -509,16 +510,20 @@ static void __iomem *_find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
 		}
 	}
 
-	/* XXX use ioremap() instead? */
-
-	if (found)
+	if (found) {
+		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+		if (!va_start) {
+			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
+			return NULL;
+		}
 		pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
-			 oh->name, OMAP2_IO_ADDRESS(mem->pa_start));
-	else
+			 oh->name, va_start);
+	} else {
 		pr_debug("omap_hwmod: %s: no MPU register target found\n",
 			 oh->name);
+	}
 
-	return (found) ? OMAP2_IO_ADDRESS(mem->pa_start) : NULL;
+	return (found) ? va_start : NULL;
 }
 
 /**
@@ -1148,6 +1153,7 @@ int omap_hwmod_unregister(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: unregistering\n", oh->name);
 
 	mutex_lock(&omap_hwmod_mutex);
+	iounmap(oh->_rt_va);
 	list_del(&oh->node);
 	mutex_unlock(&omap_hwmod_mutex);
 
