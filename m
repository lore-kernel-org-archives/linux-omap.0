From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [04/17 PATCH] MMC: OMAP: Fix the data timeout calculation for MMC
 multislot support.
Date: Fri, 17 Aug 2007 15:01:45 -0400
Message-ID: <46C5F099.4000901@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070700020809060502000800"
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
To: Tony Lindgren <tony@atomide.com>, omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070700020809060502000800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Juha Yrjola <juha.yrjola@solidboot.com>

Fix the data timeout calculation for MMC multislot support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>

--------------070700020809060502000800
Content-Type: text/plain;
 name="0004-MMC-OMAP-Fix-timeout-calculation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0004-MMC-OMAP-Fix-timeout-calculation.diff"

Fix the data timeout calculation for MMC multislot support

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Index: linux-omap/drivers/mmc/host/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/host/omap.c	2007-08-16 12:33:02.000000000 -0400
+++ linux-omap/drivers/mmc/host/omap.c	2007-08-16 12:33:05.000000000 -0400
@@ -875,13 +875,12 @@ static inline void set_cmd_timeout(struc
 
 static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_request *req)
 {
-	int timeout;
+	unsigned int timeout, cycle_ns;
 	u16 reg;
 
-	/* Convert ns to clock cycles by assuming 20MHz frequency
-	 * 1 cycle at 20MHz = 500 ns
-	 */
-	timeout = req->data->timeout_clks + req->data->timeout_ns / 500;
+	cycle_ns = 1000000000 / host->current_slot->fclk_freq;
+	timeout = req->data->timeout_ns / cycle_ns;
+	timeout += req->data->timeout_clks;
 
 	/* Check if we need to use timeout multiplier register */
 	reg = OMAP_MMC_READ(host, SDIO);
@@ -1051,7 +1050,8 @@ static void mmc_omap_power(struct mmc_om
 
 static int mmc_omap_calc_divisor(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct mmc_omap_slot *slot = mmc_priv(mmc);
+	struct mmc_omap_host *host = slot->host;
 	int func_clk_rate = clk_get_rate(host->fclk);
 	int dsor;
 
@@ -1068,6 +1068,8 @@ static int mmc_omap_calc_divisor(struct 
 	if (dsor > 250)
 		dsor = 250;
 
+	slot->fclk_freq = func_clk_rate / dsor;
+
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		dsor |= 1 << 15;
 

--------------070700020809060502000800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070700020809060502000800--
