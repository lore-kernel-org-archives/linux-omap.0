From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 2/4] omap3: sr: sr_exit should be static
Date: Thu, 24 Jun 2010 16:29:24 -0500
Message-ID: <1277414966-31806-3-git-send-email-nm@ti.com>
References: <1277414966-31806-1-git-send-email-nm@ti.com>
 <1277414966-31806-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab0FXV3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 17:29:31 -0400
In-Reply-To: <1277414966-31806-2-git-send-email-nm@ti.com>
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
index 57fc9b2..786e896 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -956,7 +956,7 @@ static int __init sr_init(void)
 	return 0;
 }
 
-void __exit sr_exit(void)
+static void __exit sr_exit(void)
 {
 	platform_driver_unregister(&smartreflex_driver);
 }
-- 
1.6.3.3

