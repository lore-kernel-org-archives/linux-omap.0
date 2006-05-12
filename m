From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] omap_uwire: use the per transfer wordsize and speed
	overrides
Date: Fri, 12 May 2006 14:40:51 +0300
Message-ID: <1147434051.9837.22.camel@mammoth.research.nokia.com>
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
Add a uwire_setup_transfer to handle this.

Allocate a per SPI device controller state struct, where we cache the
current bits_per_word and the functional clock divider. The latter cannot
be set for each CS in HW, so we have to reset it whenever a new device is
selected.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

---

 drivers/spi/omap_uwire.c |   82 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 69 insertions(+), 13 deletions(-)

169e44d96147a56e5a0fe1214f07a7a973f99cec
diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
index 39e8227..6851eec 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -94,6 +94,11 @@ struct uwire_spi {
 	struct clk		*ck;
 };
 
+struct uwire_state {
+	unsigned	bits_per_word;
+	unsigned	div1_idx;
+};
+
 /* REVISIT compile time constant for idx_shift? */
 static unsigned int uwire_idx_shift;
 
@@ -153,11 +158,23 @@ static int wait_uwire_csr_flag(u16 mask,
 	return 0;
 }
 
+static void uwire_set_clk1_div(int div1_idx)
+{
+	u16 w;
+
+	w = uwire_read_reg(UWIRE_SR3);
+	w &= ~(0x03 << 1);
+	w |= div1_idx << 1;
+	uwire_write_reg(UWIRE_SR3, w);
+}
+
 static void uwire_chipselect(struct spi_device *spi, int value)
 {
+	struct	uwire_state *ust = spi->controller_state;
 	u16	w;
 	int	old_cs;
 
+
 	BUG_ON(wait_uwire_csr_flag(CSRB, 0, 0));
 
 	w = uwire_read_reg(UWIRE_CSR);
@@ -169,6 +186,7 @@ static void uwire_chipselect(struct spi_
 	}
 	/* activate specfied chipselect */
 	if (value == BITBANG_CS_ACTIVE) {
+		uwire_set_clk1_div(ust->div1_idx);
 		/* invert clock? */
 		if (spi->mode & SPI_CPOL)
 			uwire_write_reg(UWIRE_SR4, 1);
@@ -183,8 +201,9 @@ static void uwire_chipselect(struct spi_
 
 static int uwire_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
+	struct uwire_state *ust = spi->controller_state;
 	unsigned	len = t->len;
-	unsigned	bits = spi->bits_per_word;
+	unsigned	bits = ust->bits_per_word;
 	unsigned	bytes;
 	u16		val, w;
 	int		status = 0;;
@@ -196,9 +215,6 @@ static int uwire_txrx(struct spi_device 
 	if (t->tx_buf && t->rx_buf)
 		return -EPERM;
 
-	if (!bits)
-		bits = 8;
-
 	w = spi->chip_select << 10;
 	w |= CS_CMD;
 
@@ -291,15 +307,17 @@ eio:
 	return -EIO;
 }
 
-static int uwire_setup(struct spi_device *spi)
+static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
+	struct uwire_state	*ust = spi->controller_state;
 	struct uwire_spi	*uwire;
 	unsigned		flags = 0;
+	unsigned		bits;
+	unsigned		hz;
 	unsigned long		rate;
 	int			div1_idx;
 	int			div1;
 	int			div2;
-	u16			w;
 	int			status;
 
 	uwire = spi_master_get_devdata(spi->master);
@@ -310,12 +328,19 @@ static int uwire_setup(struct spi_device
 		goto done;
 	}
 
+	bits = spi->bits_per_word;
+	if (t != NULL && t->bits_per_word)
+		bits = t->bits_per_word;
+	if (!bits)
+		bits = 8;
+
 	if (spi->bits_per_word > 16) {
 		pr_debug("%s: wordsize %d?\n", spi->dev.bus_id,
 				spi->bits_per_word);
 		status = -ENODEV;
 		goto done;
 	}
+	ust->bits_per_word = bits;
 
 	/* mode 0..3, clock inverted separately;
 	 * standard nCS signaling;
@@ -341,6 +366,16 @@ static int uwire_setup(struct spi_device
 	/* assume it's already enabled */
 	rate = clk_get_rate(uwire->ck);
 
+	hz = spi->max_speed_hz;
+	if (t != NULL && t->speed_hz)
+		hz = t->speed_hz;
+
+	if (!hz) {
+		pr_debug("%s: zero speed?\n", spi->dev.bus_id, hz);
+		status = -EINVAL;
+		goto done;
+	}
+
 	/* F_INT = mpu_per_clk / DIV1 */
 	for (div1_idx = 0; div1_idx < 4; div1_idx++) {
 		switch (div1_idx) {
@@ -358,22 +393,22 @@ static int uwire_setup(struct spi_device
 			div1 = 10;
 			break;
 		}
-		div2 = (rate / div1 + spi->max_speed_hz - 1) /
-			spi->max_speed_hz;
+		div2 = (rate / div1 + hz - 1) / hz;
 		if (div2 <= 8)
 			break;
 	}
 	if (div1_idx == 4) {
 		pr_debug("%s: lowest clock %ld, need %d\n",
-			spi->dev.bus_id, rate / 10 / 8, spi->max_speed_hz);
+			spi->dev.bus_id, rate / 10 / 8, hz);
 			status = -EDOM;
 			goto done;
 	}
 
-	w = uwire_read_reg(UWIRE_SR3);
-	w &= ~(0x03 << 1);
-	w |= div1_idx << 1;
-	uwire_write_reg(UWIRE_SR3, w);
+	/* we have to cache this and reset in uwire_chipselect as this is a
+	 * global parameter and another uwire device can change it under
+	 * us */
+	ust->div1_idx = div1_idx;
+	uwire_set_clk1_div(div1_idx);
 
 	rate /= div1;
 
@@ -407,6 +442,25 @@ done:
 	return status;
 }
 
+static int uwire_setup(struct spi_device *spi)
+{
+	struct uwire_state *ust = spi->controller_state;
+
+	if (ust == NULL) {
+		ust = kzalloc(sizeof(*ust), SLAB_KERNEL);
+		if (ust == NULL)
+			return -ENOMEM;
+		spi->controller_state = ust;
+	}
+
+	return uwire_setup_transfer(spi, NULL);
+}
+
+static void uwire_cleanup(const struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
 static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
@@ -446,9 +500,11 @@ static int uwire_probe(struct platform_d
 	master->bus_num = 2;	/* "official" */
 	master->num_chipselect = 4;
 	master->setup = uwire_setup;
+	master->cleanup = uwire_cleanup;
 
 	uwire->bitbang.master = master;
 	uwire->bitbang.chipselect = uwire_chipselect;
+	uwire->bitbang.setup_transfer = uwire_setup_transfer;
 	uwire->bitbang.txrx_bufs = uwire_txrx;
 
 	status = spi_bitbang_start(&uwire->bitbang);
-- 
1.2.3.g90cc1-dirty
