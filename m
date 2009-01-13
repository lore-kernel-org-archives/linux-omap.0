From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 1/3] ARM: OMAP: Fix ASoC by enabling writes to XCCR and RCCR
Date: Tue, 13 Jan 2009 09:52:13 +0200
Message-ID: <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56598 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbZAMHyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 02:54:43 -0500
In-Reply-To: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Misael Lopez Cruz <x0052729@ti.com>, Tony Lindgren <tony@atomide.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Tony Lindgren <tony () atomide ! com>

[Download message RAW]

From: Tony Lindgren <Lopez>

This patch enables writing to McBSP Transmit Configuration Control
Register (XCCR) and Receive Configuration Control Register (RCCR)
for 2430/34xx platforms. It also adds XCCR, RCCR entries in McBSP
register configuration structure and bit definitions for both
registers.

If we enable the writing to CCR registers for 2430/34xx and don't
set the default values (setting 0 as a consequence) in ASoC driver,
the Transmit/Receive DMA mode gets disabled and the the
transmission/reception doesn't happen, ending with a
"write error: Input/Output error" when playing with 'aplay'.

Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
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
1.5.2

