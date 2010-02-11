From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/17] omap2/3/4: gpmc: avoid section definitions on headers
Date: Wed, 10 Feb 2010 19:36:09 -0800
Message-ID: <20100211033609.1624.84009.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49905 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0BKDf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:35:29 -0500
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index e081338..3f3609a 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -110,6 +110,6 @@ extern void gpmc_prefetch_reset(void);
 extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
-extern void __init gpmc_init(void);
+extern void gpmc_init(void);
 
 #endif

