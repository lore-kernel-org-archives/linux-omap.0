From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 08/10] OMAP: hwmod: Do not exit the iteration if one clock init failed
Date: Fri,  7 May 2010 17:44:13 +0200
Message-ID: <1273247055-15165-9-git-send-email-b-cousson@ti.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58167 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276Ab0EGPoa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 11:44:30 -0400
In-Reply-To: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

During the _init_clocks phase, the iteration is stopped but the
status is still change from _HWMOD_STATE_REGISTERED to
_HWMOD_STATE_CLKS_INITED.
Since the _setup phase will be done nevertheless, it might be
better to keep initializing the others clocks nodes and just
keep the warning.
It is much easier to debug when a important number of clocks
name are wrong during the early debug phase of a new platform.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5d3a3ea..b624ad6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -783,9 +783,10 @@ static int _init_clocks(struct omap_hwmod *oh)
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
-	oh->_state = _HWMOD_STATE_CLKS_INITED;
+	if (!ret)
+		oh->_state = _HWMOD_STATE_CLKS_INITED;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
1.6.1.3

