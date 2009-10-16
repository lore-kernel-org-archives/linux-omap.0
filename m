From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/14] omap: Use ioremap in omap_hwmod.c
Date: Fri, 16 Oct 2009 16:41:15 -0700
Message-ID: <20091016234115.2463.57450.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50519 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZJPXlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:41:12 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Use ioremap in omap_hwmod.c

Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

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
 

