From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 11/12] omap3: sr: sr_exit should be static
Date: Thu,  5 Aug 2010 17:24:11 -0500
Message-ID: <1281047052-21346-12-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57514 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760829Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

sr_exit has no business being a public function.
fixes sparse:
arch/arm/mach-omap2/smartreflex.c:959:13: warning: symbol 'sr_exit' was not declared. Should it be static?

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9b5a10e..a723ac7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -968,7 +968,7 @@ static int __init sr_init(void)
 	return 0;
 }
 
-void __exit sr_exit(void)
+static void __exit sr_exit(void)
 {
 	platform_driver_unregister(&smartreflex_driver);
 }
-- 
1.6.3.3

