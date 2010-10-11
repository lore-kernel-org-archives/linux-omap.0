From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [RFC PATCHv3 5/7] HSI CHAR: Add HSI char device kernel configuration
Date: Mon, 11 Oct 2010 12:06:26 +0300
Message-ID: <1286787988-29013-6-git-send-email-carlos.chinea@nokia.com>
References: <1286787988-29013-1-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286787988-29013-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Andras Domokos <andras.domokos@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Andras Domokos <andras.domokos@nokia.com>

Add HSI character device kernel configuration

Signed-off-by: Andras Domokos <andras.domokos@nokia.com>
Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 drivers/hsi/Kconfig          |    1 +
 drivers/hsi/Makefile         |    2 +-
 drivers/hsi/clients/Kconfig  |   13 +++++++++++++
 drivers/hsi/clients/Makefile |    5 +++++
 include/linux/Kbuild         |    1 +
 include/linux/hsi/Kbuild     |    1 +
 6 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hsi/clients/Kconfig
 create mode 100644 drivers/hsi/clients/Makefile
 create mode 100644 include/linux/hsi/Kbuild

diff --git a/drivers/hsi/Kconfig b/drivers/hsi/Kconfig
index 07987b6..94fc793 100644
--- a/drivers/hsi/Kconfig
+++ b/drivers/hsi/Kconfig
@@ -11,5 +11,6 @@ menuconfig HSI
 if HSI
 
 source "drivers/hsi/controllers/Kconfig"
+source "drivers/hsi/clients/Kconfig"
 
 endif # HSI
diff --git a/drivers/hsi/Makefile b/drivers/hsi/Makefile
index d020ae1..ebc91b3 100644
--- a/drivers/hsi/Makefile
+++ b/drivers/hsi/Makefile
@@ -2,4 +2,4 @@
 # Makefile for HSI
 #
 obj-$(CONFIG_HSI)	+= hsi.o
-obj-y			+= controllers/
+obj-y			+= controllers/ clients/
diff --git a/drivers/hsi/clients/Kconfig b/drivers/hsi/clients/Kconfig
new file mode 100644
index 0000000..3bacd27
--- /dev/null
+++ b/drivers/hsi/clients/Kconfig
@@ -0,0 +1,13 @@
+#
+# HSI clients configuration
+#
+
+comment "HSI clients"
+
+config HSI_CHAR
+	tristate "HSI/SSI character driver"
+	depends on HSI
+	---help---
+	  If you say Y here, you will enable the HSI/SSI character driver.
+	  This driver provides a simple character device interface for
+	  serial communication with the cellular modem over HSI/SSI bus.
diff --git a/drivers/hsi/clients/Makefile b/drivers/hsi/clients/Makefile
new file mode 100644
index 0000000..327c0e2
--- /dev/null
+++ b/drivers/hsi/clients/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for HSI clients
+#
+
+obj-$(CONFIG_HSI_CHAR)	+= hsi_char.o
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 626b629..24c35fc 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -2,6 +2,7 @@ header-y += byteorder/
 header-y += can/
 header-y += dvb/
 header-y += hdlc/
+header-y += hsi/
 header-y += isdn/
 header-y += nfsd/
 header-y += raid/
diff --git a/include/linux/hsi/Kbuild b/include/linux/hsi/Kbuild
new file mode 100644
index 0000000..271a770
--- /dev/null
+++ b/include/linux/hsi/Kbuild
@@ -0,0 +1 @@
+header-y += hsi_char.h
-- 
1.5.6.5
