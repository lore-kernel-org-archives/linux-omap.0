From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] OMAP: mmc_twl4030 nicely disable vmmc_aux
Date: Tue, 24 Mar 2009 14:15:54 +0200
Message-ID: <49C8CEFA.6020407@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58681 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758466AbZCXMP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 08:15:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

>From 1a3f939d95122d8e58a3750cf5bce09247357203 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>

The MMC driver turns the power off before it turns it
on. To avoid regulator warnings, vmmc_aux must only be
disabled if it has previously been enabled.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 2ff50f0..cb56fe2 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -305,7 +305,7 @@ static int twl_mmc23_set_power(struct device *dev, int slot, int power_on, int v
 				ret = mmc_regulator_set_ocr(c->vcc, 0);
 		}
 	} else {
-		if (c->vcc_aux)
+		if (c->vcc_aux && (ret = regulator_is_enabled(c->vcc_aux)) > 0)
 			ret = regulator_disable(c->vcc_aux);
 		if (ret == 0)
 			ret = mmc_regulator_set_ocr(c->vcc, 0);
-- 
1.5.6.3
