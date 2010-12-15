From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/6] OMAP2+: hwmod: Disable clocks when hwmod enable fails
Date: Wed, 15 Dec 2010 15:49:25 +0100
Message-ID: <1292424567-25794-5-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37011 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045Ab0LOOv5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 09:51:57 -0500
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

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
index 91b011e..c576121 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1233,6 +1233,7 @@ static int _enable(struct omap_hwmod *oh)
 			_enable_sysc(oh);
 		}
 	} else {
+		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
 	}
-- 
1.7.0.4

