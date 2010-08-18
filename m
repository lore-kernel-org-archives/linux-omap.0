From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 02/10] OMAP4: OPP framework support
Date: Wed, 18 Aug 2010 16:46:23 +0530
Message-ID: <1282130191-9062-3-git-send-email-thara@ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab0HRLQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 07:16:43 -0400
In-Reply-To: <1282130191-9062-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

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
1.7.1.GIT

