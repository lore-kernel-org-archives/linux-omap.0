From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 10/14] MMC: OMAP: Enabling MMC/SD card support option on
	n800_defconfig
Date: Thu, 20 Sep 2007 11:03:48 -0400
Message-ID: <46F28BD4.7010506@indt.org.br>
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Enables MMC/SD card support option on n800_defconfig to use MMC multislot support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/configs/n800_defconfig |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
index 87f6c96..f3c2fa3 100644
--- a/arch/arm/configs/n800_defconfig
+++ b/arch/arm/configs/n800_defconfig
@@ -1283,19 +1283,37 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_FILE_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card support
+# MMC/SD Card Drivers
 #
-# CONFIG_MMC is not set
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
-# Real Time Clock
+# MMC/SD Host Controller Drivers
 #
+CONFIG_MMC_OMAP=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
 # CBUS support
 #
 CONFIG_CBUS=y
-- 1.5.3.GIT
