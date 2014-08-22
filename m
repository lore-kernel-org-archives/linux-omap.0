From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] ARM: AM437x: use pdata quirks for pinctrl information
Date: Fri, 22 Aug 2014 08:55:25 -0500
Message-ID: <1408715725-25919-4-git-send-email-nm@ti.com>
References: <1408715725-25919-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122AbaHVN5O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2014 09:57:14 -0400
In-Reply-To: <1408715725-25919-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Keerthy <j-keerthy@ti.com>

Provide pdata-quirks for Am437x processor family.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 827e106..5fea34e 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -359,6 +359,9 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_SOC_DRA7XX
 	OF_DEV_AUXDATA("ti,dra7-padconf", 0x4a003400, "4a003400.pinmux", &pcs_pdata),
 #endif
+#ifdef CONFIG_SOC_AM43XX
+	OF_DEV_AUXDATA("ti,am437-padconf", 0x44e10800, "44e10800.pinmux", &pcs_pdata),
+#endif
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
 		       &omap4_iommu_pdata),
-- 
1.7.9.5

