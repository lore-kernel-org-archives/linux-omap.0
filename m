From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: [PATCH 2/4] MFD: TWL6030: fix irq definitions
Date: Wed, 27 Apr 2011 10:39:49 +0100
Message-ID: <1303897191-14792-3-git-send-email-gg@slimlogic.co.uk>
References: <1303897191-14792-1-git-send-email-gg@slimlogic.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303897191-14792-1-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

The charger fault IRQs from the twl will in future patches be handled
by a seperate IRQ handler in the charger driver than the general charger
IRQ. Give them different IRQ numbers now to allow the charger driver to
be merged in the future.

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
---
 drivers/mfd/twl6030-irq.c |    4 ++--
 include/linux/i2c/twl.h   |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index dfbae34..eb3b5f8 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -76,8 +76,8 @@ static int twl6030_interrupt_mapping[24] = {
 	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
 	USB_PRES_INTR_OFFSET,	/* Bit 19	VBUS			*/
 	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
-	CHARGER_INTR_OFFSET,	/* Bit 21	EXT_CHRG		*/
-	CHARGER_INTR_OFFSET,	/* Bit 22	INT_CHRG		*/
+	CHARGERFAULT_INTR_OFFSET,	/* Bit 21	EXT_CHRG	*/
+	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/
 	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
 };
 /*----------------------------------------------------------------------*/
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f85f0ed..4323d3a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -91,6 +91,7 @@
 #define BCI_INTR_OFFSET		2
 #define MADC_INTR_OFFSET	3
 #define USB_INTR_OFFSET		4
+#define CHARGERFAULT_INTR_OFFSET 5
 #define BCI_PRES_INTR_OFFSET	9
 #define USB_PRES_INTR_OFFSET	10
 #define RTC_INTR_OFFSET		11
-- 
1.7.4.1
