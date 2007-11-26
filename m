From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 17/17] MMC: OMAP: Adds MMC basic support for Siemens SX1
Date: Mon, 26 Nov 2007 12:02:06 -0400
Message-ID: <474AEDFE.2030803@indt.org.br>
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

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Adds MMC basic support for Siemens SX1 mobile phone.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 drivers/mmc/host/omap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 97b123e..4c5d91a 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1093,6 +1093,9 @@ static void mmc_omap_set_power(struct mmc_omap_slot *slot, int power_on,
 		slot->pdata->set_power(mmc_dev(slot->mmc), slot->id, power_on,
 					vdd);
 
+	if (machine_is_sx1())
+		sx1_setmmcpower(power_on);
+
 	if (cpu_is_omap24xx()) {
 		u16 w;
 
-- 1.5.3.GIT
