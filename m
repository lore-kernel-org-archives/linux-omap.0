From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 3/4] OMAP: MENELAUS: Move menelaus register map to include/linux/i2c/menelaus.h
Date: Tue, 29 Jul 2008 12:44:31 -0400
Message-ID: <488F48EF.9070906@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17364 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbYG2Qon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 12:44:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch moves menelaus register map to include/linux/i2c/menelaus.h

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 drivers/i2c/chips/menelaus.c |  111 -----------------------------------------
 include/linux/i2c/menelaus.h |  112 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 111 deletions(-)

diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index e65245e..40eb14a 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -50,117 +50,6 @@
 
 #define DRIVER_NAME			"menelaus"
 
-#define MENELAUS_I2C_ADDRESS		0x72
-
-#define MENELAUS_REV			0x01
-#define MENELAUS_VCORE_CTRL1		0x02
-#define MENELAUS_VCORE_CTRL2		0x03
-#define MENELAUS_VCORE_CTRL3		0x04
-#define MENELAUS_VCORE_CTRL4		0x05
-#define MENELAUS_VCORE_CTRL5		0x06
-#define MENELAUS_DCDC_CTRL1		0x07
-#define MENELAUS_DCDC_CTRL2		0x08
-#define MENELAUS_DCDC_CTRL3		0x09
-#define MENELAUS_LDO_CTRL1		0x0A
-#define MENELAUS_LDO_CTRL2		0x0B
-#define MENELAUS_LDO_CTRL3		0x0C
-#define MENELAUS_LDO_CTRL4		0x0D
-#define MENELAUS_LDO_CTRL5		0x0E
-#define MENELAUS_LDO_CTRL6		0x0F
-#define MENELAUS_LDO_CTRL7		0x10
-#define MENELAUS_LDO_CTRL8		0x11
-#define MENELAUS_SLEEP_CTRL1		0x12
-#define MENELAUS_SLEEP_CTRL2		0x13
-#define MENELAUS_DEVICE_OFF		0x14
-#define MENELAUS_OSC_CTRL		0x15
-#define MENELAUS_DETECT_CTRL		0x16
-#define MENELAUS_INT_MASK1		0x17
-#define MENELAUS_INT_MASK2		0x18
-#define MENELAUS_INT_STATUS1		0x19
-#define MENELAUS_INT_STATUS2		0x1A
-#define MENELAUS_INT_ACK1		0x1B
-#define MENELAUS_INT_ACK2		0x1C
-#define MENELAUS_GPIO_CTRL		0x1D
-#define MENELAUS_GPIO_IN		0x1E
-#define MENELAUS_GPIO_OUT		0x1F
-#define MENELAUS_BBSMS			0x20
-#define MENELAUS_RTC_CTRL		0x21
-#define MENELAUS_RTC_UPDATE		0x22
-#define MENELAUS_RTC_SEC		0x23
-#define MENELAUS_RTC_MIN		0x24
-#define MENELAUS_RTC_HR			0x25
-#define MENELAUS_RTC_DAY		0x26
-#define MENELAUS_RTC_MON		0x27
-#define MENELAUS_RTC_YR			0x28
-#define MENELAUS_RTC_WKDAY		0x29
-#define MENELAUS_RTC_AL_SEC		0x2A
-#define MENELAUS_RTC_AL_MIN		0x2B
-#define MENELAUS_RTC_AL_HR		0x2C
-#define MENELAUS_RTC_AL_DAY		0x2D
-#define MENELAUS_RTC_AL_MON		0x2E
-#define MENELAUS_RTC_AL_YR		0x2F
-#define MENELAUS_RTC_COMP_MSB		0x30
-#define MENELAUS_RTC_COMP_LSB		0x31
-#define MENELAUS_S1_PULL_EN		0x32
-#define MENELAUS_S1_PULL_DIR		0x33
-#define MENELAUS_S2_PULL_EN		0x34
-#define MENELAUS_S2_PULL_DIR		0x35
-#define MENELAUS_MCT_CTRL1		0x36
-#define MENELAUS_MCT_CTRL2		0x37
-#define MENELAUS_MCT_CTRL3		0x38
-#define MENELAUS_MCT_PIN_ST		0x39
-#define MENELAUS_DEBOUNCE1		0x3A
-
-#define IH_MENELAUS_IRQS		12
-#define MENELAUS_MMC_S1CD_IRQ		0	/* MMC slot 1 card change */
-#define MENELAUS_MMC_S2CD_IRQ		1	/* MMC slot 2 card change */
-#define MENELAUS_MMC_S1D1_IRQ		2	/* MMC DAT1 low in slot 1 */
-#define MENELAUS_MMC_S2D1_IRQ		3	/* MMC DAT1 low in slot 2 */
-#define MENELAUS_LOWBAT_IRQ		4	/* Low battery */
-#define MENELAUS_HOTDIE_IRQ		5	/* Hot die detect */
-#define MENELAUS_UVLO_IRQ		6	/* UVLO detect */
-#define MENELAUS_TSHUT_IRQ		7	/* Thermal shutdown */
-#define MENELAUS_RTCTMR_IRQ		8	/* RTC timer */
-#define MENELAUS_RTCALM_IRQ		9	/* RTC alarm */
-#define MENELAUS_RTCERR_IRQ		10	/* RTC error */
-#define MENELAUS_PSHBTN_IRQ		11	/* Push button */
-#define MENELAUS_RESERVED12_IRQ		12	/* Reserved */
-#define MENELAUS_RESERVED13_IRQ		13	/* Reserved */
-#define MENELAUS_RESERVED14_IRQ		14	/* Reserved */
-#define MENELAUS_RESERVED15_IRQ		15	/* Reserved */
-
-/* VCORE_CTRL1 register */
-#define VCORE_CTRL1_BYP_COMP		(1 << 5)
-#define VCORE_CTRL1_HW_NSW		(1 << 7)
-
-/* GPIO_CTRL register */
-#define GPIO_CTRL_SLOTSELEN		(1 << 5)
-#define GPIO_CTRL_SLPCTLEN		(1 << 6)
-#define GPIO1_DIR_INPUT 		(1 << 0)
-#define GPIO2_DIR_INPUT 		(1 << 1)
-#define GPIO3_DIR_INPUT 		(1 << 2)
-
-/* MCT_CTRL1 register */
-#define MCT_CTRL1_S1_CMD_OD		(1 << 2)
-#define MCT_CTRL1_S2_CMD_OD		(1 << 3)
-
-/* MCT_CTRL2 register */
-#define MCT_CTRL2_VS2_SEL_D0		(1 << 0)
-#define MCT_CTRL2_VS2_SEL_D1		(1 << 1)
-#define MCT_CTRL2_S1CD_BUFEN		(1 << 4)
-#define MCT_CTRL2_S2CD_BUFEN		(1 << 5)
-#define MCT_CTRL2_S1CD_DBEN		(1 << 6)
-#define MCT_CTRL2_S2CD_BEN		(1 << 7)
-
-/* MCT_CTRL3 register */
-#define MCT_CTRL3_SLOT1_EN		(1 << 0)
-#define MCT_CTRL3_SLOT2_EN		(1 << 1)
-#define MCT_CTRL3_S1_AUTO_EN		(1 << 2)
-#define MCT_CTRL3_S2_AUTO_EN		(1 << 3)
-
-/* MCT_PIN_ST register */
-#define MCT_PIN_ST_S1_CD_ST		(1 << 0)
-#define MCT_PIN_ST_S2_CD_ST		(1 << 1)
 
 static void menelaus_work(struct work_struct *_menelaus);
 
diff --git a/include/linux/i2c/menelaus.h b/include/linux/i2c/menelaus.h
index e1012c1..1660418 100644
--- a/include/linux/i2c/menelaus.h
+++ b/include/linux/i2c/menelaus.h
@@ -7,6 +7,118 @@
 #ifndef __ASM_ARCH_MENELAUS_H
 #define __ASM_ARCH_MENELAUS_H
 
+#define MENELAUS_I2C_ADDRESS		0x72
+
+#define MENELAUS_REV			0x01
+#define MENELAUS_VCORE_CTRL1		0x02
+#define MENELAUS_VCORE_CTRL2		0x03
+#define MENELAUS_VCORE_CTRL3		0x04
+#define MENELAUS_VCORE_CTRL4		0x05
+#define MENELAUS_VCORE_CTRL5		0x06
+#define MENELAUS_DCDC_CTRL1		0x07
+#define MENELAUS_DCDC_CTRL2		0x08
+#define MENELAUS_DCDC_CTRL3		0x09
+#define MENELAUS_LDO_CTRL1		0x0A
+#define MENELAUS_LDO_CTRL2		0x0B
+#define MENELAUS_LDO_CTRL3		0x0C
+#define MENELAUS_LDO_CTRL4		0x0D
+#define MENELAUS_LDO_CTRL5		0x0E
+#define MENELAUS_LDO_CTRL6		0x0F
+#define MENELAUS_LDO_CTRL7		0x10
+#define MENELAUS_LDO_CTRL8		0x11
+#define MENELAUS_SLEEP_CTRL1		0x12
+#define MENELAUS_SLEEP_CTRL2		0x13
+#define MENELAUS_DEVICE_OFF		0x14
+#define MENELAUS_OSC_CTRL		0x15
+#define MENELAUS_DETECT_CTRL		0x16
+#define MENELAUS_INT_MASK1		0x17
+#define MENELAUS_INT_MASK2		0x18
+#define MENELAUS_INT_STATUS1		0x19
+#define MENELAUS_INT_STATUS2		0x1A
+#define MENELAUS_INT_ACK1		0x1B
+#define MENELAUS_INT_ACK2		0x1C
+#define MENELAUS_GPIO_CTRL		0x1D
+#define MENELAUS_GPIO_IN		0x1E
+#define MENELAUS_GPIO_OUT		0x1F
+#define MENELAUS_BBSMS			0x20
+#define MENELAUS_RTC_CTRL		0x21
+#define MENELAUS_RTC_UPDATE		0x22
+#define MENELAUS_RTC_SEC		0x23
+#define MENELAUS_RTC_MIN		0x24
+#define MENELAUS_RTC_HR			0x25
+#define MENELAUS_RTC_DAY		0x26
+#define MENELAUS_RTC_MON		0x27
+#define MENELAUS_RTC_YR			0x28
+#define MENELAUS_RTC_WKDAY		0x29
+#define MENELAUS_RTC_AL_SEC		0x2A
+#define MENELAUS_RTC_AL_MIN		0x2B
+#define MENELAUS_RTC_AL_HR		0x2C
+#define MENELAUS_RTC_AL_DAY		0x2D
+#define MENELAUS_RTC_AL_MON		0x2E
+#define MENELAUS_RTC_AL_YR		0x2F
+#define MENELAUS_RTC_COMP_MSB		0x30
+#define MENELAUS_RTC_COMP_LSB		0x31
+#define MENELAUS_S1_PULL_EN		0x32
+#define MENELAUS_S1_PULL_DIR		0x33
+#define MENELAUS_S2_PULL_EN		0x34
+#define MENELAUS_S2_PULL_DIR		0x35
+#define MENELAUS_MCT_CTRL1		0x36
+#define MENELAUS_MCT_CTRL2		0x37
+#define MENELAUS_MCT_CTRL3		0x38
+#define MENELAUS_MCT_PIN_ST		0x39
+#define MENELAUS_DEBOUNCE1		0x3A
+
+#define IH_MENELAUS_IRQS		12
+#define MENELAUS_MMC_S1CD_IRQ		0	/* MMC slot 1 card change */
+#define MENELAUS_MMC_S2CD_IRQ		1	/* MMC slot 2 card change */
+#define MENELAUS_MMC_S1D1_IRQ		2	/* MMC DAT1 low in slot 1 */
+#define MENELAUS_MMC_S2D1_IRQ		3	/* MMC DAT1 low in slot 2 */
+#define MENELAUS_LOWBAT_IRQ		4	/* Low battery */
+#define MENELAUS_HOTDIE_IRQ		5	/* Hot die detect */
+#define MENELAUS_UVLO_IRQ		6	/* UVLO detect */
+#define MENELAUS_TSHUT_IRQ		7	/* Thermal shutdown */
+#define MENELAUS_RTCTMR_IRQ		8	/* RTC timer */
+#define MENELAUS_RTCALM_IRQ		9	/* RTC alarm */
+#define MENELAUS_RTCERR_IRQ		10	/* RTC error */
+#define MENELAUS_PSHBTN_IRQ		11	/* Push button */
+#define MENELAUS_RESERVED12_IRQ		12	/* Reserved */
+#define MENELAUS_RESERVED13_IRQ		13	/* Reserved */
+#define MENELAUS_RESERVED14_IRQ		14	/* Reserved */
+#define MENELAUS_RESERVED15_IRQ		15	/* Reserved */
+
+/* VCORE_CTRL1 register */
+#define VCORE_CTRL1_BYP_COMP		(1 << 5)
+#define VCORE_CTRL1_HW_NSW		(1 << 7)
+
+/* GPIO_CTRL register */
+#define GPIO_CTRL_SLOTSELEN		(1 << 5)
+#define GPIO_CTRL_SLPCTLEN		(1 << 6)
+#define GPIO1_DIR_INPUT 		(1 << 0)
+#define GPIO2_DIR_INPUT 		(1 << 1)
+#define GPIO3_DIR_INPUT 		(1 << 2)
+
+/* MCT_CTRL1 register */
+#define MCT_CTRL1_S1_CMD_OD		(1 << 2)
+#define MCT_CTRL1_S2_CMD_OD		(1 << 3)
+
+/* MCT_CTRL2 register */
+#define MCT_CTRL2_VS2_SEL_D0		(1 << 0)
+#define MCT_CTRL2_VS2_SEL_D1		(1 << 1)
+#define MCT_CTRL2_S1CD_BUFEN		(1 << 4)
+#define MCT_CTRL2_S2CD_BUFEN		(1 << 5)
+#define MCT_CTRL2_S1CD_DBEN		(1 << 6)
+#define MCT_CTRL2_S2CD_BEN		(1 << 7)
+
+/* MCT_CTRL3 register */
+#define MCT_CTRL3_SLOT1_EN		(1 << 0)
+#define MCT_CTRL3_SLOT2_EN		(1 << 1)
+#define MCT_CTRL3_S1_AUTO_EN		(1 << 2)
+#define MCT_CTRL3_S2_AUTO_EN		(1 << 3)
+
+/* MCT_PIN_ST register */
+#define MCT_PIN_ST_S1_CD_ST		(1 << 0)
+#define MCT_PIN_ST_S2_CD_ST		(1 << 1)
+
 struct device;
 
 struct menelaus_platform_data {
-- 1.5.5.1

