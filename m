From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 02/11] OMAP4: OPP framework support
Date: Sat, 25 Sep 2010 18:21:17 +0530
Message-ID: <1285419086-13047-3-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53965 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0IYMvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 08:51:38 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch allows the compilation of the generic
opp layer for OMAP4 also.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 852fa33..cbf8f2e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 # OPP support in (OMAP3+ only at the moment)
 ifdef CONFIG_PM
 obj-$(CONFIG_ARCH_OMAP3) += opp.o
+obj-$(CONFIG_ARCH_OMAP4) += opp.o
 obj-$(CONFIG_TWL4030_CORE) += opp_twl_tps.o
 endif
 
-- 
1.7.0.4

