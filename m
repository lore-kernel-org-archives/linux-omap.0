From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 11/18] omap3+: sr: disable interrupt by default
Date: Wed,  2 Mar 2011 16:25:24 +0530
Message-ID: <1299063331-27968-12-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49030 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757162Ab1CBK5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:57:18 -0500
Received: by gyb13 with SMTP id 13so2534717gyb.28
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:57:16 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

We will enable and disable interrupt on a need basis in the class
driver. we need to keep the irq disabled by default else the
forceupdate or vcbypass events could trigger events that we dont
need/expect to handle.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a4e9f2d..8cad92d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -281,6 +281,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 				IRQF_DISABLED, name, (void *)sr_info);
 		if (ret)
 			goto error;
+		disable_irq(sr_info->irq);
 	}
 
 	if (pdata && pdata->enable_on_init)
-- 
1.7.1

