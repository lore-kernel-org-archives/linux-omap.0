From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] memory: omap-gpmc: Fix debug output for access width
Date: Fri,  5 May 2017 15:37:06 -0700
Message-ID: <20170505223706.4913-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The width needs to be configured in bytes with 1 meaning 8-bit
access and 2 meaning 16-bit access.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -513,7 +513,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	pr_info("gpmc cs%i access configuration:\n", cs);
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
-	GPMC_GET_RAW_MAX(GPMC_CS_CONFIG1, 12, 13,
+	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 12, 13, 1,
 			 GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
-- 
2.12.2
