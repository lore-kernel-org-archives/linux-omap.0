From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/19] OMAP3: clock: use std _MASK suffix for CM_FCLKEN_IVA2
	defines
Date: Mon, 15 Feb 2010 18:24:43 -0700
Message-ID: <20100216012441.1101.85404.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57401 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475Ab0BPB05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:57 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Add _MASK suffix to CM_FCLKEN_IVA2 bitfieds to conform with the rest
of the usage in cm-regbits-34xx.h of using _SHIFT and _MASK suffixes.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 +-
 arch/arm/mach-omap2/pm34xx.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6923deb..a76e835 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -55,7 +55,7 @@
 /* Bits specific to each register */
 
 /* CM_FCLKEN_IVA2 */
-#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2			(1 << 0)
+#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK		(1 << 0)
 #define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT		0
 
 /* CM_CLKEN_PLL_IVA2 */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5087b15..62e27aa 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -688,7 +688,7 @@ static void __init omap3_iva_idle(void)
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Enable IVA2 clock */
-	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2,
+	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
 			 OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* Set IVA2 boot mode to 'idle' */


