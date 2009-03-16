From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 10/12] ARM: OMAP3: mmc-twl4030 allow arbitrary slot	names
Date: Mon, 16 Mar 2009 12:05:07 +0200
Message-ID: <49BE2453.9020801@nokia.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211352.16425.44160.stgit@localhost> <20090315160838.GF10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61427 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbZCPKFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 06:05:00 -0400
In-Reply-To: <20090315160838.GF10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 9b04f19a7e88f8877176c25845c38676ee3127c1 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 10 Mar 2009 22:13:52 +0100
Subject: [PATCH] ARM: OMAP3: mmc-twl4030 allow arbitrary slot names

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    6 +++++-
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index a612a02..88b4bed 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -328,7 +328,11 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			return;
 		}
 
-		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
+		if (c->name)
+			strlcpy(twl->name, c->name, ARRAY_SIZE(twl->name));
+		else
+			snprintf(twl->name, ARRAY_SIZE(twl->name),
+				 "mmc%islot%i", c->mmc, 1);
 		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].wires = c->wires;
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 36e95a6..aa2d99b 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -14,6 +14,7 @@ struct twl4030_hsmmc_info {
 	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	const char *name;	/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 	int	ocr_mask;	/* temporary HACK */
 };
-- 
1.5.6.3
