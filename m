From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH] Replace data->blksz_bits member by data->blksz in omap.c
Date: Mon, 30 Oct 2006 10:25:33 -0400
Message-ID: <45460B5D.8040200@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080301060409060102010008"
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
To: linux-omap-open-source@linux.omap.com, tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080301060409060102010008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Tony and folks,

This patch replace data->blksz_bits member by data->blksz in omap.c
file. data->blksz_bits
member is unused now.

This is need in order to align omap.c code from Linux-OMAP with mainline.

BR,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------080301060409060102010008
Content-Type: text/plain;
 name="mmc_omap_replace_member.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_replace_member.diff"

Replace data->blksz_bits by data->blksz. data->blksz_bits member is unused now.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-git/drivers/mmc/omap.c
===================================================================
--- linux-omap-git.orig/drivers/mmc/omap.c	2006-10-30 09:36:23.000000000 -0400
+++ linux-omap-git/drivers/mmc/omap.c	2006-10-30 10:11:29.000000000 -0400
@@ -633,10 +633,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
 	int sync_dev = 0;
 
 	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
-	frame = 1 << data->blksz_bits;
+	frame = data->blksz;
 	count = sg_dma_len(sg);
 
-	if ((data->blocks == 1) && (count > (1 << data->blksz_bits)))
+	if ((data->blocks == 1) && (count > data->blksz))
 		count = frame;
 
 	host->dma_len = count;
@@ -824,8 +824,7 @@ mmc_omap_prepare_data(struct mmc_omap_ho
 		return;
 	}
 
-
-	block_size = 1 << data->blksz_bits;
+	block_size = data->blksz;
 
 	OMAP_MMC_WRITE(host, NBLK, data->blocks - 1);
 	OMAP_MMC_WRITE(host, BLEN, block_size - 1);

--------------080301060409060102010008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080301060409060102010008--
