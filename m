From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 03/17] MMC: OMAP: Fix timeout calculation for MMC multislot
 support
Date: Mon, 26 Nov 2007 12:01:13 -0400
Message-ID: <474AEDC9.2090707@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Juha Yrjola <juha.yrjola@solidboot.com>

Fix the data timeout calculation for MMC multislot support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 51b3bcb..be93ab4 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -882,13 +882,12 @@ static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_reques
 
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
-- 1.5.3.GIT
