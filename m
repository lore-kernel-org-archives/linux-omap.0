From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 12/12] omap3: sr: class3: make class3_data static
Date: Thu,  5 Aug 2010 17:24:12 -0500
Message-ID: <1281047052-21346-13-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760830Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

we dont expose the structure to the world, so this should be static
however, since sr core does not take a copy of the same, we cant make
it __init data.

fixes sparse warning:
arch/arm/mach-omap2/smartreflex-class3.c:50:36: warning: symbol 'class3_data' was not declared. Should it be static?

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index f3b766f..530b2f0 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -47,7 +47,7 @@ static int sr_class3_configure(int id)
 }
 
 /* SR class3 structure */
-struct omap_smartreflex_class_data class3_data = {
+static struct omap_smartreflex_class_data class3_data = {
 	.enable = sr_class3_enable,
 	.disable = sr_class3_disable,
 	.configure = sr_class3_configure,
-- 
1.6.3.3

