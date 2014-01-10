From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/2] ARM: DRA7XX/AM43XX: randconfig fixes
Date: Fri, 10 Jan 2014 11:57:29 +0200
Message-ID: <1389347850-22435-2-git-send-email-t-kristo@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55757 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbaAJJ6I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jan 2014 04:58:08 -0500
In-Reply-To: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

DRA7XX and AM43XX were missing common clock code from the Makefile, which
causes build breakage in DRA7XX / AM43XX only builds once clock support
for these SoCs is added. Add the missing entries to the Makefile as
preparation of this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 088305f..96a990f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -191,6 +191,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common) dpll3xxx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
-- 
1.7.9.5

