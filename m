From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/8] OMAP: hwmod: warn on missing clockdomain
Date: Tue, 17 Nov 2009 17:05:07 -0800
Message-ID: <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61295 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbZKRBFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:17 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so614173yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:23 -0800 (PST)
In-Reply-To: <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

WARN if a clock/hwmod is missing a clockdomain association since
resulting hwmod will not be able to correctly enable/disable clocks.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 633b216..7d7b3b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -326,6 +326,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		ret = -EINVAL;
 	oh->_clk = c;
 
+	WARN(!c->clkdm, "omap_hwmod: %s: missing clockdomain for %s.\n",
+	     oh->clkdev_con_id, c->name);
+
 	return ret;
 }
 
-- 
1.6.5.1

