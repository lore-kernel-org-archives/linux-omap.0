From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Fri, 18 Mar 2011 17:18:46 -0700
Message-ID: <1300493932-17362-2-git-send-email-khilman@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39140 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757680Ab1CSASh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Mar 2011 20:18:37 -0400
Received: by mail-iy0-f178.google.com with SMTP id 12so4209797iyi.9
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 17:18:36 -0700 (PDT)
In-Reply-To: <1300493932-17362-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

The voltage domain pointer currently in struct omap_hwmod is not used
and does not belong here.  Instead, voltage domains will be associated
with powerdomains in forthcoming patches.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..a5fa7c1 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -520,7 +520,6 @@ struct omap_hwmod {
 	struct clk			*_clk;
 	struct omap_hwmod_opt_clk	*opt_clks;
 	char				*vdd_name;
-	struct voltagedomain		*voltdm;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	void				*dev_attr;
-- 
1.7.4

