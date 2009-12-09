From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v7 1/5] OMAP: McBSP: Use macros for all register read/write operations
Date: Wed, 9 Dec 2009 21:27:46 +0100
Message-ID: <200912092127.48340.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:38386 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbZLIU1h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 15:27:37 -0500
In-Reply-To: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

There are several places where readw()/writew() functions are used instead of
OMAP_MCBSP_READ()/WRITE() macros for manipulating McBSP registers. Replace
them with macros to ensure consistent behaviour after caching is introduced.

Created against linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.

Tested on OMAP1510 based Amstrad Delta.
Compile-tested with omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
No functional changes since v3.

 arch/arm/plat-omap/mcbsp.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mcbsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-02 15:48:52.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-09 15:10:56.000000000 +0100
@@ -622,26 +622,26 @@ int omap_mcbsp_pollwrite(unsigned int id
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
@@ -667,24 +667,24 @@ int omap_mcbsp_pollread(unsigned int id,
 
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
@@ -692,7 +692,7 @@ int omap_mcbsp_pollread(unsigned int id,
 			}
 		}
 	}
-	*buf = readw(base + OMAP_MCBSP_REG_DRR1);
+	*buf = OMAP_MCBSP_READ(base, DRR1);
 
 	return 0;
 }
