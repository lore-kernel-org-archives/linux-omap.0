From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] ARM: OMAP3: mmc-twl4030 allow arbitrary slot names
Date: Tue, 10 Mar 2009 14:13:52 -0700
Message-ID: <20090310211352.16425.44160.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59790 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZCJVNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:13:53 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    5 ++++-
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 9f53d22..9831b2b 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -402,7 +402,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
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
index 0aa1686..ea59e86 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -14,6 +14,7 @@ struct twl4030_hsmmc_info {
 	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 };
 

