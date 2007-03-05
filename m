From: Imre Deak <imre.deak@solidboot.com>
Subject: [PATCH 4/4] FB: sync with N800 tree (fix RFBI frequency lookup in
	tearing sync setup)
Date: Mon, 5 Mar 2007 14:17:47 +0200
Message-ID: <20070305121745.GD4435@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Different DPLL multiplier / divider pairs can result in frequencies
that are not exact matches of the values given by TI. When looking up
the table of known L4 / DSS1 values allow for a small difference.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/video/omap/rfbi.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index 917f616..05164ca 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -213,8 +213,11 @@ static unsigned long rfbi_get_max_tx_rate(void)
 	dss1_rate = clk_get_rate(rfbi.dss1_fck) / 1000000;
 
 	for (i = 0; i < ARRAY_SIZE(ftab); i++) {
-		if (ftab[i].l4_clk == l4_rate &&
-		    ftab[i].dss1_clk == dss1_rate) {
+		/* Use a window instead of an exact match, to account
+		 * for different DPLL multiplier / divider pairs.
+		 */
+		if (abs(ftab[i].l4_clk - l4_rate) < 3 &&
+		    abs(ftab[i].dss1_clk - dss1_rate) < 3) {
 			min_l4_ticks = ftab[i].min_l4_ticks;
 			break;
 		}
-- 
1.4.4.3.GIT
