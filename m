From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] ARM: OMAP: McBSP: Merge two functions into omap_mcbsp_start/_stop
Date: Sun, 23 Aug 2009 12:24:27 +0300
Message-ID: <1251019467-11677-4-git-send-email-jhnikula@gmail.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:32790 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929AbZHWJXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 05:23:32 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so1640891ewy.18
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 02:23:33 -0700 (PDT)
In-Reply-To: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, tony@atomide.com, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Functionality of functions omap_mcbsp_xmit_enable and omap_mcbsp_recv_enable
can be merged into omap_mcbsp_start and omap_mcbsp_stop since API of
those omap_mcbsp_start and omap_mcbsp_stop was changed recently allowing
to start and stop individually the transmitter and receiver.

This cleans up the code in arch/arm/plat-omap/mcbsp.c and in
sound/soc/omap/omap-mcbsp.c which was the only user for those removed
functions.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    2 -
 arch/arm/plat-omap/mcbsp.c              |   84 ++++++++++--------------------
 sound/soc/omap/omap-mcbsp.c             |    5 --
 3 files changed, 28 insertions(+), 63 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 70e950e..63a3f25 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -436,8 +436,6 @@ int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
 void omap_mcbsp_stop(unsigned int id, int tx, int rx);
-void omap_mcbsp_xmit_enable(unsigned int id, u8 enable);
-void omap_mcbsp_recv_enable(unsigned int id, u8 enable);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word);
 u32 omap_mcbsp_recv_word(unsigned int id);
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 28e29b9..7e7d435 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -529,11 +529,13 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	}
 
 	/* Enable transmitter and receiver */
+	tx &= 1;
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (tx & 1));
+	OMAP_MCBSP_WRITE(io_base, SPCR2, w | tx);
 
+	rx &= 1;
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w | (rx & 1));
+	OMAP_MCBSP_WRITE(io_base, SPCR1, w | rx);
 
 	/*
 	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
@@ -549,6 +551,16 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
 	}
 
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		/* Release the transmitter and receiver */
+		w = OMAP_MCBSP_READ(io_base, XCCR);
+		w &= ~(tx ? XDISABLE : 0);
+		OMAP_MCBSP_WRITE(io_base, XCCR, w);
+		w = OMAP_MCBSP_READ(io_base, RCCR);
+		w &= ~(rx ? RDISABLE : 0);
+		OMAP_MCBSP_WRITE(io_base, RCCR, w);
+	}
+
 	/* Dump McBSP Regs */
 	omap_mcbsp_dump_reg(id);
 }
@@ -570,12 +582,24 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 	io_base = mcbsp->io_base;
 
 	/* Reset transmitter */
+	tx &= 1;
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		w = OMAP_MCBSP_READ(io_base, XCCR);
+		w |= (tx ? XDISABLE : 0);
+		OMAP_MCBSP_WRITE(io_base, XCCR, w);
+	}
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(tx & 1));
+	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~tx);
 
 	/* Reset receiver */
+	rx &= 1;
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		w = OMAP_MCBSP_READ(io_base, RCCR);
+		w |= (tx ? RDISABLE : 0);
+		OMAP_MCBSP_WRITE(io_base, RCCR, w);
+	}
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~(rx & 1));
+	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~rx);
 
 	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
 		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
@@ -588,58 +612,6 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
-void omap_mcbsp_xmit_enable(unsigned int id, u8 enable)
-{
-	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
-	u16 w;
-
-	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
-		return;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
-
-	w = OMAP_MCBSP_READ(io_base, XCCR);
-
-	if (enable)
-		OMAP_MCBSP_WRITE(io_base, XCCR, w & ~(XDISABLE));
-	else
-		OMAP_MCBSP_WRITE(io_base, XCCR, w | XDISABLE);
-}
-EXPORT_SYMBOL(omap_mcbsp_xmit_enable);
-
-void omap_mcbsp_recv_enable(unsigned int id, u8 enable)
-{
-	struct omap_mcbsp *mcbsp;
-	void __iomem *io_base;
-	u16 w;
-
-	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
-		return;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
-	io_base = mcbsp->io_base;
-
-	w = OMAP_MCBSP_READ(io_base, RCCR);
-
-	if (enable)
-		OMAP_MCBSP_WRITE(io_base, RCCR, w & ~(RDISABLE));
-	else
-		OMAP_MCBSP_WRITE(io_base, RCCR, w | RDISABLE);
-}
-EXPORT_SYMBOL(omap_mcbsp_recv_enable);
-
 /* polled mcbsp i/o operations */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 89e8bce..0e173e7 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -231,11 +231,6 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		mcbsp_data->active++;
 		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
-		/* Make sure data transfer is frame synchronized */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			omap_mcbsp_xmit_enable(mcbsp_data->bus_id, 1);
-		else
-			omap_mcbsp_recv_enable(mcbsp_data->bus_id, 1);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.6.3.3

