From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/7] OMAP: hwmod: Add warnings if enable failed
Date: Mon, 27 Jun 2011 18:33:05 +0200
Message-ID: <1309192391-12410-2-git-send-email-b-cousson@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab1F0Qdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 12:33:53 -0400
In-Reply-To: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Change the debug into warning to check what IPs are failing.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3538805..51a13f3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1023,6 +1023,8 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
+	else
+		pr_warning("omap_hwmod: %s: cannot _init_clocks\n", oh->name);
 
 	return ret;
 }
-- 
1.7.0.4

