From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 1/3] omap3: cm-t35: update led polarity
Date: Wed, 11 Nov 2009 13:19:30 +0200
Message-ID: <8d65fd0bfcb8171c42a5e46259e28ba76e462f2b.1257937910.git.mike@compulab.co.il>
References: <cover.1257937910.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54104 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757372AbZKKL0B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 06:26:01 -0500
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N8BKw-00070p-5g
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 05:26:06 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 2A80C9A0365
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 13:19:34 +0200 (IST)
In-Reply-To: <cover.1257937910.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 0a39513..f9290ca 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -123,7 +123,7 @@ static struct gpio_led cm_t35_leds[] = {
 		.gpio			= 186,
 		.name			= "cm-t35:green",
 		.default_trigger	= "heartbeat",
-		.active_low		= 1,
+		.active_low		= 0,
 	},
 };
 
-- 
1.6.0.6

