From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 2/9] omap: remove one of the define of INT_34XX_BENCH_MPU_EMUL
Date: Mon, 19 Apr 2010 18:20:40 +0800
Message-ID: <1271672447-3639-3-git-send-email-stanley.miao@windriver.com>
References: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51716 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0DSKL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 06:11:58 -0400
In-Reply-To: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, hvaibhav@ti.com, srk@ti.com

INT_34XX_BENCH_MPU_EMUL was defined twice, another is at Line 312.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
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
-- 
1.5.4.3

