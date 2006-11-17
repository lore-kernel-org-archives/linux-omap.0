From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 6/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Date: Fri, 17 Nov 2006 09:13:27 -0400
Message-ID: <455DB577.1000103@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070208020100010900000209"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Pierre Ossman <drzeus-list@drzeus.cx>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070208020100010900000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OMAP platform specific patch.
- Adjust the frame count for DMA transfers.

Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:08:30.000000000 -0400
@@ -628,6 +628,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos

  	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
  	frame = data->blksz;
+
+	/* MMC LOCK/UNLOCK: Do frame size multiple of 16bits (2bytes) */
+	frame += frame&0x1;
+
  	count = sg_dma_len(sg);

  	if ((data->blocks == 1) && (count > (data->blksz)))


--------------070208020100010900000209
Content-Type: text/x-patch;
 name="mmc_omap_dma.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_dma.diff"

OMAP platform specific patch.
- Adjust the frame count for DMA transfers.

Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:08:30.000000000 -0400
@@ -628,6 +628,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
 
 	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
 	frame = data->blksz;
+
+	/* MMC LOCK/UNLOCK: Do frame size multiple of 16bits (2bytes) */
+	frame += frame&0x1;
+
 	count = sg_dma_len(sg);
 
 	if ((data->blocks == 1) && (count > (data->blksz)))

--------------070208020100010900000209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070208020100010900000209--
