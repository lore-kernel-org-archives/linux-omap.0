From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/14] omap3: drop all IVA-related address base definitions
Date: Thu, 12 Nov 2009 16:09:56 -0800
Message-ID: <20091113000955.9034.72230.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53345 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbZKMAJv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:09:51 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

All of the OMAP3 IVA physical address macros in
plat-omap/include/plat/omap34xx.h are wrong[1]:

OMAP34XX_IVA_INTC_BASE: The IVA interrupt controller does not appear
to be accessible from the L3 interconnect, and in any case is
definitely not at 0x40000000; the latter address appears to be the
internal IVA physical address base for the OMAP2420's interrupt control[2].

OMAP34XX_DSP_BASE: The section of L3 physical address space mapped to
the IVA starts at 0x5c000000, not 0x58000000.

OMAP34XX_DSP_MEM_BASE: It's not clear what this refers to, but it's not
in the L3 IVA address space.

OMAP34XX_DSP_IPI_BASE: The Intrusive Port Interface is a relic from
the OMAP2420 days and no longer applies to OMAP3.

OMAP34XX_DSP_MMU_BASE: The DSP MMU is mapped at 0x5d000000, not 0x5a000000.


Nothing that uses these can possibly be working, so drop them.  When
future code needs these, correct versions can be added in.

1. OMAP34xx Multimedia Device Silicon Revision 3.1.x Rev. W, Table 2-8:
   "L3 Interconnect View of the IVA2.2 Subsystem Memory Space."  p. 229.

2. OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 (Rev. Q),
   section 2.2.4.1, "IVA Memory Space Seen by L3", p. 132.

3. ibid., section 4.3.11, "DSP IPI Overview", p. 200.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/omap34xx.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 4655707..077f059 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -72,7 +72,6 @@
 #define OMAP3430_ISP_CSI2A_END		(OMAP3430_ISP_CSI2A_BASE   + 0x16F)
 #define OMAP3430_ISP_CSI2PHY_END	(OMAP3430_ISP_CSI2PHY_BASE + 0x007)
 
-#define OMAP34XX_IVA_INTC_BASE	0x40000000
 #define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
 #define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
 #define OMAP34XX_UHH_CONFIG_BASE	(L4_34XX_BASE + 0x64000)
@@ -83,9 +82,5 @@
 
 #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
-#define OMAP34XX_DSP_BASE	0x58000000
-#define OMAP34XX_DSP_MEM_BASE	(OMAP34XX_DSP_BASE + 0x0)
-#define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)
-#define OMAP34XX_DSP_MMU_BASE	(OMAP34XX_DSP_BASE + 0x2000000)
 #endif /* __ASM_ARCH_OMAP34XX_H */
 

