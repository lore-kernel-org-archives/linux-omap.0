From: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2 v3] OMAP-McSPI: Update platform
	McSPI files
Date: Fri, 13 Aug 2010 19:28:46 +0530 (IST)
Message-ID: <65423.192.168.10.88.1281707926.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org


From: Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>

This patch updates platform files for fifo, slave support.

Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Govindraj.R <govindraj.raja-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c           |    5 +++++
 arch/arm/plat-omap/include/plat/mcspi.h |   29 ++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..fa99da1 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -251,6 +251,7 @@ static inline void omap_init_sti(void) {}

 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
+	.force_cs_mode	= 1,
 };

 static struct resource omap2_mcspi1_resources[] = {
@@ -273,6 +274,10 @@ static struct platform_device omap2_mcspi1 = {

 static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
 	.num_cs		= 2,
+	.mode		= OMAP2_MCSPI_MASTER,
+	.dma_mode	= 0,
+	.force_cs_mode	= 0,
+	.fifo_depth	= 0,
 };

 static struct resource omap2_mcspi2_resources[] = {
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 1254e49..23b928b 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -1,8 +1,35 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H

+#define OMAP2_MCSPI_MASTER		0
+#define OMAP2_MCSPI_SLAVE		1
+
+/**
+ * struct omap2_mcspi_platform_config - McSPI controller configuration
+ * @num_cs: Number of chip selects or channels supported
+ * @mode: SPI is master or slave
+ * @dma_mode: Use only DMA for data transfers
+ * @force_cs_mode: Use force chip select mode or auto chip select mode
+ * @fifo_depth: FIFO depth in bytes, max value 64
+ *
+ * @dma_mode when set to 1 uses only dma for data transfers
+ * else the default behaviour is to use PIO mode for transfer
+ * size of 8 bytes or less. This mode is useful when mcspi
+ * is configured as slave
+ *
+ * @force_cs_mode when set to 1 allows continuous transfer of multiple
+ * spi words without toggling the chip select line.
+ *
+ * @fifo_depth when set to non zero values enables FIFO. fifo_depth
+ * should be set as a multiple of buffer size used for read/write.
+ */
+
 struct omap2_mcspi_platform_config {
-	unsigned short	num_cs;
+	u8	num_cs;
+	u8	mode;
+	u8	dma_mode;
+	u8	force_cs_mode;
+	unsigned short fifo_depth;
 };

 struct omap2_mcspi_device_config {
-- 
1.6.3.3





------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
