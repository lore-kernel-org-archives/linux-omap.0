From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 04/12] omap: mcbsp: Merge OMAP1 and OMAP2+ McBSP register definitions
Date: Fri,  1 Jul 2011 11:52:28 +0300
Message-ID: <1309510356-27147-5-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab1GAIxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:01 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:01 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

There is no need to have separate register definitions for OMAP1 since they
are ordered similarly than in OMAP2+ and thus register address offsets can
be calculated from OMAP2+ register address offsets.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   50 ++++---------------------------
 arch/arm/plat-omap/mcbsp.c              |    2 +
 2 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 9882c65..6db02b3 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -51,54 +51,16 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP1610_MCBSP2_BASE	0xfffb1000
 #define OMAP1610_MCBSP3_BASE	0xe1017000
 
-#ifdef CONFIG_ARCH_OMAP1
-
-#define OMAP_MCBSP_REG_DRR2	0x00
-#define OMAP_MCBSP_REG_DRR1	0x02
-#define OMAP_MCBSP_REG_DXR2	0x04
-#define OMAP_MCBSP_REG_DXR1	0x06
-#define OMAP_MCBSP_REG_DRR	0x02
-#define OMAP_MCBSP_REG_DXR	0x06
-#define OMAP_MCBSP_REG_SPCR2	0x08
-#define OMAP_MCBSP_REG_SPCR1	0x0a
-#define OMAP_MCBSP_REG_RCR2	0x0c
-#define OMAP_MCBSP_REG_RCR1	0x0e
-#define OMAP_MCBSP_REG_XCR2	0x10
-#define OMAP_MCBSP_REG_XCR1	0x12
-#define OMAP_MCBSP_REG_SRGR2	0x14
-#define OMAP_MCBSP_REG_SRGR1	0x16
-#define OMAP_MCBSP_REG_MCR2	0x18
-#define OMAP_MCBSP_REG_MCR1	0x1a
-#define OMAP_MCBSP_REG_RCERA	0x1c
-#define OMAP_MCBSP_REG_RCERB	0x1e
-#define OMAP_MCBSP_REG_XCERA	0x20
-#define OMAP_MCBSP_REG_XCERB	0x22
-#define OMAP_MCBSP_REG_PCR0	0x24
-#define OMAP_MCBSP_REG_RCERC	0x26
-#define OMAP_MCBSP_REG_RCERD	0x28
-#define OMAP_MCBSP_REG_XCERC	0x2A
-#define OMAP_MCBSP_REG_XCERD	0x2C
-#define OMAP_MCBSP_REG_RCERE	0x2E
-#define OMAP_MCBSP_REG_RCERF	0x30
-#define OMAP_MCBSP_REG_XCERE	0x32
-#define OMAP_MCBSP_REG_XCERF	0x34
-#define OMAP_MCBSP_REG_RCERG	0x36
-#define OMAP_MCBSP_REG_RCERH	0x38
-#define OMAP_MCBSP_REG_XCERG	0x3A
-#define OMAP_MCBSP_REG_XCERH	0x3C
-
-/* Dummy defines, these are not available on omap1 */
-#define OMAP_MCBSP_REG_XCCR	0x00
-#define OMAP_MCBSP_REG_RCCR	0x00
-
-#else
-
+/* McBSP register addresses. OMAP1 address = address definition / 2 */
+/* OMAP1-OMAP2420 registers */
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
 #define OMAP_MCBSP_REG_DXR2	0x08
 #define OMAP_MCBSP_REG_DXR1	0x0C
+/* OMAP2430 and onwards */
 #define OMAP_MCBSP_REG_DRR	0x00
 #define OMAP_MCBSP_REG_DXR	0x08
+/* Common registers */
 #define OMAP_MCBSP_REG_SPCR2	0x10
 #define OMAP_MCBSP_REG_SPCR1	0x14
 #define OMAP_MCBSP_REG_RCR2	0x18
@@ -126,6 +88,7 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_MCBSP_REG_RCERH	0x70
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
+/* OMAP2430 and onwards */
 #define OMAP_MCBSP_REG_SYSCON	0x8C
 #define OMAP_MCBSP_REG_THRSH2	0x90
 #define OMAP_MCBSP_REG_THRSH1	0x94
@@ -138,6 +101,7 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_MCBSP_REG_RBUFFSTAT	0xB8
 #define OMAP_MCBSP_REG_SSELCR	0xBC
 
+/* OMAP3 sidetone control registers */
 #define OMAP_ST_REG_REV		0x00
 #define OMAP_ST_REG_SYSCONFIG	0x10
 #define OMAP_ST_REG_IRQSTATUS	0x18
@@ -146,8 +110,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_ST_REG_SFIRCR	0x28
 #define OMAP_ST_REG_SSELCR	0x2C
 
-#endif
-
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
 #define RRDY			0x0002
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6c62af1..a7ced1b 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -37,6 +37,7 @@ int omap_mcbsp_count, omap_mcbsp_cache_size;
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	if (cpu_class_is_omap1()) {
+		reg /= 2;
 		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
 		__raw_writew((u16)val, mcbsp->io_base + reg);
 	} else if (cpu_is_omap2420()) {
@@ -51,6 +52,7 @@ static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 {
 	if (cpu_class_is_omap1()) {
+		reg /= 2;
 		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
 				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
 	} else if (cpu_is_omap2420()) {
-- 
1.7.0.4

