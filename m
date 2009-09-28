From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/12] omap: Fix wrong condition check in while loop
	for mailbox and iommu2
Date: Mon, 28 Sep 2009 09:39:08 -0700
Message-ID: <20090928163908.GD18957@atomide.com>
References: <20090924233027.6065.95725.stgit@localhost> <20090928162657.GC18957@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54649 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZI1QjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 12:39:08 -0400
Content-Disposition: inline
In-Reply-To: <20090928162657.GC18957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090928 09:28]:
> Here's one more fix for this series.

Correction, there were two patches, one for mailbox and one
for iommu2 with the same fix. Here are both of them merged
into a single patch.

Tony

--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=out

>From 055c49d285a151ccb91d63bac6d8621be3db5c93 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Mon, 28 Sep 2009 09:21:26 -0700
Subject: [PATCH] omap: Fix wrong condition check in while loop for mailbox and iommu2

It's worked fine so far since reset is done for the first time.

Reported-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 2d9b5cc..4a0e1cd 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -79,7 +79,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 		l = iommu_read_reg(obj, MMU_SYSSTATUS);
 		if (l & MMU_SYS_RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & MMU_SYS_RESETDONE)) {
 		dev_err(obj->dev, "can't take mmu out of reset\n");
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f3fefca..c035ad3 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -93,7 +93,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 		l = mbox_read_reg(MAILBOX_SYSSTATUS);
 		if (l & RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & RESETDONE)) {
 		pr_err("Can't take mmu out of reset\n");

--Pd0ReVV5GZGQvF3a--
