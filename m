From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/10] OMAP: hwmod: warn on missing clockdomain
Date: Thu, 03 Dec 2009 06:49:55 -0700
Message-ID: <20091203134954.17146.50776.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49064 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbZLCNyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:54:38 -0500
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

WARN if a clock/hwmod is missing a clockdomain association since
resulting hwmod will not be able to correctly enable/disable clocks.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cb5bf34..adc86e0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -352,6 +352,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		ret = -EINVAL;
 	oh->_clk = c;
 
+	WARN(!c->clkdm, "omap_hwmod: %s: missing clockdomain for %s.\n",
+	     oh->clkdev_con_id, c->name);
+
 	return ret;
 }
 


