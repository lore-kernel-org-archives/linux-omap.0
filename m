From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/28] omap: remove one of the define of
	INT_34XX_BENCH_MPU_EMUL
Date: Fri, 23 Apr 2010 16:11:36 -0700
Message-ID: <20100423231136.31953.65952.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56900 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab0DWXLh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:37 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

From: stanley.miao <stanley.miao@windriver.com>

INT_34XX_BENCH_MPU_EMUL was defined twice, another is at Line 312.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index b65088a..4017019 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -345,8 +345,6 @@
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95
 
-#define	INT_34XX_BENCH_MPU_EMUL	3
-
 #define INT_35XX_HECC0_IRQ		24
 #define INT_35XX_HECC1_IRQ		28
 #define INT_35XX_EMAC_C0_RXTHRESH_IRQ	67

