From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/3] clk: ti: OMAP build fixes
Date: Fri, 17 Jan 2014 22:25:40 +0200
Message-ID: <1389990340-23358-4-git-send-email-t-kristo@ti.com>
References: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbaAQU0X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 15:26:23 -0500
In-Reply-To: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Improper merge of TI clock driver resulted in build breakage for OMAP1 build,
and various other TI single SoC builds. This patch fixes those by adding the
missed Makefile tweaks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/Makefile    |    2 +-
 drivers/clk/ti/Makefile |   17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1f3143f..13c1e91 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
 obj-$(CONFIG_COMMON_CLK_XGENE)  += clk-xgene.o
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
-obj-$(CONFIG_ARCH_OMAP)		+= ti/
+obj-$(CONFIG_ARCH_OMAP2PLUS)	+= ti/
 
 obj-$(CONFIG_X86)		+= x86/
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 007c3c2..4319d40 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,10 +1,11 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   fixed-factor.o gate.o clockdomain.o \
-					   composite.o mux.o apll.o clk-43xx.o
-obj-$(CONFIG_SOC_AM33XX)		+= clk-33xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= interface.o clk-3xxx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= clk-44xx.o
-obj-$(CONFIG_SOC_OMAP5)			+= clk-54xx.o
-obj-$(CONFIG_SOC_DRA7XX)		+= clk-7xx.o
+obj-y					+= clk.o autoidle.o clockdomain.o
+clk-common				= dpll.o composite.o divider.o gate.o \
+					  fixed-factor.o mux.o apll.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o clk-3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
 endif
-- 
1.7.9.5

