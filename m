From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [RFC] [PATCH] MMC OMAP: add OMAP_GPIO_SWITCH dependency for N800
Date: Tue, 18 Sep 2007 13:16:09 -0400
Message-ID: <46F007D9.6060603@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

OMAP_GPIO_SWITCH is needed by MMC host on N800. If this option is
not selected, compilation fails.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
---
 drivers/mmc/host/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e23082f..671b9a4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -39,6 +39,7 @@ config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
 	select TPS65010 if MACH_OMAP_H2
+	select OMAP_GPIO_SWITCH if MACH_NOKIA_N800
 	help
 	  This selects the TI OMAP Multimedia card Interface.
 	  If you have an OMAP board with a Multimedia Card slot,
-- 
1.5.2
