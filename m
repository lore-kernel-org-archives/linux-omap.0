From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/6] ARM: OMAP4+: PRM: remove "wkup" event
Date: Fri, 22 Aug 2014 08:51:51 -0500
Message-ID: <1408715513-25851-5-git-send-email-nm@ti.com>
References: <1408715513-25851-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408715513-25851-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

"wkup" event at bit offset 0 exists only on OMAP3.
OMAP4430/60 PRM_IRQSTATUS_A9, OMAP5/DRA7 PRM_IRQSTATUS_MPU

register bit 0 is DPLL_CORE_RECAL_ST not wakeup event like OMAP3.

The same applies to AM437x as well.

Remove the wrong definition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 5a70c91..b6bfa6f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -33,7 +33,6 @@
 /* Static data */
 
 static const struct omap_prcm_irq omap4_prcm_irqs[] = {
-	OMAP_PRCM_IRQ("wkup",   0,      0),
 	OMAP_PRCM_IRQ("io",     9,      1),
 };
 
-- 
1.7.9.5
