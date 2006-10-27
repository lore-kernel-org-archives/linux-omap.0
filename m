From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: [PATCH]: Fixing blksz_bits calling inside drivers/mmc/mmc.c and
	drivers/mmc/omap.c
Date: Fri, 27 Oct 2006 11:13:13 -0400
Message-ID: <45422209.3090602@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010703060805000302060208"
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
To: "Lindgren Tony (EXT-Atomide/Helsinki)" <ext-Tony.Lindgren@nokia.com>, Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703060805000302060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This small patch solves the problem ;-)

Here's the error dump:
drivers/mmc/omap.c: In function 'mmc_omap_prepare_dma':
drivers/mmc/omap.c:636: error: 'struct mmc_data' has no member named 
'blksz_bits'
drivers/mmc/omap.c:639: error: 'struct mmc_data' has no member named 
'blksz_bits'
drivers/mmc/omap.c: In function 'mmc_omap_prepare_data':
drivers/mmc/omap.c:828: error: 'struct mmc_data' has no member named 
'blksz_bits'

Obs: The same occurs for drivers/mmc/mmc.c file

-- 
Regards,

Felipe Balbi
ext-felipe.lima@nokia.com
OSMRC


--------------010703060805000302060208
Content-Type: text/x-patch;
 name="patch-mmc.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mmc.c.diff"

Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2006-10-27 09:18:34.000000000 -0400
+++ linux-omap/drivers/mmc/omap.c	2006-10-27 11:03:14.000000000 -0400
@@ -633,10 +633,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
 	int sync_dev = 0;
 
 	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
-	frame = 1 << data->blksz_bits;
+	frame = 1 << data->blksz;
 	count = sg_dma_len(sg);
 
-	if ((data->blocks == 1) && (count > (1 << data->blksz_bits)))
+	if ((data->blocks == 1) && (count > (1 << data->blksz)))
 		count = frame;
 
 	host->dma_len = count;
@@ -825,7 +825,7 @@ mmc_omap_prepare_data(struct mmc_omap_ho
 	}
 
 
-	block_size = 1 << data->blksz_bits;
+	block_size = 1 << data->blksz;
 
 	OMAP_MMC_WRITE(host, NBLK, data->blocks - 1);
 	OMAP_MMC_WRITE(host, BLEN, block_size - 1);

--- linux-omap/drivers/mmc/mmc.c	2006-10-26 06:42:31.000000000 -0400
+++ linux-omap-dev/drivers/mmc/mmc.c	2006-10-26 09:53:24.000000000 -0400
@@ -996,7 +996,7 @@
 
 		mmc_set_data_timeout(&data, card, 0);
 
-		data.blksz = 1 << 3;
+		data.blksz_bits = 1 << 3;
 		data.blocks = 1;
 		data.flags = MMC_DATA_READ;
 		data.sg = &sg;


--------------010703060805000302060208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010703060805000302060208--
