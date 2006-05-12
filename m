From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ARM: OMAP: omap2_mcspi: use the per transfer wordsize and
	speed overrides
Date: Fri, 12 May 2006 18:56:15 +0300
Message-ID: <1147449375.9837.67.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Each transfer in an SPI message can have its wordsize and speed override.
Add a omap2_mcspi_setup_transfer to handle this.

Interpret spi->bits_per_word == 0 as a default wordsize of 8.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 7e06358..903481c 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -92,6 +92,7 @@ struct omap2_mcspi {
 
 struct omap2_mcspi_cs {
 	u8 transmit_mode;
+	int word_len;
 };
 
 #define MOD_REG_BIT(val, mask, set) do { \
@@ -168,12 +169,15 @@ static void omap2_mcspi_set_master_mode(
 
 static void omap2_mcspi_txrx(struct spi_device *spi, struct spi_transfer *xfer)
 {
+	struct omap2_mcspi_cs *cs = spi->controller_state;
 	unsigned int		count, c;
 	u32                     l;
 	unsigned long		base, tx_reg, rx_reg, chstat_reg;
+	int			word_len;
 
 	count = xfer->len;
 	c = count;
+	word_len = cs->word_len;
 
 	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
 	l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
@@ -196,7 +200,7 @@ static void omap2_mcspi_txrx(struct spi_
 	if (xfer->tx_buf == NULL)
 		__raw_writel(0, tx_reg);
 
-	if (spi->bits_per_word <= 8) {
+	if (word_len <= 8) {
 		u8		*rx;
 		const u8	*tx;
 
@@ -215,7 +219,7 @@ static void omap2_mcspi_txrx(struct spi_
 				*rx++ = __raw_readl(rx_reg);
 			}
 		}
-	} else if (spi->bits_per_word <= 16) {
+	} else if (word_len <= 16) {
 		u16		*rx;
 		const u16	*tx;
 
@@ -234,7 +238,7 @@ static void omap2_mcspi_txrx(struct spi_
 				*rx++ = __raw_readl(rx_reg);
 			}
 		}
-	} else if (spi->bits_per_word <= 32) {
+	} else if (word_len <= 32) {
 		u32		*rx;
 		const u32	*tx;
 
@@ -262,25 +266,22 @@ static void omap2_mcspi_txrx(struct spi_
 	}
 }
 
-static int omap2_mcspi_setup(struct spi_device *spi)
+static int omap2_mcspi_setup_transfer(struct spi_device *spi,
+				      struct spi_transfer *t)
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi_device_config *conf;
 	u32 l = 0, div = 0;
 	u8 word_len = spi->bits_per_word;
 
+	if (t != NULL && t->bits_per_word)
+		word_len = t->bits_per_word;
 	if (!word_len)
-		return 0;
-
-	if (!cs) {
-		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
-		if (!cs)
-			return -ENOMEM;
-		spi->controller_state = cs;
-	}
+		word_len = 8;
 
 	if (spi->bits_per_word > 32)
 		return -EINVAL;
+	cs->word_len = word_len;
 
 	conf = (struct omap2_mcspi_device_config *) spi->controller_data;
 
@@ -327,6 +328,20 @@ static int omap2_mcspi_setup(struct spi_
 	return 0;
 }
 
+static int omap2_mcspi_setup(struct spi_device *spi)
+{
+	struct omap2_mcspi_cs *cs = spi->controller_state;
+
+	if (!cs) {
+		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+
+	return omap2_mcspi_setup_transfer(spi, NULL);
+}
+
 static void omap2_mcspi_cleanup(const struct spi_device *spi)
 {
 	if (spi->controller_state != NULL)
@@ -347,6 +362,7 @@ static void omap2_mcspi_work(unsigned lo
 		int				cs_active = 0;
 		struct omap2_mcspi_device_config *conf;
 		struct omap2_mcspi_cs		*cs;
+		int				par_override = 0;
 		int status = 0;
 
 		m = container_of(mcspi->msg_queue.next, struct spi_message,
@@ -364,6 +380,14 @@ static void omap2_mcspi_work(unsigned lo
 				status = -EINVAL;
 				break;
 			}
+			if (par_override || t->speed_hz || t->bits_per_word) {
+				par_override = 1;
+				status = omap2_mcspi_setup_transfer(spi, t);
+				if (status < 0)
+					break;
+				if (!t->speed_hz && !t->bits_per_word)
+					par_override = 0;
+			}
 
 			if (!cs_active) {
 				omap2_mcspi_force_cs(spi, 1);
@@ -381,6 +405,12 @@ static void omap2_mcspi_work(unsigned lo
 			}
 		}
 
+		/* Restore defaults they are overriden */
+		if (par_override) {
+			par_override = 0;
+			status = omap2_mcspi_setup_transfer(spi, NULL);
+		}
+
 		if (cs_active)
 			omap2_mcspi_force_cs(spi, 0);
 
