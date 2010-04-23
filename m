From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/28] OMAP4: Fix for CONTROL register Base
Date: Fri, 23 Apr 2010 16:11:26 -0700
Message-ID: <20100423231126.31953.77937.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56799 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab0DWXL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:27 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the base address of CONTROL register on OMAP4430SDP.
The control base is used by peripherals like MMC1 for PBIAS configuration.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 2302474..b3ef1a7 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -32,7 +32,7 @@
 #define OMAP4430_PRM_BASE		0x4a306000
 #define OMAP44XX_GPMC_BASE		0x50000000
 #define OMAP443X_SCM_BASE		0x4a002000
-#define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
+#define OMAP443X_CTRL_BASE		0x4a100000
 #define OMAP44XX_IC_BASE		0x48200000
 #define OMAP44XX_IVA_INTC_BASE		0x40000000
 #define IRQ_SIR_IRQ			0x0040

