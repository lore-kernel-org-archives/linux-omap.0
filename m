From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Thu, 8 Mar 2007 15:06:03 +0900
Message-ID: <005a01c76147$dd2d8a30$c7a3580a@swcenter.sec.samsung.co.kr>
References: <00e501c7608c$6ec71fe0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <00e501c7608c$6ec71fe0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, drzeus@drzeus.cx
List-Id: linux-omap@vger.kernel.org

Updated patch for recent MMC changes

- set max frequency 48000000 on OMAP2
- set HIGHSPEED feature for omap host
- add CONFIG_MMC_DEBUG

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index e72a7e8..daf73e0 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -415,6 +415,7 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int
write)
 	}
 }
 
+#ifdef CONFIG_MMC_DEBUG
 static inline void mmc_omap_report_irq(u16 status)
 {
 	static const char *mmc_omap_status_bits[] = {
@@ -431,6 +432,7 @@ static inline void mmc_omap_report_irq(u16 status)
 			c++;
 		}
 }
+#endif
 
 static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 {
@@ -1096,9 +1098,13 @@ static int __init mmc_omap_probe(struct
platform_device *pdev)
 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;
-	mmc->f_max = 24000000;
+	if (cpu_class_is_omap2())
+		mmc->f_max = 48000000;
+	else
+		mmc->f_max = 24000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
+	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK |
+		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
 
 	if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;
