From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ALSA: Fix OMAP24xx EAC codec port I2S master/slave
 support
Date: Wed, 4 Apr 2007 14:13:05 +0300
Message-ID: <20070404141305.555e4dd1.jarkko.nikula@nokia.com>
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

- Add explicit I2S master and slave modes
- Do not configure bit-clock and frame sync direction according to polarity
  changed I2S mode as it was done in programming model but according to
  master/slave mode
- Activate codec port transparent DMA only when EAC is I2S slave

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 include/asm-arm/arch-omap/eac.h |    8 ++++----
 sound/arm/omap/eac.c            |   27 +++++++++++++++++----------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/asm-arm/arch-omap/eac.h b/include/asm-arm/arch-omap/eac.h
index 5a4c831..6662cb0 100644
--- a/include/asm-arm/arch-omap/eac.h
+++ b/include/asm-arm/arch-omap/eac.h
@@ -48,14 +48,14 @@ enum eac_mclk_src {
 enum eac_codec_mode {
 	EAC_CODEC_PCM,
 	EAC_CODEC_AC97,
-	EAC_CODEC_I2S,
+	EAC_CODEC_I2S_MASTER, /* codec port, I.e. EAC is the master */
+	EAC_CODEC_I2S_SLAVE,
 };
 
 /* configuration structure for I2S mode */
 struct eac_i2s_conf {
-	/* it seems according to TRM that the polarity-changed I2S mode is not
-	 * only that frame sync polarity (EAC.AC_FS) is changed but also direction
-	 * of it and interface serial clock (EAC.AC_SCLK) */
+	/* if enabled, then first data slot (left channel) is signaled as
+	 * positive level of frame sync EAC.AC_FS */
 	unsigned	polarity_changed_mode:1;
 	/* if enabled, then serial data starts one clock cycle after the
 	 * of EAC.AC_FS for first audio slot */
diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index 51d50fc..c4bbf61 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -435,24 +435,29 @@ static int eac_configure_i2s(struct omap_eac *eac, struct eac_codec *conf)
 
 	/* configuration for normal I2S or polarity-changed I2S */
 	if (!conf->codec_conf.i2s.polarity_changed_mode) {
-		/* I2S */
 		cpcfr1 |= CPCFR1_MODE(4); /* I2S mode */
-		MOD_REG_BIT(cpcfr3, CPCFR3_CSCLKD, 0); /* CP_SCLK output */
-		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCD, 0); /* CP_SYNC output */
 		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCP, 0); /* CP_SYNC active low */
 		/* audio time slots configuration for I2S */
 		cpcfr4 |= CPCFR4_ATSL(0);
 	} else {
-		/* polarity changed I2S mode */
-		cpcfr1 |= CPCFR1_MODE(1); /* polarity changed I2S mode */
-		MOD_REG_BIT(cpcfr3, CPCFR3_CSCLKD, 1); /* CP_SCLK input */
-		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCD, 1); /* CP_SYNC input */
+		cpcfr1 |= CPCFR1_MODE(1); /* PCM mode/polarity-changed I2S */
 		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCP, 1); /* CP_SYNC active
 							  high */
 		/* audio time slots configuration for polarity-changed I2S */
 		cpcfr4 |= CPCFR4_ATSL(0xf);
 	};
 
+	/* master/slave configuration */
+	if (conf->codec_mode == EAC_CODEC_I2S_MASTER) {
+		/* EAC is master. Set CP_SCLK and CP_SYNC as outputs */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSCLKD, 0);
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCD, 0);
+	} else {
+		/* EAC is slave. Set CP_SCLK and CP_SYNC as inputs */
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSCLKD, 1);
+		MOD_REG_BIT(cpcfr3, CPCFR3_CSYNCD, 1);
+	}
+
 	eac_write_reg(eac, EAC_CPCFR1, cpcfr1);
 	eac_write_reg(eac, EAC_CPCFR2, cpcfr2);
 	eac_write_reg(eac, EAC_CPCFR3, cpcfr3);
@@ -528,11 +533,13 @@ static int eac_codec_port_init(struct omap_eac *eac, struct eac_codec *conf)
 	agcfr3 &= ~AGCFR3_FSINT_BITS;
 	agcfr3 |= AGCFR3_FSINT(eac_calc_agcfr3_fsint(conf->default_rate));
 
-	/* transparent DMA enable/disable bits
-	 * TODO: Are these needed? */
+	/* transparent DMA enable bits */
 	MOD_REG_BIT(agcfr3, AGCFR3_MD_TR_DMA, 1); /* modem */
 	MOD_REG_BIT(agcfr3, AGCFR3_BT_TR_DMA, 1); /* BT */
-	MOD_REG_BIT(agcfr3, AGCFR3_CP_TR_DMA, 0); /* codec port */
+	if (conf->codec_mode != EAC_CODEC_I2S_SLAVE)
+		MOD_REG_BIT(agcfr3, AGCFR3_CP_TR_DMA, 0);
+	else
+		MOD_REG_BIT(agcfr3, AGCFR3_CP_TR_DMA, 1);
 
 	/* step 4 (see TRM) */
 	eac_write_reg(eac, EAC_AGCFR3, agcfr3);
-- 
1.4.4.4
