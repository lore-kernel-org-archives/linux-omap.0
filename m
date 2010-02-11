From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/17] omap: McBSP: Use macros for all register read/write
	operations
Date: Wed, 10 Feb 2010 19:35:49 -0800
Message-ID: <20100211033549.1624.34342.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58245 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab0BKDfK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:35:10 -0500
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

There are several places where readw()/writew() functions are used instead of
OMAP_MCBSP_READ()/WRITE() macros for manipulating McBSP registers. Replace
them with macros to ensure consistent behaviour after caching is introduced.

Tested on OMAP1510 based Amstrad Delta.
Compile-tested with omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index c1eb615..eaaf53b 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -636,26 +636,26 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 	mcbsp = id_to_mcbsp_ptr(id);
 	base = mcbsp->io_base;
 
-	writew(buf, base + OMAP_MCBSP_REG_DXR1);
+	OMAP_MCBSP_WRITE(base, DXR1, buf);
 	/* if frame sync error - clear the error */
-	if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
+	if (OMAP_MCBSP_READ(base, SPCR2) & XSYNC_ERR) {
 		/* clear error */
-		writew(readw(base + OMAP_MCBSP_REG_SPCR2) & (~XSYNC_ERR),
-		       base + OMAP_MCBSP_REG_SPCR2);
+		OMAP_MCBSP_WRITE(base, SPCR2,
+				OMAP_MCBSP_READ(base, SPCR2) & (~XSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
 		/* wait for transmit confirmation */
 		int attemps = 0;
-		while (!(readw(base + OMAP_MCBSP_REG_SPCR2) & XRDY)) {
+		while (!(OMAP_MCBSP_READ(base, SPCR2) & XRDY)) {
 			if (attemps++ > 1000) {
-				writew(readw(base + OMAP_MCBSP_REG_SPCR2) &
-				       (~XRST),
-				       base + OMAP_MCBSP_REG_SPCR2);
+				OMAP_MCBSP_WRITE(base, SPCR2,
+						OMAP_MCBSP_READ(base, SPCR2) &
+						(~XRST));
 				udelay(10);
-				writew(readw(base + OMAP_MCBSP_REG_SPCR2) |
-				       (XRST),
-				       base + OMAP_MCBSP_REG_SPCR2);
+				OMAP_MCBSP_WRITE(base, SPCR2,
+						OMAP_MCBSP_READ(base, SPCR2) |
+						(XRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not write to"
 					" McBSP%d Register\n", mcbsp->id);
@@ -681,24 +681,24 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 
 	base = mcbsp->io_base;
 	/* if frame sync error - clear the error */
-	if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
+	if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
 		/* clear error */
-		writew(readw(base + OMAP_MCBSP_REG_SPCR1) & (~RSYNC_ERR),
-		       base + OMAP_MCBSP_REG_SPCR1);
+		OMAP_MCBSP_WRITE(base, SPCR1,
+				OMAP_MCBSP_READ(base, SPCR1) & (~RSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
 		/* wait for recieve confirmation */
 		int attemps = 0;
-		while (!(readw(base + OMAP_MCBSP_REG_SPCR1) & RRDY)) {
+		while (!(OMAP_MCBSP_READ(base, SPCR1) & RRDY)) {
 			if (attemps++ > 1000) {
-				writew(readw(base + OMAP_MCBSP_REG_SPCR1) &
-				       (~RRST),
-				       base + OMAP_MCBSP_REG_SPCR1);
+				OMAP_MCBSP_WRITE(base, SPCR1,
+						OMAP_MCBSP_READ(base, SPCR1) &
+						(~RRST));
 				udelay(10);
-				writew(readw(base + OMAP_MCBSP_REG_SPCR1) |
-				       (RRST),
-				       base + OMAP_MCBSP_REG_SPCR1);
+				OMAP_MCBSP_WRITE(base, SPCR1,
+						OMAP_MCBSP_READ(base, SPCR1) |
+						(RRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not read from"
 					" McBSP%d Register\n", mcbsp->id);
@@ -706,7 +706,7 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 			}
 		}
 	}
-	*buf = readw(base + OMAP_MCBSP_REG_DRR1);
+	*buf = OMAP_MCBSP_READ(base, DRR1);
 
 	return 0;
 }

