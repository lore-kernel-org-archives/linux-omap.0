From: "Kyungmin Park" <kmpark@infradead.org>
Subject: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Wed, 7 Mar 2007 16:44:19 +0900
Message-ID: <00e501c7608c$6ec71fe0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
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

Hi

Here's performance results of MMC on OMAP2.
After patch we can good read performances on MoviNAND
Idea's from N800 code.

% Test Environment
Target: Apollon 
Kernel: 2.6.21-rc2-omap1 (latest: 07.03.07)
Filesystem: VFAT

# iozone -A -s 10m -U /mmc -f /mmc/test -e

* Before
% MMC (64MB)
               KB  reclen   write rewrite    read    reread
            10240       4    2418    2463     6393     6362
            10240       8    2391    2463     6362     6393
            10240      16    2396    2463     6362     6362
            10240      32    2348    2418     6393     6393
            10240      64    2365    2404     6331     6331
            10240     128    2365    2409     6040     6040
            10240     256    2348    2413     6068     6040

% MoviNAND (4GB)
              KB  reclen   write rewrite    read    reread
            10240       4    2328    2206     6619     6687
            10240       8    2332    2206     6687     6687
            10240      16    2332    2206     6687     6687
            10240      32    2323    2336     6721     6721
            10240      64    2177    2323     6553     6553
            10240     128    2177    2319     6393     6362
            10240     256    2180    2323     6362     6393

* After patch
mmc0: selected 48.000MHz transfer rate
mmc0: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2
% MMC (64MB) (Note: The result is similar since current MMC card supports
only 24MHz.)

            KB  reclen   write rewrite    read    reread
           10240       4    2501    2585     6425     6456
           10240       8    2418    2520     6393     6425
           10240      16    2409    2487     6393     6425
           10240      32    2391    2473     6425     6425
           10240      64    2391    2463     6331     6362
           10240     128    2383    2427     6068     6068
           10240     256    2391    2422     6096     6096

% MoviNAND (4GB)
           KB  reclen   write rewrite    read    reread
           10240       4    3034    2605     7201     8856
           10240       8    2616    2468     9039     8916
           10240      16    2600    2642     9102     8916
           10240      32    2422    2600     8977     8916
           10240      64    2409    2580     8977     8738
           10240     128    2404    2580     8456     8456
           10240     256    2409    2585     8402     8456

The interesting thing is why N800 mmc is too slow?

* target: N800
Same test program

Original
               KB  reclen   write rewrite    read    reread
            10240       4     341     338     1418     1425
            10240       8     343     343     1420     1427
            10240      16     342     342     1416     1426
            10240      32     341     345     1419     1427
            10240      64     342     345     1416     1427
            10240     128     342     343     1375     1385
            10240     256     344     345     1378     1381
 
After HS-MMC and multiblock write enable

               KB  reclen   write rewrite    read    reread
            10240       4    1896    1848     2765     2774
            10240       8    1971    2004     2789     2781
            10240      16    1970    2002     2757     2779
            10240      32    1844    1874     2760     2791
            10240      64    1896    1924     2747     2789
            10240     128    1902    1929     2607     2635
            10240     256    1896    1945     2628     2631

Thank you,
Kyungmin Park

ARM: OMAP: MMC performance upgrade on OMAP2

- set max frequency 48000000 on OMAP2
- Add CONFIG_MMC_DEBUG

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index e72a7e8..93ec7fa 100644
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
@@ -1096,7 +1098,10 @@ static int __init mmc_omap_probe(struct
platform_device *pdev)
 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;
-	mmc->f_max = 24000000;
+	if (cpu_class_is_omap2())
+		mmc->f_max = 48000000;
+	else
+		mmc->f_max = 24000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
