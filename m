From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] OMAP2+: hwmod: Fix what _init_clock returns
Date: Wed, 16 Feb 2011 17:41:24 +0530
Message-ID: <1297858285-7056-3-git-send-email-rnayak@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
 <1297858285-7056-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759023Ab1BPMLg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:11:36 -0500
In-Reply-To: <1297858285-7056-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

_init_clock always returns 0 and does
not propogate the error (in case of failure)
back to the caller, causing _init_clocks to
fail silently.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cd9dcde..960461f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -926,7 +926,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
1.7.0.4

