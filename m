From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 12/19] omap3+: sr: disable interrupt by default
Date: Sat, 19 Feb 2011 17:31:51 +0530
Message-ID: <1298116918-30744-13-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40748 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752901Ab1BSMDm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:03:42 -0500
Received: by ywa6 with SMTP id 6so2825085ywa.40
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:03:41 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

We will enable and disable interrupt on a need basis in the class
driver. we need to keep the irq disabled by default else the
forceupdate or vcbypass events could trigger events that we dont
need/expect to handle.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7931fcd..9c61ab0 100644
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

