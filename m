From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for
 easy cache access
Date: Fri, 11 Dec 2009 19:40:26 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC141AC4@dbde02.ent.ti.com>
References: <200912092129.30422.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757466AbZLKOLA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 09:11:00 -0500
In-Reply-To: <200912092129.30422.jkrzyszt@tis.icnet.pl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Janusz 
>Krzysztofik
>Sent: Thursday, December 10, 2009 1:59 AM
>To: Tony Lindgren
>Cc: Jarkko Nikula; Peter Ujfalusi; linux-omap@vger.kernel.org
>Subject: [PATCH v7 2/5] OMAP: McBSP: Modify macros/functions 
>API for easy cache access
>
>OMAP_MCBSP_READ()/_WRITE() macros and 
>omap_mcbsp_read()/_write() functions
>accept McBSP register base address as an argument. In order to support
>caching, that must be replaced with an address of the 
>omap_mcbsp structure
>that would provide addresses for both register AND cache access.
>
>Since OMAP_ prefix seems obvious in macro names, drop it off 
>in order to
>minimize line wrapping throughout the file.
>
>Applies on top of patch 1 from this series:
>[PATCH v7 1/5] OMAP: McBSP: Use macros for all register 
>read/write operations
>
>Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
>commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
>Compile-tested with omap_3430sdp_defconfig.
>
>Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
>---
>Changes since v3:
>- modify API of omap_mcbsp_read()/_write() functions as well, 
>since those will
>  actually provide caching operations, not macros like before.
>

<snip>



>@@ -313,19 +305,18 @@ static inline void omap34xx_mcbsp_reques
> 	if (cpu_is_omap34xx()) {
> 		u16 syscon;
> 
>-		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
>+		syscon = MCBSP_READ(mcbsp, SYSCON);
> 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | 
>CLOCKACTIVITY(0x03));

Would this driver get adpated to the hwmod framework? Then this 
would be invalid.

> 
> 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
> 			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
> 					CLOCKACTIVITY(0x02));
>-			OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN,
>-					XRDYEN | RRDYEN);
>+			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
> 		} else {
> 			syscon |= SIDLEMODE(0x01);
> 		}
> 
>-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
>+		MCBSP_WRITE(mcbsp, SYSCON, syscon);

Ditto

> 	}
> }
> 
>@@ -337,7 +328,7 @@ static inline void omap34xx_mcbsp_free(s
> 	if (cpu_is_omap34xx()) {
> 		u16 syscon;
> 
>-		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
>+		syscon = MCBSP_READ(mcbsp, SYSCON);
> 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | 
>CLOCKACTIVITY(0x03));
> 		/*
> 		 * HW bug workaround - If no_idle mode is 
>taken, we need to
>@@ -345,12 +336,12 @@ static inline void omap34xx_mcbsp_free(s
> 		 * device will not hit retention anymore.
> 		 */
> 		syscon |= SIDLEMODE(0x02);
>-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
>+		MCBSP_WRITE(mcbsp, SYSCON, syscon);

Ditto

> 
> 		syscon &= ~(SIDLEMODE(0x03));
>-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
>+		MCBSP_WRITE(mcbsp, SYSCON, syscon);

Ditto

> 
>-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
>+		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
> 	}
> }

<snip>

> 
> 	/*
> 	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
>@@ -543,18 +531,18 @@ void omap_mcbsp_start(unsigned int id, i
> 
> 	if (idle) {
> 		/* Start frame sync */
>-		w = OMAP_MCBSP_READ(io_base, SPCR2);
>-		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
>+		w = MCBSP_READ(mcbsp, SPCR2);
>+		MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7));
> 	}
> 
> 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {

Why not 44xx?

> 		/* Release the transmitter and receiver */
>-		w = OMAP_MCBSP_READ(io_base, XCCR);
>+		w = MCBSP_READ(mcbsp, XCCR);
> 		w &= ~(tx ? XDISABLE : 0);
>-		OMAP_MCBSP_WRITE(io_base, XCCR, w);
>-		w = OMAP_MCBSP_READ(io_base, RCCR);
>+		MCBSP_WRITE(mcbsp, XCCR, w);
>+		w = MCBSP_READ(mcbsp, RCCR);
> 		w &= ~(rx ? RDISABLE : 0);
>-		OMAP_MCBSP_WRITE(io_base, RCCR, w);
>+		MCBSP_WRITE(mcbsp, RCCR, w);
> 	}
> 
> 	/* Dump McBSP Regs */
>@@ -565,7 +553,6 @@ EXPORT_SYMBOL(omap_mcbsp_start);
> void omap_mcbsp_stop(unsigned int id, int tx, int rx)
> {
> 	struct omap_mcbsp *mcbsp;
>-	void __iomem *io_base;
> 	int idle;
> 	u16 w;
> 
>@@ -575,35 +562,33 @@ void omap_mcbsp_stop(unsigned int id, in
> 	}
> 
> 	mcbsp = id_to_mcbsp_ptr(id);
>-	io_base = mcbsp->io_base;
> 
> 	/* Reset transmitter */
> 	tx &= 1;
> 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {

Why not 44xx?

>-		w = OMAP_MCBSP_READ(io_base, XCCR);
>+		w = MCBSP_READ(mcbsp, XCCR);
> 		w |= (tx ? XDISABLE : 0);
>-		OMAP_MCBSP_WRITE(io_base, XCCR, w);
>+		MCBSP_WRITE(mcbsp, XCCR, w);
> 	}
>-	w = OMAP_MCBSP_READ(io_base, SPCR2);
>-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~tx);
>+	w = MCBSP_READ(mcbsp, SPCR2);
>+	MCBSP_WRITE(mcbsp, SPCR2, w & ~tx);
> 
> 	/* Reset receiver */
> 	rx &= 1;
> 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {

Ditto

>-		w = OMAP_MCBSP_READ(io_base, RCCR);
>+		w = MCBSP_READ(mcbsp, RCCR);
> 		w |= (rx ? RDISABLE : 0);
>-		OMAP_MCBSP_WRITE(io_base, RCCR, w);
>+		MCBSP_WRITE(mcbsp, RCCR, w);
> 	}
>-	w = OMAP_MCBSP_READ(io_base, SPCR1);
>-	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~rx);
>+	w = MCBSP_READ(mcbsp, SPCR1);
>+	MCBSP_WRITE(mcbsp, SPCR1, w & ~rx);
> 
>-	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
>-		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
>+	idle = !((MCBSP_READ(mcbsp, SPCR2) | MCBSP_READ(mcbsp, 
>SPCR1)) & 1);
> 
> 	if (idle) {
> 		/* Reset the sample rate generator */
>-		w = OMAP_MCBSP_READ(io_base, SPCR2);
>-		OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
>+		w = MCBSP_READ(mcbsp, SPCR2);
>+		MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6));
> 	}
> }
> EXPORT_SYMBOL(omap_mcbsp_stop);
>@@ -612,7 +597,6 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
> int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
> {
> 	struct omap_mcbsp *mcbsp;
>-	void __iomem *base;
> 
> 	if (!omap_mcbsp_check_valid_id(id)) {
> 		printk(KERN_ERR "%s: Invalid id (%d)\n", 
>__func__, id + 1);
>@@ -620,28 +604,25 @@ int omap_mcbsp_pollwrite(unsigned int id
> 	}
> 
> 	mcbsp = id_to_mcbsp_ptr(id);
>-	base = mcbsp->io_base;
> 
>-	OMAP_MCBSP_WRITE(base, DXR1, buf);
>+	MCBSP_WRITE(mcbsp, DXR1, buf);

OMAP3/4 allows 32 bit data access also. 
How is it taken care? Please refer to 
http://patchwork.kernel.org/patch/54896/ for more details.

Quoting Tony's words:
"To me it smells like the all drivers using the the
omap_mcbsp_pollread/write are broken legacy drivers.
So maybe we should just remove these two functions?
If we really want to keep these around, we should review
the drivers using these functions. "


> 	/* if frame sync error - clear the error */
>-	if (OMAP_MCBSP_READ(base, SPCR2) & XSYNC_ERR) {
>+	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
> 		/* clear error */
>-		OMAP_MCBSP_WRITE(base, SPCR2,
>-				OMAP_MCBSP_READ(base, SPCR2) & 
>(~XSYNC_ERR));
>+		MCBSP_WRITE(mcbsp, SPCR2,
>+				MCBSP_READ(mcbsp, SPCR2) & 
>(~XSYNC_ERR));
> 		/* resend */
> 		return -1;
> 	} else {
> 		/* wait for transmit confirmation */
> 		int attemps = 0;
>-		while (!(OMAP_MCBSP_READ(base, SPCR2) & XRDY)) {
>+		while (!(MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
> 			if (attemps++ > 1000) {
>-				OMAP_MCBSP_WRITE(base, SPCR2,
>-						
>OMAP_MCBSP_READ(base, SPCR2) &
>-						(~XRST));
>+				MCBSP_WRITE(mcbsp, SPCR2,
>+					    MCBSP_READ(mcbsp, 
>SPCR2) & (~XRST));
> 				udelay(10);
>-				OMAP_MCBSP_WRITE(base, SPCR2,
>-						
>OMAP_MCBSP_READ(base, SPCR2) |
>-						(XRST));
>+				MCBSP_WRITE(mcbsp, SPCR2,
>+					    MCBSP_READ(mcbsp, 
>SPCR2) | (XRST));
> 				udelay(10);
> 				dev_err(mcbsp->dev, "Could not write to"
> 					" McBSP%d Register\n", 
>mcbsp->id);
>@@ -657,7 +638,6 @@ EXPORT_SYMBOL(omap_mcbsp_pollwrite);
> int omap_mcbsp_pollread(unsigned int id, u16 *buf)
> {
> 	struct omap_mcbsp *mcbsp;
>-	void __iomem *base;
> 
> 	if (!omap_mcbsp_check_valid_id(id)) {
> 		printk(KERN_ERR "%s: Invalid id (%d)\n", 
>__func__, id + 1);
>@@ -665,26 +645,23 @@ int omap_mcbsp_pollread(unsigned int id,
> 	}
> 	mcbsp = id_to_mcbsp_ptr(id);
> 
>-	base = mcbsp->io_base;
> 	/* if frame sync error - clear the error */
>-	if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
>+	if (MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
> 		/* clear error */
>-		OMAP_MCBSP_WRITE(base, SPCR1,
>-				OMAP_MCBSP_READ(base, SPCR1) & 
>(~RSYNC_ERR));
>+		MCBSP_WRITE(mcbsp, SPCR1,
>+				MCBSP_READ(mcbsp, SPCR1) & 
>(~RSYNC_ERR));
> 		/* resend */
> 		return -1;
> 	} else {
> 		/* wait for recieve confirmation */
> 		int attemps = 0;
>-		while (!(OMAP_MCBSP_READ(base, SPCR1) & RRDY)) {
>+		while (!(MCBSP_READ(mcbsp, SPCR1) & RRDY)) {
> 			if (attemps++ > 1000) {
>-				OMAP_MCBSP_WRITE(base, SPCR1,
>-						
>OMAP_MCBSP_READ(base, SPCR1) &
>-						(~RRST));
>+				MCBSP_WRITE(mcbsp, SPCR1,
>+					    MCBSP_READ(mcbsp, 
>SPCR1) & (~RRST));
> 				udelay(10);
>-				OMAP_MCBSP_WRITE(base, SPCR1,
>-						
>OMAP_MCBSP_READ(base, SPCR1) |
>-						(RRST));
>+				MCBSP_WRITE(mcbsp, SPCR1,
>+					    MCBSP_READ(mcbsp, 
>SPCR1) | (RRST));
> 				udelay(10);
> 				dev_err(mcbsp->dev, "Could not 
>read from"
> 					" McBSP%d Register\n", 
>mcbsp->id);
>@@ -692,7 +669,7 @@ int omap_mcbsp_pollread(unsigned int id,
> 			}
> 		}
> 	}
>-	*buf = OMAP_MCBSP_READ(base, DRR1);
>+	*buf = MCBSP_READ(mcbsp, DRR1);
> 
> 	return 0;
> }

<snip>

Was this code tested for different configurations 
like DMA mode, poll mode?
