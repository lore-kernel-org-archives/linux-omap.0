From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: omap: Fix broken reg_shift initialization
Date: Wed, 30 May 2012 00:13:01 -0700
Message-ID: <20120530071300.GH12766@atomide.com>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
 <20120529074047.GE16340@arwen.pp.htv.fi>
 <20120529124732.GD12766@atomide.com>
 <20120529125024.GM9577@arwen.pp.htv.fi>
 <20120529130312.GE12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37409 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab2E3HNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 03:13:07 -0400
Content-Disposition: inline
In-Reply-To: <20120529130312.GE12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Commit fa550189 (mmc: core: Prevent eMMC VCC supply to be cut from late init)
slightly affected timings for how things are done for the omap MMC driver
causing the MMC cards not getting detected any longer.

Turns out this was caused by buggy reg_shift initialization in the omap
MMC driver that was happening after mmc_add_host() was being called.

Fix this by initializing reg_shift before mmc_add_host() is called.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Heh found it! Chris, maybe Cc stable on this one?

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1485,6 +1485,7 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	}
 
 	host->nr_slots = pdata->nr_slots;
+	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
 
 	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
 	if (!host->mmc_omap_wq)
@@ -1500,8 +1501,6 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
-
 	return 0;
 
 err_destroy_wq:
