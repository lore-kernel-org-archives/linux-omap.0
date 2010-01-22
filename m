From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCHv2 2/6] OMAP4: IRQ: Add McPDM IRQ definition.
Date: Fri, 22 Jan 2010 17:15:11 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43754 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328Ab0AVXPQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 18:15:16 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Support for McPDM IRQs in OMAP4

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index c0ab7c8..bbb8eb6 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -432,7 +432,7 @@
 #define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
 #define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
 #define INT_44XX_MMC4_IRQ	(96 + IRQ_GIC_START)
-
+#define INT_44XX_MCPDM_IRQ	(112 + IRQ_GIC_START)
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
-- 
1.6.0.4