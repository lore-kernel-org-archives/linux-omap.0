From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v9 4/4] OMAP: McBSP: Use cache when modifying individual register bits
Date: Thu, 14 Jan 2010 17:13:36 +0100
Message-ID: <201001141713.38660.jkrzyszt@tis.icnet.pl>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:42118 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756229Ab0ANQNJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 11:13:09 -0500
In-Reply-To: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

Change the way McBSP registers are updated: use cached values instead of
relying upon those read back from the device.

With this patch, I have finally managed to get rid of all random
playback/recording hangups on my OMAP1510 based Amstrad Delta hardware. Before
that, values read back from McBSP registers to be used for updating them
happened to be errornous.

>From the hardware side, the issue appeared to be caused by a relatively high
power requirements of an external USB adapter connected to the board's printer
dedicated USB port.

I think there is one important point that makes this patch worth of applying,
apart from my hardware quality. With the current code, if it ever happens to
any machine, no matter if OMAP1510 or newer, to read incorrect value from a
McBSP register, this wrong value will get written back without any checking.
That can lead to hardware damage if, for example, an input pin is turned into
output as a result.

Applies on top of patch 3 from this series:
[PATCH v9 3/4] OMAP: McBSP: Introduce caching in register write operations

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next, commit 
fb7380d70e041e4b3892f6b19dff7efb609d15a4 (2.6.33-rc3+ dated 2010-01-11).
Compile-tested with omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
No functional changes since v3.

 arch/arm/plat-omap/mcbsp.c |   78 +++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

--- git/arch/arm/plat-omap/mcbsp.c.orig	2010-01-14 00:36:14.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2010-01-14 02:05:23.000000000 +0100
@@ -114,7 +114,8 @@ static irqreturn_t omap_mcbsp_tx_irq_han
 		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_tx, SPCR2, irqst_spcr2 & ~(XSYNC_ERR));
+		MCBSP_WRITE(mcbsp_tx, SPCR2,
+			    MCBSP_READ_CACHE(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
 	} else {
 		complete(&mcbsp_tx->tx_irq_completion);
 	}
@@ -134,7 +135,8 @@ static irqreturn_t omap_mcbsp_rx_irq_han
 		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_rx, SPCR1, irqst_spcr1 & ~(RSYNC_ERR));
+		MCBSP_WRITE(mcbsp_rx, SPCR1,
+			    MCBSP_READ_CACHE(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
 	} else {
 		complete(&mcbsp_rx->tx_irq_completion);
 	}
@@ -544,24 +546,25 @@ void omap_mcbsp_start(unsigned int id, i
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	mcbsp->rx_word_length = (MCBSP_READ(mcbsp, RCR1) >> 5) & 0x7;
-	mcbsp->tx_word_length = (MCBSP_READ(mcbsp, XCR1) >> 5) & 0x7;
+	mcbsp->rx_word_length = (MCBSP_READ_CACHE(mcbsp, RCR1) >> 5) & 0x7;
+	mcbsp->tx_word_length = (MCBSP_READ_CACHE(mcbsp, XCR1) >> 5) & 0x7;
 
-	idle = !((MCBSP_READ(mcbsp, SPCR2) | MCBSP_READ(mcbsp, SPCR1)) & 1);
+	idle = !((MCBSP_READ_CACHE(mcbsp, SPCR2) |
+			MCBSP_READ_CACHE(mcbsp, SPCR1)) & 1);
 
 	if (idle) {
 		/* Start the sample generator */
-		w = MCBSP_READ(mcbsp, SPCR2);
+		w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 6));
 	}
 
 	/* Enable transmitter and receiver */
 	tx &= 1;
-	w = MCBSP_READ(mcbsp, SPCR2);
+	w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 	MCBSP_WRITE(mcbsp, SPCR2, w | tx);
 
 	rx &= 1;
-	w = MCBSP_READ(mcbsp, SPCR1);
+	w = MCBSP_READ_CACHE(mcbsp, SPCR1);
 	MCBSP_WRITE(mcbsp, SPCR1, w | rx);
 
 	/*
@@ -574,16 +577,16 @@ void omap_mcbsp_start(unsigned int id, i
 
 	if (idle) {
 		/* Start frame sync */
-		w = MCBSP_READ(mcbsp, SPCR2);
+		w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));
 	}
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		/* Release the transmitter and receiver */
-		w = MCBSP_READ(mcbsp, XCCR);
+		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w &= ~(tx ? XDISABLE : 0);
 		MCBSP_WRITE(mcbsp, XCCR, w);
-		w = MCBSP_READ(mcbsp, RCCR);
+		w = MCBSP_READ_CACHE(mcbsp, RCCR);
 		w &= ~(rx ? RDISABLE : 0);
 		MCBSP_WRITE(mcbsp, RCCR, w);
 	}
@@ -609,28 +612,29 @@ void omap_mcbsp_stop(unsigned int id, in
 	/* Reset transmitter */
 	tx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		w = MCBSP_READ(mcbsp, XCCR);
+		w = MCBSP_READ_CACHE(mcbsp, XCCR);
 		w |= (tx ? XDISABLE : 0);
 		MCBSP_WRITE(mcbsp, XCCR, w);
 	}
-	w = MCBSP_READ(mcbsp, SPCR2);
+	w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 	MCBSP_WRITE(mcbsp, SPCR2, w & ~tx);
 
 	/* Reset receiver */
 	rx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		w = MCBSP_READ(mcbsp, RCCR);
+		w = MCBSP_READ_CACHE(mcbsp, RCCR);
 		w |= (rx ? RDISABLE : 0);
 		MCBSP_WRITE(mcbsp, RCCR, w);
 	}
-	w = MCBSP_READ(mcbsp, SPCR1);
+	w = MCBSP_READ_CACHE(mcbsp, SPCR1);
 	MCBSP_WRITE(mcbsp, SPCR1, w & ~rx);
 
-	idle = !((MCBSP_READ(mcbsp, SPCR2) | MCBSP_READ(mcbsp, SPCR1)) & 1);
+	idle = !((MCBSP_READ_CACHE(mcbsp, SPCR2) |
+			MCBSP_READ_CACHE(mcbsp, SPCR1)) & 1);
 
 	if (idle) {
 		/* Reset the sample rate generator */
-		w = MCBSP_READ(mcbsp, SPCR2);
+		w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 		MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6));
 	}
 }
@@ -653,7 +657,7 @@ int omap_mcbsp_pollwrite(unsigned int id
 	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
 		/* clear error */
 		MCBSP_WRITE(mcbsp, SPCR2,
-				MCBSP_READ(mcbsp, SPCR2) & (~XSYNC_ERR));
+				MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
@@ -662,10 +666,12 @@ int omap_mcbsp_pollwrite(unsigned int id
 		while (!(MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
 			if (attemps++ > 1000) {
 				MCBSP_WRITE(mcbsp, SPCR2,
-					    MCBSP_READ(mcbsp, SPCR2) & (~XRST));
+						MCBSP_READ_CACHE(mcbsp, SPCR2) &
+						(~XRST));
 				udelay(10);
 				MCBSP_WRITE(mcbsp, SPCR2,
-					    MCBSP_READ(mcbsp, SPCR2) | (XRST));
+						MCBSP_READ_CACHE(mcbsp, SPCR2) |
+						(XRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not write to"
 					" McBSP%d Register\n", mcbsp->id);
@@ -692,7 +698,7 @@ int omap_mcbsp_pollread(unsigned int id,
 	if (MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
 		/* clear error */
 		MCBSP_WRITE(mcbsp, SPCR1,
-				MCBSP_READ(mcbsp, SPCR1) & (~RSYNC_ERR));
+				MCBSP_READ_CACHE(mcbsp, SPCR1) & (~RSYNC_ERR));
 		/* resend */
 		return -1;
 	} else {
@@ -701,10 +707,12 @@ int omap_mcbsp_pollread(unsigned int id,
 		while (!(MCBSP_READ(mcbsp, SPCR1) & RRDY)) {
 			if (attemps++ > 1000) {
 				MCBSP_WRITE(mcbsp, SPCR1,
-					    MCBSP_READ(mcbsp, SPCR1) & (~RRST));
+						MCBSP_READ_CACHE(mcbsp, SPCR1) &
+						(~RRST));
 				udelay(10);
 				MCBSP_WRITE(mcbsp, SPCR1,
-					    MCBSP_READ(mcbsp, SPCR1) | (RRST));
+						MCBSP_READ_CACHE(mcbsp, SPCR1) |
+						(RRST));
 				udelay(10);
 				dev_err(mcbsp->dev, "Could not read from"
 					" McBSP%d Register\n", mcbsp->id);
@@ -790,9 +798,11 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		spcr2 = MCBSP_READ(mcbsp, SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			MCBSP_WRITE(mcbsp, SPCR2, spcr2 & (~XRST));
+			MCBSP_WRITE(mcbsp, SPCR2,
+				    MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XRST));
 			udelay(10);
-			MCBSP_WRITE(mcbsp, SPCR2, spcr2 | XRST);
+			MCBSP_WRITE(mcbsp, SPCR2,
+				    MCBSP_READ_CACHE(mcbsp, SPCR2) | XRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp->id);
@@ -811,9 +821,11 @@ int omap_mcbsp_spi_master_xmit_word_poll
 		spcr1 = MCBSP_READ(mcbsp, SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			MCBSP_WRITE(mcbsp, SPCR1, spcr1 & (~RRST));
+			MCBSP_WRITE(mcbsp, SPCR1,
+				    MCBSP_READ_CACHE(mcbsp, SPCR1) & (~RRST));
 			udelay(10);
-			MCBSP_WRITE(mcbsp, SPCR1, spcr1 | RRST);
+			MCBSP_WRITE(mcbsp, SPCR1,
+				    MCBSP_READ_CACHE(mcbsp, SPCR1) | RRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d receiver not "
 				"ready\n", mcbsp->id);
@@ -857,9 +869,11 @@ int omap_mcbsp_spi_master_recv_word_poll
 		spcr2 = MCBSP_READ(mcbsp, SPCR2);
 		if (attempts++ > 1000) {
 			/* We must reset the transmitter */
-			MCBSP_WRITE(mcbsp, SPCR2, spcr2 & (~XRST));
+			MCBSP_WRITE(mcbsp, SPCR2,
+				    MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XRST));
 			udelay(10);
-			MCBSP_WRITE(mcbsp, SPCR2, spcr2 | XRST);
+			MCBSP_WRITE(mcbsp, SPCR2,
+				    MCBSP_READ_CACHE(mcbsp, SPCR2) | XRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d transmitter not "
 				"ready\n", mcbsp->id);
@@ -878,9 +892,11 @@ int omap_mcbsp_spi_master_recv_word_poll
 		spcr1 = MCBSP_READ(mcbsp, SPCR1);
 		if (attempts++ > 1000) {
 			/* We must reset the receiver */
-			MCBSP_WRITE(mcbsp, SPCR1, spcr1 & (~RRST));
+			MCBSP_WRITE(mcbsp, SPCR1,
+				    MCBSP_READ_CACHE(mcbsp, SPCR1) & (~RRST));
 			udelay(10);
-			MCBSP_WRITE(mcbsp, SPCR1, spcr1 | RRST);
+			MCBSP_WRITE(mcbsp, SPCR1,
+				    MCBSP_READ_CACHE(mcbsp, SPCR1) | RRST);
 			udelay(10);
 			dev_err(mcbsp->dev, "McBSP%d receiver not "
 				"ready\n", mcbsp->id);

