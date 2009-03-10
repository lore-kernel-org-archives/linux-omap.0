From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 4/6] OMAP: mmc-twl4030 allow arbitrary slot names
Date: Tue, 10 Mar 2009 11:33:22 +0200
Message-ID: <20090310093322.16889.39355.sendpatchset@ahunter-laptop>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51118 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbZCJJe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 05:34:27 -0400
In-Reply-To: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, David Brownell <david-b@pacbell.net>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 4c4a97595cab39443a85517c66bc26f5c2a9cae3 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 30 Jan 2009 11:10:19 +0200
Subject: [PATCH] OMAP: mmc-twl4030 allow arbitrary slot names

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    5 ++++-
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index a58deba..8fc8e84 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -419,7 +419,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			return;
 		}
 
-		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
+		if (c->name)
+			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
+		else
+			sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
 		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].wires = c->wires;
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index e87bc8d..69dbbc1 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -15,6 +15,7 @@ struct twl4030_hsmmc_info {
 	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 };
 
-- 
1.5.6.3

