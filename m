From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: [PATCH 2/4] MFD: palmas PMIC device support Kconfig
Date: Mon, 14 May 2012 10:58:30 +0900
Message-ID: <1336960712-2812-3-git-send-email-gg@slimlogic.co.uk>
References: <1336960712-2812-1-git-send-email-gg@slimlogic.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336960712-2812-1-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Add the new palmas MFD to Kconfig and Makefile

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
---
 drivers/mfd/Kconfig  |    8 ++++++++
 drivers/mfd/Makefile |    1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c618e3a..1528bdd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -906,6 +906,14 @@ config MFD_ANATOP
 	  MFD controller. This controller embeds regulator and
 	  thermal devices for Freescale i.MX platforms.
 
+config MFD_PALMAS
+	bool "Support for the TI Palmas series chips"
+	select MFD_CORE
+	depends on I2C=y
+	help
+	  If you say yes here you get support for the Palmas
+	  series of PMIC chips from Texas Instruments.
+
 endmenu
 endif
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index acc888d..f4a342e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -118,3 +118,4 @@ obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_S5M_CORE)	+= s5m-core.o s5m-irq.o
 obj-$(CONFIG_MFD_ANATOP)	+= anatop-mfd.o
 obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
+obj-$(CONFIG_MFD_PALMAS)	+= palmas.o palmas-irq.o
-- 
1.7.9.5
