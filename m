From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2/2] ARM: OMAP: Add some ugly looking comments into OMAP24xx
 EAC driver
Date: Fri, 2 Mar 2007 13:00:13 +0200
Message-ID: <20070302130013.a6099159.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/arm/omap/eac.c |  164 +++++++++++++++++++++++++-------------------------
 1 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index 629b113..51d50fc 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -94,119 +94,119 @@
 #define EAC_SYSSTATUS		0x0108
 
 /* CPTCTL */
-#define CPTCTL_RXF		(1 << 7)
-#define CPTCTL_RXIE		(1 << 6)
-#define CPTCTL_TXE		(1 << 5)
-#define CPTCTL_TXIE		(1 << 4)
-#define CPTCTL_CPEN		(1 << 3)
-#define CPTCTL_CRST		(1 << 0)
+#define CPTCTL_RXF		(1 << 7)	/* receive data register full */
+#define CPTCTL_RXIE		(1 << 6)	/* receive interrupt enable */
+#define CPTCTL_TXE		(1 << 5)	/* transmit register empty */
+#define CPTCTL_TXIE		(1 << 4)	/* transmit interrupt enable */
+#define CPTCTL_CPEN		(1 << 3)	/* codec port enable */
+#define CPTCTL_CRST		(1 << 0)	/* external codec reset */
 
 /* CPCFR1 */
-#define CPCFR1_MTSL(val)	((val & 0x1f) << 3)
+#define CPCFR1_MTSL(val)	((val & 0x1f) << 3)	/* number of time slots per frame */
 #define CPCFR1_MTSL_BITS	(0x1f << 3)
-#define CPCFR1_MODE(val)	((val & 0x7) << 0)
+#define CPCFR1_MODE(val)	((val & 0x7) << 0)	/* codec port interface mode */
 #define CPCFR1_MODE_BITS	(0x7 << 0)
 
 /* CPCFR2 */
-#define CPCFR2_TSLOL(val)	((val & 0x3) << 6)
+#define CPCFR2_TSLOL(val)	((val & 0x3) << 6)	/* time slot 0 length in number of serial clock (CLK_BIT) cycles */
 #define CPCFR2_TSLOL_BITS	(0x3 << 6)
-#define CPCFR2_BPTSL(val)	((val & 0x7) << 3)
+#define CPCFR2_BPTSL(val)	((val & 0x7) << 3)	/* number of data bits per audio time slot */
 #define CPCFR2_BPTSL_BITS	(0x7 << 3)
-#define CPCFR2_TSLL(val)	((val & 0x7) << 0)
+#define CPCFR2_TSLL(val)	((val & 0x7) << 0)	/* time slot lenght (except slot 0) in number of serial clock cycles */
 #define CPCFR2_TSLL_BITS	(0x7 << 0)
 
 /* CPCFR3 */
-#define CPCFR3_DDLY		(1 << 7)
-#define CPCFR3_TRSEN		(1 << 6)
-#define CPCFR3_CLKBP		(1 << 5)
-#define CPCFR3_CSYNCP		(1 << 4)
-#define CPCFR3_CSYNCL		(1 << 3)
+#define CPCFR3_DDLY		(1 << 7)	/* data delay: data bits start according to SYNC signal leading edge */
+#define CPCFR3_TRSEN		(1 << 6)	/* 3-state enable: data serial output state during nonvalid audio frames */
+#define CPCFR3_CLKBP		(1 << 5)	/* clock polarity */
+#define CPCFR3_CSYNCP		(1 << 4)	/* cp_sync(synchro) polarity */
+#define CPCFR3_CSYNCL		(1 << 3)	/* csync length */
 /* bit 2 reserved */
-#define CPCFR3_CSCLKD		(1 << 1)
-#define CPCFR3_CSYNCD		(1 << 0)
+#define CPCFR3_CSCLKD		(1 << 1)	/* cp_sclk port (serial clock) direction */
+#define CPCFR3_CSYNCD		(1 << 0)	/* cp_sync (synchro) direction */
 
 /* CPCFR4 */
-#define CPCFR4_ATSL(val)	((val & 0xf) << 4)
+#define CPCFR4_ATSL(val)	((val & 0xf) << 4)	/* audio time slots for secondary communication address and data values */
 #define CPCFR4_ATSL_BITS	(0xf << 4)
-#define CPCFR4_CLKS		(1 << 3)
-#define CPCFR4_DIVB(val)	((val & 0x7) << 0)
+#define CPCFR4_CLKS		(1 << 3)		/* clock source */
+#define CPCFR4_DIVB(val)	((val & 0x7) << 0)	/* cp_sclk driver value */
 #define CPCFR4_DIVB_BITS	(0x7 << 0)
 
 /* AGCFR */
-#define AGCFR_MN_ST		(1 << 10)
-#define AGCFR_B8_16		(1 << 9)
-#define AGCFR_LI_BI		(1 << 8)
-#define AGCFR_FSINT(val)	((val & 0x3) << 6)
+#define AGCFR_MN_ST		(1 << 10)	/* mono/stereo audio file */
+#define AGCFR_B8_16		(1 << 9)	/* 8 bits/16 bits audio file */
+#define AGCFR_LI_BI		(1 << 8)	/* audio file endianism */
+#define AGCFR_FSINT(val)	((val & 0x3) << 6) /* intermediate sample frequency for DMA read and write operations */
 #define AGCFR_FINST_BITS	(0x3 << 6)
 
-#define AGCFR_FSINT_8000	(0)
-#define AGCFR_FSINT_11025	(1)
-#define AGCFR_FSINT_22050	(2)
-#define AGCFR_FSINT_44100	(3)
+#define AGCFR_FSINT_8000	(0)		/* 8000  Hz */
+#define AGCFR_FSINT_11025	(1)		/* 11025 Hz */
+#define AGCFR_FSINT_22050	(2)		/* 22050 Hz */
+#define AGCFR_FSINT_44100	(3)		/* 44100 Hz */
 
-#define AGCFR_AUD_CKSRC(val)((val & 0x3) << 4)
+#define AGCFR_AUD_CKSRC(val)((val & 0x3) << 4)	/* audio processing clock source */
 #define AGCFR_AUD_CKSRC_BITS	(0x3 << 4)
-#define AGCFR_M_CKSRC		(1 << 3)
+#define AGCFR_M_CKSRC		(1 << 3)	/* modem interface clock source */
 #define AGCFR_MCLK_OUT		(1 << 1)
 #define AGCFR_MCLK		(1 << 0)
 
 
 /* AGCTR */
-#define AGCTR_AUDRD		(1 << 15)
-#define AGCTR_AUDRDI		(1 << 14)
-#define AGCTR_AUDRDIEN		(1 << 13)
-#define AGCTR_DMAREN		(1 << 12)
-#define AGCTR_DMAWEN		(1 << 11)
+#define AGCTR_AUDRD		(1 << 15)	/* audio ready */
+#define AGCTR_AUDRDI		(1 << 14)	/* audio ready interrupt status */
+#define AGCTR_AUDRDIEN		(1 << 13)	/* audio ready interrupt enable */
+#define AGCTR_DMAREN		(1 << 12)	/* audio files play operation */
+#define AGCTR_DMAWEN		(1 << 11)	/* audio file record operation */
 /* bits 10:4 reserved */
-#define AGCTR_MCLK_EN		(1 << 3)
-#define AGCTR_OSCMCLK_EN	(1 << 2)
-#define AGCTR_AUDEN		(1 << 1)
-#define AGCTR_EACPWD		(1 << 0)
+#define AGCTR_MCLK_EN		(1 << 3)	/* internal MCLK enable */
+#define AGCTR_OSCMCLK_EN	(1 << 2)	/* OSCMCLK_EN output for MCLK oscillator control */
+#define AGCTR_AUDEN		(1 << 1)	/* audio processing enable/disable */
+#define AGCTR_EACPWD		(1 << 0)	/* EAC operation */
 
 /* AGCFR2 */
-#define AGCFR2_BT_MD_WIDEBAND	(1 << 5)
-#define AGCFR2_MCLK_I2S_N11M_12M (1 << 4)
-#define AGCFR2_I2S_N44K_48K	(1 << 3)
-#define AGCFR2_FSINT2(val)	((val & 0x7) << 0)
+#define AGCFR2_BT_MD_WIDEBAND	(1 << 5)	/* the BT device and modem AuSPIs wide-band mode */
+#define AGCFR2_MCLK_I2S_N11M_12M (1 << 4)	/* MCLK freq indicator for audio operations */
+#define AGCFR2_I2S_N44K_48K	(1 << 3)	/* Frame sample frecuency of I2S codec port, does not generate value */
+#define AGCFR2_FSINT2(val)	((val & 0x7) << 0) /* intermediate sample frequency for DMA channel read and write operations */
 #define AGCFR2_FSINT2_BITS	(0x7 << 0)
 
-#define AGCFR2_FSINT2_8000	(0)
-#define AGCFR2_FSINT2_11025	(1)
-#define AGCFR2_FSINT2_22050	(2)
-#define AGCFR2_FSINT2_44100	(3)
-#define AGCFR2_FSINT2_48000	(4)
-#define AGCFR2_FSINT2_FSINT	(7)
+#define AGCFR2_FSINT2_8000	(0)		/* 8000  Hz */
+#define AGCFR2_FSINT2_11025	(1)		/* 11025 Hz */
+#define AGCFR2_FSINT2_22050	(2)		/* 22050 Hz */
+#define AGCFR2_FSINT2_44100	(3)		/* 44100 Hz */
+#define AGCFR2_FSINT2_48000	(4)		/* 48000 Hz */
+#define AGCFR2_FSINT2_FSINT	(7)		/* based on AGCFR/FSINT */
 
 
 /* AGCFR3 */
-#define AGCFR3_CP_TR_DMA	(1 << 15)
-#define AGCFR3_BT_TR_DMA	(1 << 14)
-#define AGCFR3_MD_TR_DMA	(1 << 13)
-#define AGCFR3_FSINT(val)	((val & 0xf) << 9)
+#define AGCFR3_CP_TR_DMA	(1 << 15)	/* codec port transparent DMA (to audio DMAs) */
+#define AGCFR3_BT_TR_DMA	(1 << 14)	/* BT transparent DMA (to BT UL write & DL read DMAs */     
+#define AGCFR3_MD_TR_DMA	(1 << 13)	/* modem transparent DMA (to modem UL write and DL read DMAs) */
+#define AGCFR3_FSINT(val)	((val & 0xf) << 9) /* FSINT */
 #define AGCFR3_FSINT_BITS	(0xf << 9)
 
-#define AGCFR3_FSINT_8000	(0)
-#define AGCFR3_FSINT_11025	(1)
-#define AGCFR3_FSINT_16000	(2)
-#define AGCFR3_FSINT_22050	(3)
-#define AGCFR3_FSINT_24000	(4)
-#define AGCFR3_FSINT_32000	(5)
-#define AGCFR3_FSINT_44100	(6)
-#define AGCFR3_FSINT_48000	(7)
-#define AGCFR3_FSINT_FSINT	(15)
+#define AGCFR3_FSINT_8000	(0)		/* 8000  Hz */
+#define AGCFR3_FSINT_11025	(1)		/* 11025 Hz */
+#define AGCFR3_FSINT_16000	(2)		/* 16000 Hz */
+#define AGCFR3_FSINT_22050	(3)		/* 22050 Hz */
+#define AGCFR3_FSINT_24000	(4)		/* 24000 Hz */
+#define AGCFR3_FSINT_32000	(5)		/* 32000 Hz */
+#define AGCFR3_FSINT_44100	(6)		/* 44100 Hz */
+#define AGCFR3_FSINT_48000	(7)		/* 48000 Hz */
+#define AGCFR3_FSINT_FSINT	(15)		/* based on AGCFR2/AGCFR */
 
 
-#define AGCFR3_BT_CKSRC(val)	((val & 0x3) << 7)
+#define AGCFR3_BT_CKSRC(val)	((val & 0x3) << 7)	/* BT port clock selection */
 #define AGCFR3_BT_CKSRC_BITS	(0x3 << 7)
-#define AGCFR3_MD_CKSRC(val)	((val & 0x3) << 5)
+#define AGCFR3_MD_CKSRC(val)	((val & 0x3) << 5)	/* modem port clock source */
 #define AGCFR3_MD_CKSRC_BITS	(0x3 << 5)
-#define AGCFR3_AUD_CKSRC(val)	((val & 0x7) << 2)
+#define AGCFR3_AUD_CKSRC(val)	((val & 0x7) << 2)	/* audio and codec port clock source */
 #define AGCFR3_AUD_CKSRC_BITS	(0x7 << 2)
-#define AGCFR3_CLK12MINT_SEL	(1 << 1)
-#define AGCFR3_MCLKINT_SEL	(1 << 0)
+#define AGCFR3_CLK12MINT_SEL	(1 << 1)		/* internal 12MHz clock source */
+#define AGCFR3_MCLKINT_SEL	(1 << 0)		/* internal codec master clock source */
 
 /* AMSCFR */
-#define AMSCFR_K12		(1 << 11)
+#define AMSCFR_K12		(1 << 11)		/* K12 switch open/close */
 #define AMSCFR_K11		(1 << 10)
 #define AMSCFR_K10		(1 << 9)
 #define AMSCFR_K9		(1 << 8)
@@ -221,35 +221,35 @@
 
 /* AMVCTR */
 #define AMVCTR_GWO_BITS		(0xff << 8)
-#define AMVCTR_GWO(val)		((val & 0xff) << 8)
+#define AMVCTR_GWO(val)		((val & 0xff) << 8)	/* Gain on write DMA operation */
 #define AMVCTR_GRO_BITS		(0xff << 0)
-#define AMVCTR_GRO(val)		((val & 0xff) << 0)
+#define AMVCTR_GRO(val)		((val & 0xff) << 0)	/* Gain on read DMA operation */
 
 /* AM1VCTR */
-#define AM1VCTR_MUTE		(1 << 15)
-#define AM1VCTR_GINB(val)	((val & 0x7f) << 8)
+#define AM1VCTR_MUTE		(1 << 15)		/* mute/no mute on mixer output */
+#define AM1VCTR_GINB(val)	((val & 0x7f) << 8)	/* gain on input B */
 #define AM1VCTR_GINB_BITS	(0x7f << 8)
-#define AM1VCTR_GINA(val)	((val & 0x7f) << 0)
+#define AM1VCTR_GINA(val)	((val & 0x7f) << 0)	/* gain on input A */
 #define AM1VCTR_GINA_BITS	(0x7f << 0)
 
 /* AM2VCTR */
-#define AM2VCTR_MUTE		(1 << 15)
-#define AM2VCTR_GINB(val)	((val & 0x7f) << 8)
+#define AM2VCTR_MUTE		(1 << 15)		/* mute/no mute on mixer output */
+#define AM2VCTR_GINB(val)	((val & 0x7f) << 8)	/* gain on input B */
 #define AM2VCTR_GINB_BITS	(0x7f << 8)
-#define AM2VCTR_GINA(val)	((val & 0x7f) << 0)
+#define AM2VCTR_GINA(val)	((val & 0x7f) << 0)	/* gain on input A */
 #define AM2VCTR_GINA_BITS	(0x7f << 0)
 
 /* AM3VCTR */
-#define AM3VCTR_MUTE		(1 << 15)
-#define AM3VCTR_GINB(val)	((val & 0x7f) << 8)
+#define AM3VCTR_MUTE		(1 << 15)		/* mute/no mute */
+#define AM3VCTR_GINB(val)	((val & 0x7f) << 8)	/* gain on input B */
 #define AM3VCTR_GINB_BITS	(0x7f << 8)
-#define AM3VCTR_GINA(val)	((val & 0x7f) << 0)
+#define AM3VCTR_GINA(val)	((val & 0x7f) << 0)	/* gain on input A */
 #define AM3VCTR_GINA_BITS	(0x7f << 0)
 
 /* ASTCTR */
-#define ASTCTR_ATT(val)		((val & 0x7f) << 1)
+#define ASTCTR_ATT(val)		((val & 0x7f) << 1)	/* Attenuation of side tone */
 #define ASTCTR_ATT_BITS		(0x7f << 1)
-#define ASTCTR_ATTEN		(1 << 0)
+#define ASTCTR_ATTEN		(1 << 0)		/* side tone enabled/disabled */
 
 
 /* internal structure of the EAC driver */
-- 
1.4.4.4
