From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/4] OMAP: hwmod: Disable clocks when hwmod enable fails
Date: Mon, 22 Nov 2010 09:51:00 +0100
Message-ID: <1290415860-15632-5-git-send-email-b-cousson@ti.com>
References: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40137 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab0KVIvU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 03:51:20 -0500
In-Reply-To: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Rajendra Nayak <rnayak@ti.com>

In cases where a module (hwmod) does not become accesible on enabling
the main clocks (can happen if there are external clocks needed
for the module to become accesible), make sure the clocks are not
left enabled.
This ensures that when the requisite external dependencies are met
a omap_hwmod_enable and omap_hwmod_idle/shutdown would rightly enable
and disable clocks using clk framework. Leaving the clocks enabled in
the error case causes additional usecounting at the clock framework
level leaving the clock enabled forever.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f221587..896012d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1210,6 +1210,7 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
 			_enable_sysc(oh);
 		}
 	} else {
+		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
 	}
-- 
1.7.0.4

