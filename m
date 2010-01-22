From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCHv2 3/6] ARM: OMAP4: Add McPDM base address
Date: Fri, 22 Jan 2010 17:15:21 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B2@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39621 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab0AVXP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 18:15:27 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Define McPDM physical and L3 base address for OMAP4

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 8e4c581..4c64f20 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -43,6 +43,8 @@
 #define OMAP44XX_SCU_BASE		0x48240000
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
+#define OMAP44XX_MCPDM_BASE		0x40132000
+#define OMAP44XX_MCPDM_L3_BASE		0x49032000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 
-- 
1.6.0.4