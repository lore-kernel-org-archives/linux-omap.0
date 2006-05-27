From: Imre Deak <imre.deak@nokia.com>
Subject: ARM: OMAP: omap_uwire: use arm_xor clock as functional clock
Date: Sat, 27 May 2006 22:49:02 +0300
Message-ID: <1148759342.7041.5.camel@mammoth.research.nokia.com>
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

- the uwire module uses the arm_xor as functional clock, not the arm_per clock
- fix word size sanity check

Signed-off-by: Imre Deak <imre.deak@nokia.com>

diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
index 3aa3890..78fe97f 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -334,9 +334,8 @@ static int uwire_setup_transfer(struct s
 	if (!bits)
 		bits = 8;
 
-	if (spi->bits_per_word > 16) {
-		pr_debug("%s: wordsize %d?\n", spi->dev.bus_id,
-				spi->bits_per_word);
+	if (bits > 16) {
+		pr_debug("%s: wordsize %d?\n", spi->dev.bus_id, bits);
 		status = -ENODEV;
 		goto done;
 	}
@@ -371,12 +370,12 @@ static int uwire_setup_transfer(struct s
 		hz = t->speed_hz;
 
 	if (!hz) {
-		pr_debug("%s: zero speed?\n", spi->dev.bus_id, hz);
+		pr_debug("%s: zero speed?\n", spi->dev.bus_id);
 		status = -EINVAL;
 		goto done;
 	}
 
-	/* F_INT = mpu_per_clk / DIV1 */
+	/* F_INT = mpu_xor_clk / DIV1 */
 	for (div1_idx = 0; div1_idx < 4; div1_idx++) {
 		switch (div1_idx) {
 		case 0:
@@ -433,7 +432,7 @@ static int uwire_setup_transfer(struct s
 		break;
 	}
 	omap_uwire_configure_mode(spi->chip_select, flags);
-	pr_debug("%s: uwire flags %02x, armper %lu KHz, SCK %lu KHz\n",
+	pr_debug("%s: uwire flags %02x, armxor %lu KHz, SCK %lu KHz\n",
 			__FUNCTION__, flags,
 			clk_get_rate(uwire->ck) / 1000,
 			rate / 1000);
@@ -482,9 +481,9 @@ static int uwire_probe(struct platform_d
 	uwire = spi_master_get_devdata(master);
 	dev_set_drvdata(&pdev->dev, uwire);
 
-	uwire->ck = clk_get(&pdev->dev, "armper_ck");
+	uwire->ck = clk_get(&pdev->dev, "armxor_ck");
 	if (!uwire->ck || IS_ERR(uwire->ck)) {
-		dev_dbg(&pdev->dev, "no mpu_per_clk ?\n");
+		dev_dbg(&pdev->dev, "no mpu_xor_clk ?\n");
 		spi_master_put(master);
 		return -ENODEV;
 	}
