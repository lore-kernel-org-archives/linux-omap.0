From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] OMAP: RX51: use OneNAND sync read / write
Date: Fri, 12 Jun 2009 15:08:38 +0300
Message-ID: <4A324546.6020304@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43350 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZFLMHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 08:07:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

>From aea78b09cac91d51d31ef61a2554f3470b498cfd Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 12 Jun 2009 14:41:14 +0300
Subject: [PATCH] OMAP: RX51: use OneNAND sync read / write

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index da93b86..9a0bf67 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -362,6 +362,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 	.gpio_irq	= 65,
 	.parts		= onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+	.flags		= ONENAND_SYNC_READWRITE,
 };
 
 static void __init board_onenand_init(void)
-- 
1.5.6.3
