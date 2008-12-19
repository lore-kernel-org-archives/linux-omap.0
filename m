From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ARM: OMAP3: Enable writing to XCCR and RCCR McBSP registers
 for OMAP 2430/34xx
Date: Thu, 18 Dec 2008 20:53:12 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58167 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbYLSCxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 21:53:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

This patch enables writing to McBSP Transmit Configuration Control
Register (XCCR) and Receive Configuration Control Register (RCCR)
for 2430/34xx platforms. It also adds XCCR, RCCR entries in McBSP
register configuration structure and bit definitions for both
registers.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    7 +++++++
 arch/arm/plat-omap/mcbsp.c              |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 6a0d1a0..cc48f2f 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -231,11 +231,16 @@
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
 
 /*********************** McBSP XCCR bit definitions *************************/
+#define EXTCLKGATE		0x8000
+#define PPCONNECT		0x4000
+#define DXENDLY(value)		((value)<<12)	/* Bits 12:13 */
+#define XFULL_CYCLE		0x0800
 #define DILB			0x0020
 #define XDMAEN			0x0008
 #define XDISABLE		0x0001
 
 /********************** McBSP RCCR bit definitions *************************/
+#define RFULL_CYCLE		0x0800
 #define RDMAEN			0x0008
 #define RDISABLE		0x0001
 
@@ -267,6 +272,8 @@ struct omap_mcbsp_reg_cfg {
 	u16 rcerh;
 	u16 xcerg;
 	u16 xcerh;
+	u16 xccr;
+	u16 rccr;
 };
 
 typedef enum {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index af33fc7..f2401a8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -173,6 +173,10 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
 	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
 	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
+		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
+	}
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
-- 
1.5.4.3
