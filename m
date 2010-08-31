From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] OMAP: McBSP: Do not enable SRG in slave mode
Date: Tue, 31 Aug 2010 11:11:44 +0300
Message-ID: <1283242304-27738-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36238 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab0HaIMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 04:12:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, jhnikula@gmail.com

McBSP SRG (Sample Rate Generator) and FSG (Frame Sync
Generator) is only needed to be enabled, when McBSP
is master.
In McBSP slave mode, the SRG, and FSG can be kept disabled,
which might save some power at the end in this configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello Jarkko,

I have tested this on OMAP3, but I think this should be
applicable for other OMAP versions as well.
When McBSP was slave the audio worked fine, when I left
the SRG, and FSG disabled.

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
-- 
1.7.2.2

