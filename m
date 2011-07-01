From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 7/8] OMAP: hwmod: Add warnings if enable failed
Date: Fri, 1 Jul 2011 22:54:06 +0200
Message-ID: <1309553647-14624-8-git-send-email-b-cousson@ti.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58585 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756927Ab1GAUy1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:54:27 -0400
In-Reply-To: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Change the debug into warning to check what IPs are failing.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index df91bb1..64e9830 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -944,6 +944,8 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
+	else
+		pr_warning("omap_hwmod: %s: cannot _init_clocks\n", oh->name);
 
 	return ret;
 }
-- 
1.7.0.4

