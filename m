From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 2/2] ARM: OMAP2+: only WARN if a GPMC child probe function fail
Date: Wed, 17 Apr 2013 22:34:12 +0200
Message-ID: <1366230852-2440-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1366230852-2440-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:37963 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965655Ab3DQUef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 16:34:35 -0400
In-Reply-To: <1366230852-2440-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Lars Poeschel <poeschel@lemonage.de>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

If any of the GPMC child nodes fails, this shouldn't make the
whole gpmc_probe_dt() function to fail. It is better to just
WARN and allow other devices probe function to succeed.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1 (suggested by Jon Hunter):
  - Split the search for GPMC child nodes and only warn if a
    child probe fails on two different patches
  - Add a warn message to report which GPMC child probe failed

 arch/arm/mach-omap2/gpmc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6166847..6c4da12 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1533,10 +1533,9 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			 of_node_cmp(child->name, "nor") == 0)
 			ret = gpmc_probe_generic_child(pdev, child);
 
-		if (ret < 0) {
+		if (WARN(ret < 0, "%s: probing gpmc child %s failed\n",
+			 __func__, child->full_name))
 			of_node_put(child);
-			return ret;
-		}
 	}
 
 	return 0;
-- 
1.7.7.6

