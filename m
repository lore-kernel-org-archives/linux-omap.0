From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 11/19] omap3+: sr: call handler with interrupt disabled
Date: Sat, 19 Feb 2011 17:31:50 +0530
Message-ID: <1298116918-30744-12-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56262 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab1BSMJz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:09:55 -0500
Received: by yih10 with SMTP id 10so558621yih.11
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:09:54 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Request the handler irq such that there is no nesting for calls.
the notifiers are not expected to be nested, further the interrupt
events for status change should be handled prior to the next event
else there is a risk of loosing events.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 1fe8b95..7931fcd 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 			goto error;
 		}
 		ret = request_irq(sr_info->irq, sr_interrupt,
-				0, name, (void *)sr_info);
+				IRQF_DISABLED, name, (void *)sr_info);
 		if (ret)
 			goto error;
 	}
-- 
1.7.1

