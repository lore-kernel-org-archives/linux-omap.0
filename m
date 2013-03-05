From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: [PATCH v2] ARM: OMAP: Clear GPMC bits when applying new setting.
Date: Tue, 05 Mar 2013 10:13:40 +0000
Message-ID: <5135C554.5090502@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:35265 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750906Ab3CEKNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 05:13:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>

When setting the GPMC device type, make sure any previous
bits are cleared down, before applying the new setting.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
Changes in v2:
- Change mux type to 2 bits
- Add extra mux types in gpmc.h

 arch/arm/mach-omap2/gpmc.c |    4 ++++
 arch/arm/mach-omap2/gpmc.h |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 410e1ba..479369c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -613,6 +613,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 
 	case GPMC_CONFIG_DEV_TYPE:
 		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+		/* clear 4 target bits */
+		regval &= ~(GPMC_CONFIG1_DEVICETYPE(3) |
+			    GPMC_CONFIG1_MUXTYPE(3));
+		/* set the proper value */
 		regval |= GPMC_CONFIG1_DEVICETYPE(wval);
 		if (wval == GPMC_DEVICETYPE_NOR)
 			regval |= GPMC_CONFIG1_MUXADDDATA;
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index fe0a844..f79cbde 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -58,7 +58,10 @@
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
+#define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
+#define GPMC_CONFIG1_MUXNONMUX          GPMC_CONFIG1_MUXTYPE(0)
+#define GPMC_CONFIG1_MUXAAD             GPMC_CONFIG1_MUXTYPE(1)
+#define GPMC_CONFIG1_MUXADDDATA         GPMC_CONFIG1_MUXTYPE(2)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
 #define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
-- 
1.7.9.5

