From: "Sameer" <x0081444@ti.com>
Subject: [PATCH] - onenand - OMAP3 support - Kconfig update
Date: Mon, 19 Nov 2007 18:00:32 +0530
Message-ID: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi,
This patch enables the onenand Kconfig for OMAP3.

Regards,
-Sameer

Signed-off-by: Sameer <sameersu@ti.com>
---
 drivers/mtd/onenand/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-omap-git/drivers/mtd/onenand/Kconfig
===================================================================
--- linux-omap-git.orig/drivers/mtd/onenand/Kconfig
+++ linux-omap-git/drivers/mtd/onenand/Kconfig
@@ -28,10 +28,10 @@ config MTD_ONENAND_GENERIC
          Support for OneNAND flash via platform device driver.

 config MTD_ONENAND_OMAP2
-       tristate "OneNAND on OMAP2 support"
-       depends on MTD_ONENAND && ARCH_OMAP2
+       tristate "OneNAND on OMAP2/OMAP3 support"
+       depends on MTD_ONENAND && (ARCH_OMAP2 || ARCH_OMAP3)
        help
-         Support for a OneNAND flash device connected to an OMAP2 CPU
+         Support for a OneNAND flash device connected to an OMAP2/OMAP3 CPU
          via the GPMC memory controller.
