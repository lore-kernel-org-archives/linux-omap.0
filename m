From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] OMAP4 ES2: HSMMC soft reset change
Date: Fri, 01 Oct 2010 16:34:17 -0700
Message-ID: <20101001233417.31894.33130.stgit@baageli.muru.com>
References: <20101001233315.31894.49599.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56321 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab0JAXeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:34:19 -0400
In-Reply-To: <20101001233315.31894.49599.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

The omap4 es2 hsmmc has a updated soft reset logic.After the
reset is issued monitor a 0->1 transition first. The reset of
CMD or DATA lines is complete only after a 0->1->0 transition
of SRC or SRD bits.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Tested-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |   11 +++++++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index eb92b81..df1311d 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -303,6 +303,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		else
 			mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
+		if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
+			mmc->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+
 		switch (c->mmc) {
 		case 1:
 			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index bc85010..0f0f113 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -110,6 +110,7 @@ struct omap_mmc_platform_data {
 
 		/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
+#define HSMMC_HAS_UPDATED_RESET	(1 << 1)
 		unsigned features;
 
 		int switch_pin;			/* gpio (card detect) */
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 53f8fa5..69858e7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -982,6 +982,17 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
 
+	/*
+	 * OMAP4 ES2 and greater has an updated reset logic.
+	 * Monitor a 0->1 transition first
+	 */
+	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
+		while ((!(OMAP_HSMMC_READ(host, SYSCTL) & bit))
+					&& (i++ < limit))
+			cpu_relax();
+	}
+	i = 0;
+
 	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
 		(i++ < limit))
 		cpu_relax();

