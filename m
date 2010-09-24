From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] omap: McBSP: Do not enable SRG in slave mode
Date: Thu, 23 Sep 2010 18:51:07 -0700
Message-ID: <20100924015107.10325.41789.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57763 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0IXBvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:51:07 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

McBSP SRG (Sample Rate Generator) and FSG (Frame Sync
Generator) is only needed to be enabled, when McBSP
is master.
In McBSP slave mode, the SRG, and FSG can be kept disabled,
which might save some power at the end in this configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e31496e..ecbfe39 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -878,7 +878,7 @@ EXPORT_SYMBOL(omap_mcbsp_free);
 void omap_mcbsp_start(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
-	int idle;
+	int enable_srg = 0;
 	u16 w;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -893,10 +893,13 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	mcbsp->rx_word_length = (MCBSP_READ_CACHE(mcbsp, RCR1) >> 5) & 0x7;
 	mcbsp->tx_word_length = (MCBSP_READ_CACHE(mcbsp, XCR1) >> 5) & 0x7;
 
-	idle = !((MCBSP_READ_CACHE(mcbsp, SPCR2) |
-			MCBSP_READ_CACHE(mcbsp, SPCR1)) & 1);
+	/* Only enable SRG, if McBSP is master */
+	w = MCBSP_READ_CACHE(mcbsp, PCR0);
+	if (w & (FSXM | FSRM | CLKXM | CLKRM))
+		enable_srg = !((MCBSP_READ_CACHE(mcbsp, SPCR2) |
+				MCBSP_READ_CACHE(mcbsp, SPCR1)) & 1);
 
-	if (idle) {
+	if (enable_srg) {
 		/* Start the sample generator */
 		w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 6));
@@ -919,7 +922,7 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	 */
 	udelay(500);
 
-	if (idle) {
+	if (enable_srg) {
 		/* Start frame sync */
 		w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));

