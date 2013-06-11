From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 6/6] mailbox/omap: move the OMAP mailbox framework to drivers
Date: Tue, 11 Jun 2013 12:04:06 -0500
Message-ID: <1370970246-6848-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab3FKRJt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 13:09:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The mailbox hardware (in OMAP) uses a queued mailbox interrupt
mechanism that provides a communication channel between processors
through a set of registers and their associated interrupt signals
by sending and receiving messages.

The OMAP mailbox framework/driver code is moved to be under
drivers/mailbox, in preparation for adapting to a common mailbox
driver framework. This allows the build for OMAP mailbox to be
enabled (it was disabled during the multi-platform support).

As part of the migration from plat and mach code:
- Kconfig symbols have been renamed to build OMAP1 or OMAP2+ drivers.
- mailbox.h under plat-omap/plat/include has been split into a public
  and private header files. The public header has only the API related
  functions and types.
- The module name mailbox.ko from plat-omap is changed to
  omap-mailbox.ko
- The module name mailbox_mach.ko from mach-omapX is changed as
    mailbox_omap1.ko for OMAP1
    mailbox_omap2.ko for OMAP2+

Cc: Tony Lindgren <tony@atomide.com>
[gregkh@linuxfoundation.org: ack for staging part]
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/configs/omap1_defconfig                   |  3 +-
 arch/arm/mach-omap1/Makefile                       |  4 --
 arch/arm/mach-omap2/Makefile                       |  3 -
 arch/arm/mach-omap2/devices.c                      |  4 +-
 arch/arm/plat-omap/Kconfig                         | 16 -----
 arch/arm/plat-omap/Makefile                        |  3 -
 drivers/mailbox/Kconfig                            | 34 +++++++++++
 drivers/mailbox/Makefile                           |  6 ++
 .../mailbox.c => drivers/mailbox/mailbox-omap1.c   |  3 +-
 .../mailbox.c => drivers/mailbox/mailbox-omap2.c   |  8 +--
 .../mailbox.c => drivers/mailbox/omap-mailbox.c    | 36 +++++++++++-
 .../plat/mailbox.h => drivers/mailbox/omap-mbox.h  | 68 +++++-----------------
 drivers/remoteproc/Kconfig                         |  3 +-
 drivers/remoteproc/omap_remoteproc.c               |  2 +-
 drivers/staging/tidspbridge/Kconfig                |  3 +-
 .../tidspbridge/include/dspbridge/host_os.h        |  2 +-
 include/linux/omap-mailbox.h                       | 29 +++++++++
 17 files changed, 135 insertions(+), 92 deletions(-)
 rename arch/arm/mach-omap1/mailbox.c => drivers/mailbox/mailbox-omap1.c (99%)
 rename arch/arm/mach-omap2/mailbox.c => drivers/mailbox/mailbox-omap2.c (98%)
 rename arch/arm/plat-omap/mailbox.c => drivers/mailbox/omap-mailbox.c (92%)
 rename arch/arm/plat-omap/include/plat/mailbox.h => drivers/mailbox/omap-mbox.h (55%)
 create mode 100644 include/linux/omap-mailbox.h

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 9940f7b..d74edba 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -26,7 +26,8 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_RESET_CLOCKS=y
 # CONFIG_OMAP_MUX is not set
-CONFIG_OMAP_MBOX_FWK=y
+CONFIG_MAILBOX=y
+CONFIG_OMAP1_MBOX=y
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_DM_TIMER=y
 CONFIG_ARCH_OMAP730=y
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 222d58c..3889b6c 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -19,10 +19,6 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
-# DSP
-obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
-mailbox_mach-objs		:= mailbox.o
-
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..f2d19af 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -203,9 +203,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
 
-obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
-mailbox_mach-objs			:= mailbox.o
-
 iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
 obj-y					+= $(iommu-m) $(iommu-y)
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 4c97a86..73762ac 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -328,7 +328,7 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 	return 0;
 }
 
-#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+#if defined(CONFIG_OMAP2PLUS_MBOX) || defined(CONFIG_OMAP2PLUS_MBOX_MODULE)
 static inline void __init omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
@@ -352,7 +352,7 @@ static inline void __init omap_init_mbox(void)
 }
 #else
 static inline void omap_init_mbox(void) { }
-#endif /* CONFIG_OMAP_MBOX_FWK */
+#endif /* CONFIG_OMAP2PLUS_MBOX */
 
 static inline void omap_init_sti(void) {}
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ce66eb9..f82bae2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -86,22 +86,6 @@ config OMAP_MUX_WARNINGS
 	  to change the pin multiplexing setup.	 When there are no warnings
 	  printed, it's safe to deselect OMAP_MUX for your product.
 
-config OMAP_MBOX_FWK
-	tristate "Mailbox framework support"
-	depends on ARCH_OMAP && !ARCH_MULTIPLATFORM
-	help
-	  Say Y here if you want to use OMAP Mailbox framework support for
-	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
-
-config OMAP_MBOX_KFIFO_SIZE
-	int "Mailbox kfifo default buffer size (bytes)"
-	depends on OMAP_MBOX_FWK
-	default 256
-	help
-	  Specify the default size of mailbox's kfifo buffers (bytes).
-	  This can also be changed at runtime (via the mbox_kfifo_size
-	  module parameter).
-
 config OMAP_IOMMU_IVA2
 	bool
 
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 3119941..0b01b68 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -17,6 +17,3 @@ obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
 obj-y += $(i2c-omap-m) $(i2c-omap-y)
 
-# OMAP mailbox framework
-obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
-
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 9545c9f..c8b5c13 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -16,4 +16,38 @@ config PL320_MBOX
 	  Management Engine, primarily for cpufreq. Say Y here if you want
 	  to use the PL320 IPCM support.
 
+config OMAP_MBOX
+	tristate
+	help
+	  This option is selected by any OMAP architecture specific mailbox
+	  driver such as CONFIG_OMAP1_MBOX or CONFIG_OMAP2PLUS_MBOX. This
+	  enables the common OMAP mailbox framework code.
+
+config OMAP1_MBOX
+	tristate "OMAP1 Mailbox framework support"
+	depends on ARCH_OMAP1
+	select OMAP_MBOX
+	help
+	  Mailbox implementation for OMAP chips with hardware for
+	  interprocessor communication involving DSP in OMAP1. Say Y here
+	  if you want to use OMAP1 Mailbox framework support.
+
+config OMAP2PLUS_MBOX
+	tristate "OMAP2+ Mailbox framework support"
+	depends on ARCH_OMAP2PLUS
+	select OMAP_MBOX
+	help
+	  Mailbox implementation for OMAP family chips with hardware for
+	  interprocessor communication involving DSP, IVA1.0 and IVA2 in
+	  OMAP2/3; or IPU, IVA HD and DSP in OMAP4/5. Say Y here if you
+	  want to use OMAP2+ Mailbox framework support.
+
+config OMAP_MBOX_KFIFO_SIZE
+	int "Mailbox kfifo default buffer size (bytes)"
+	depends on OMAP2PLUS_MBOX || OMAP1_MBOX
+	default 256
+	help
+	  Specify the default size of mailbox's kfifo buffers (bytes).
+	  This can also be changed at runtime (via the mbox_kfifo_size
+	  module parameter).
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 543ad6a..e0facb3 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -1 +1,7 @@
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
+
+obj-$(CONFIG_OMAP_MBOX)		+= omap-mailbox.o
+obj-$(CONFIG_OMAP1_MBOX)	+= mailbox_omap1.o
+mailbox_omap1-objs		:= mailbox-omap1.o
+obj-$(CONFIG_OMAP2PLUS_MBOX)	+= mailbox_omap2.o
+mailbox_omap2-objs		:= mailbox-omap2.o
diff --git a/arch/arm/mach-omap1/mailbox.c b/drivers/mailbox/mailbox-omap1.c
similarity index 99%
rename from arch/arm/mach-omap1/mailbox.c
rename to drivers/mailbox/mailbox-omap1.c
index 7246a52..9001b76 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/drivers/mailbox/mailbox-omap1.c
@@ -13,7 +13,8 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <plat/mailbox.h>
+
+#include "omap-mbox.h"
 
 #define MAILBOX_ARM2DSP1		0x00
 #define MAILBOX_ARM2DSP1b		0x04
diff --git a/arch/arm/mach-omap2/mailbox.c b/drivers/mailbox/mailbox-omap2.c
similarity index 98%
rename from arch/arm/mach-omap2/mailbox.c
rename to drivers/mailbox/mailbox-omap2.c
index de21198..eba380d 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/drivers/mailbox/mailbox-omap2.c
@@ -19,7 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/mailbox-omap.h>
 
-#include <plat/mailbox.h>
+#include "omap-mbox.h"
 
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
@@ -331,9 +331,9 @@ static int omap2_mbox_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap2_mbox_driver = {
-	.probe = omap2_mbox_probe,
-	.remove = omap2_mbox_remove,
-	.driver = {
+	.probe	= omap2_mbox_probe,
+	.remove	= omap2_mbox_remove,
+	.driver	= {
 		.name = "omap-mailbox",
 	},
 };
diff --git a/arch/arm/plat-omap/mailbox.c b/drivers/mailbox/omap-mailbox.c
similarity index 92%
rename from arch/arm/plat-omap/mailbox.c
rename to drivers/mailbox/omap-mailbox.c
index f65eaf0..d79a646 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -31,7 +31,7 @@
 #include <linux/notifier.h>
 #include <linux/module.h>
 
-#include <plat/mailbox.h>
+#include "omap-mbox.h"
 
 static struct omap_mbox **mboxes;
 
@@ -116,6 +116,40 @@ out:
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
 
+void omap_mbox_save_ctx(struct omap_mbox *mbox)
+{
+	if (!mbox->ops->save_ctx) {
+		dev_err(mbox->dev, "%s:\tno save\n", __func__);
+		return;
+	}
+
+	mbox->ops->save_ctx(mbox);
+}
+EXPORT_SYMBOL(omap_mbox_save_ctx);
+
+void omap_mbox_restore_ctx(struct omap_mbox *mbox)
+{
+	if (!mbox->ops->restore_ctx) {
+		dev_err(mbox->dev, "%s:\tno restore\n", __func__);
+		return;
+	}
+
+	mbox->ops->restore_ctx(mbox);
+}
+EXPORT_SYMBOL(omap_mbox_restore_ctx);
+
+void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
+{
+	mbox->ops->enable_irq(mbox, irq);
+}
+EXPORT_SYMBOL(omap_mbox_enable_irq);
+
+void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
+{
+	mbox->ops->disable_irq(mbox, irq);
+}
+EXPORT_SYMBOL(omap_mbox_disable_irq);
+
 static void mbox_tx_tasklet(unsigned long tx_data)
 {
 	struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/drivers/mailbox/omap-mbox.h
similarity index 55%
rename from arch/arm/plat-omap/include/plat/mailbox.h
rename to drivers/mailbox/omap-mbox.h
index e98f7e2..6cd38fc 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/drivers/mailbox/omap-mbox.h
@@ -1,20 +1,20 @@
-/* mailbox.h */
+/*
+ * omap-mbox.h: OMAP mailbox internal definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 
-#ifndef MAILBOX_H
-#define MAILBOX_H
+#ifndef OMAP_MBOX_H
+#define OMAP_MBOX_H
 
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/kfifo.h>
-
-typedef u32 mbox_msg_t;
-struct omap_mbox;
-
-typedef int __bitwise omap_mbox_irq_t;
-#define IRQ_TX ((__force omap_mbox_irq_t) 1)
-#define IRQ_RX ((__force omap_mbox_irq_t) 2)
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/omap-mailbox.h>
 
 typedef int __bitwise omap_mbox_type_t;
 #define OMAP_MBOX_TYPE1 ((__force omap_mbox_type_t) 1)
@@ -58,48 +58,10 @@ struct omap_mbox {
 	struct device		*dev;
 	void			*priv;
 	int			use_count;
-	struct blocking_notifier_head   notifier;
+	struct blocking_notifier_head	notifier;
 };
 
-int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
-void omap_mbox_init_seq(struct omap_mbox *);
-
-struct omap_mbox *omap_mbox_get(const char *, struct notifier_block *nb);
-void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb);
-
 int omap_mbox_register(struct device *parent, struct omap_mbox **);
 int omap_mbox_unregister(void);
 
-static inline void omap_mbox_save_ctx(struct omap_mbox *mbox)
-{
-	if (!mbox->ops->save_ctx) {
-		dev_err(mbox->dev, "%s:\tno save\n", __func__);
-		return;
-	}
-
-	mbox->ops->save_ctx(mbox);
-}
-
-static inline void omap_mbox_restore_ctx(struct omap_mbox *mbox)
-{
-	if (!mbox->ops->restore_ctx) {
-		dev_err(mbox->dev, "%s:\tno restore\n", __func__);
-		return;
-	}
-
-	mbox->ops->restore_ctx(mbox);
-}
-
-static inline void omap_mbox_enable_irq(struct omap_mbox *mbox,
-					omap_mbox_irq_t irq)
-{
-	mbox->ops->enable_irq(mbox, irq);
-}
-
-static inline void omap_mbox_disable_irq(struct omap_mbox *mbox,
-					 omap_mbox_irq_t irq)
-{
-	mbox->ops->disable_irq(mbox, irq);
-}
-
-#endif /* MAILBOX_H */
+#endif /* OMAP_MBOX_H */
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index d4d377c..ce1743d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -14,8 +14,9 @@ config OMAP_REMOTEPROC
 	depends on HAS_DMA
 	depends on ARCH_OMAP4 || SOC_OMAP5
 	depends on OMAP_IOMMU
-	depends on OMAP_MBOX_FWK
 	select REMOTEPROC
+	select MAILBOX
+	select OMAP2PLUS_MBOX
 	select RPMSG
 	help
 	  Say y here to support OMAP's remote processors (dual M3
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 0e396c1..5168972 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -27,8 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/remoteproc.h>
+#include <linux/omap-mailbox.h>
 
-#include <plat/mailbox.h>
 #include <linux/platform_data/remoteproc-omap.h>
 
 #include "omap_remoteproc.h"
diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/tidspbridge/Kconfig
index 60848f1..165b918 100644
--- a/drivers/staging/tidspbridge/Kconfig
+++ b/drivers/staging/tidspbridge/Kconfig
@@ -5,7 +5,8 @@
 menuconfig TIDSPBRIDGE
 	tristate "DSP Bridge driver"
 	depends on ARCH_OMAP3 && !ARCH_MULTIPLATFORM
-	select OMAP_MBOX_FWK
+	select MAILBOX
+	select OMAP2PLUS_MBOX
 	help
 	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
 	  one or more attached DSPs.  The GPP is considered the master or
diff --git a/drivers/staging/tidspbridge/include/dspbridge/host_os.h b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
index 7f3a1db..d1441db 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/host_os.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
@@ -41,7 +41,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <plat/mailbox.h>
+#include <linux/omap-mailbox.h>
 #include <linux/pagemap.h>
 #include <asm/cacheflush.h>
 #include <linux/dma-mapping.h>
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
new file mode 100644
index 0000000..f8322d9
--- /dev/null
+++ b/include/linux/omap-mailbox.h
@@ -0,0 +1,29 @@
+/*
+ * omap-mailbox: interprocessor communication module for OMAP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef OMAP_MAILBOX_H
+#define OMAP_MAILBOX_H
+
+typedef u32 mbox_msg_t;
+struct omap_mbox;
+
+typedef int __bitwise omap_mbox_irq_t;
+#define IRQ_TX ((__force omap_mbox_irq_t) 1)
+#define IRQ_RX ((__force omap_mbox_irq_t) 2)
+
+int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
+
+struct omap_mbox *omap_mbox_get(const char *, struct notifier_block *nb);
+void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb);
+
+void omap_mbox_save_ctx(struct omap_mbox *mbox);
+void omap_mbox_restore_ctx(struct omap_mbox *mbox);
+void omap_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq);
+void omap_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq);
+
+#endif /* OMAP_MAILBOX_H */
-- 
1.8.2

