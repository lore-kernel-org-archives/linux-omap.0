From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] OMAP MMC fixes
Date: Sat, 28 Oct 2006 20:34:05 +0200
Message-ID: <200610282034.05218.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dK6QF49kKe8hHlH"
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

--Boundary-00=_dK6QF49kKe8hHlH
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
omap mmc driver doesnt use data->blksz_bits anymore in 2619. It uses only=20
data->blksz . Enclosed patch fixes it.

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_dK6QF49kKe8hHlH
Content-Type: text/x-diff; charset="us-ascii"; name="omap-mmc-blksz-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap-mmc-blksz-fix.patch"

--- linux-omap-dev/drivers/mmc/omap.c	2006-10-28 01:37:40.000000000 +0200
+++ linux-omap/drivers/mmc/omap.c	2006-10-28 20:20:11.000000000 +0200
@@ -633,10 +633,10 @@
 	int sync_dev = 0;
 
 	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
-	frame = 1 << data->blksz_bits;
+	frame = 1 << data->blksz;
 	count = sg_dma_len(sg);
 
-	if ((data->blocks == 1) && (count > (1 << data->blksz_bits)))
+	if ((data->blocks == 1) && (count > (1 << data->blksz)))
 		count = frame;
 
 	host->dma_len = count;
@@ -825,7 +825,7 @@
 	}
 
 
-	block_size = 1 << data->blksz_bits;
+	block_size = 1 << data->blksz;
 
 	OMAP_MMC_WRITE(host, NBLK, data->blocks - 1);
 	OMAP_MMC_WRITE(host, BLEN, block_size - 1);

--Boundary-00=_dK6QF49kKe8hHlH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_dK6QF49kKe8hHlH--
