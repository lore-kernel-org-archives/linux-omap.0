From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH resend 05/13] omap: mcbsp: Make tranceiver configuration control register access generic
Date: Mon, 26 Sep 2011 10:45:41 +0300
Message-ID: <1317023150-6730-6-git-send-email-jarkko.nikula@bitmer.com>
References: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49010 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab1IZHq1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 03:46:27 -0400
In-Reply-To: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

McBSP transmit and receive configuration control registers must be set up
for OMAP2430 and later. Replace is_omap tests in generic code with a new
feature flag has_ccr in platform data so that there is no need to change
code for any upcoming OMAP version.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap2/mcbsp.c             |    6 ++++--
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 +
 arch/arm/plat-omap/mcbsp.c              |    8 ++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index de3457d..d6cce00 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -127,10 +127,12 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	}
 
 	pdata->reg_step = 4;
-	if (oh->class->rev < MCBSP_CONFIG_TYPE2)
+	if (oh->class->rev < MCBSP_CONFIG_TYPE2) {
 		pdata->reg_size = 2;
-	else
+	} else {
 		pdata->reg_size = 4;
+		pdata->has_ccr = true;
+	}
 
 	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
 		if (id == 2)
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index ac48d83..eed20ef 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -320,6 +320,7 @@ struct omap_mcbsp_platform_data {
 
 	/* McBSP platform and instance specific features */
 	bool has_wakeup; /* Wakeup capability */
+	bool has_ccr; /* Transceiver has configuration control registers */
 };
 
 struct omap_mcbsp_st_data {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0338ad0..97bcbfa 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -184,7 +184,7 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 	MCBSP_WRITE(mcbsp, MCR2, config->mcr2);
 	MCBSP_WRITE(mcbsp, MCR1, config->mcr1);
 	MCBSP_WRITE(mcbsp, PCR0, config->pcr0);
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->pdata->has_ccr) {
 		MCBSP_WRITE(mcbsp, XCCR, config->xccr);
 		MCBSP_WRITE(mcbsp, RCCR, config->rccr);
 	}
@@ -848,7 +848,7 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->pdata->has_ccr) {
 		/* Release the transmitter and receiver */
 		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w &= ~(tx ? XDISABLE : 0);
@@ -878,7 +878,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 
 	/* Reset transmitter */
 	tx &= 1;
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->pdata->has_ccr) {
 		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w |= (tx ? XDISABLE : 0);
 		MCBSP_WRITE(mcbsp, XCCR, w);
@@ -888,7 +888,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 
 	/* Reset receiver */
 	rx &= 1;
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->pdata->has_ccr) {
 		w = MCBSP_READ_CACHE(mcbsp, RCCR);
 		w |= (rx ? RDISABLE : 0);
 		MCBSP_WRITE(mcbsp, RCCR, w);
-- 
1.7.6.3

