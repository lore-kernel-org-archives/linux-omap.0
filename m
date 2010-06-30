From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/16] omap: mux: Remove unncessary parens from mux34xx.c
Date: Wed, 30 Jun 2010 15:06:42 +0300
Message-ID: <20100630120642.2637.81925.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57220 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab0F3MGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:31 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Remove unncessary parens from mux34xx.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux34xx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 2ff4dce..f64d7ee 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -2032,19 +2032,19 @@ int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 	struct omap_ball *package_balls;
 
 	switch (flags & OMAP_PACKAGE_MASK) {
-	case (OMAP_PACKAGE_CBC):
+	case OMAP_PACKAGE_CBC:
 		package_subset = omap3_cbc_subset;
 		package_balls = omap3_cbc_ball;
 		break;
-	case (OMAP_PACKAGE_CBB):
+	case OMAP_PACKAGE_CBB:
 		package_subset = omap3_cbb_subset;
 		package_balls = omap3_cbb_ball;
 		break;
-	case (OMAP_PACKAGE_CUS):
+	case OMAP_PACKAGE_CUS:
 		package_subset = omap3_cus_subset;
 		package_balls = omap3_cus_ball;
 		break;
-	case (OMAP_PACKAGE_CBP):
+	case OMAP_PACKAGE_CBP:
 		package_subset = omap36xx_cbp_subset;
 		package_balls = omap36xx_cbp_ball;
 		break;

