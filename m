From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] omap: Fix board-nokia770.c and board-n8x0 cbus build breakage
Date: Mon, 18 Apr 2011 22:21:32 +0300
Message-ID: <1303154492-13520-3-git-send-email-jhnikula@gmail.com>
References: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61034 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab1DRTVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 15:21:51 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1481820ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 12:21:51 -0700 (PDT)
In-Reply-To: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Fix a build breakage in CBUS initialization code in Nokia 770 and N8x0
boards that appeared after commit 0c6f8a8 "genirq: Remove compat code".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Build breakage that is only in linux-omap-2.6/cbus branch.
---
 arch/arm/mach-omap1/board-nokia770.c |    2 +-
 arch/arm/mach-omap2/board-n8x0.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index e2537b8..5d174a3 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -177,7 +177,7 @@ static void __init nokia770_cbus_init(void)
 		return;
 	}
 
-	set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_RISING);
 	retu_resource[0].start = gpio_to_irq(62);
 	platform_device_register(&retu_device);
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index bd7937a..9ae6dff 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -274,7 +274,7 @@ static void __init n8x0_cbus_init(void)
 		return;
 	}
 
-	set_irq_type(gpio_to_irq(108), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(gpio_to_irq(108), IRQ_TYPE_EDGE_RISING);
 	retu_resource[0].start = gpio_to_irq(108);
 	platform_device_register(&retu_device);
 
-- 
1.7.0.4

