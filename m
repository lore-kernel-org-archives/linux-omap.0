From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [RFC PATCH v2 06/11] ARM: OMAP4+: Adding the temperature sensor register
 set bit fields
Date: Mon, 18 Jun 2012 15:32:29 +0400
Message-ID: <4FDF11CD.2090101@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48642 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751246Ab2FRLcb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 07:32:31 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>, Keerthy <j-keerthy@ti.com>

OMAP4460 specific temperature sensor register bit fields are added.
Existing OMAP4 entries are renamed to OMAP4430.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/include/mach/control.h |  116 ++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/control.h b/arch/arm/mach-omap2/include/mach/control.h
index cf42764..171b504 100644
--- a/arch/arm/mach-omap2/include/mach/control.h
+++ b/arch/arm/mach-omap2/include/mach/control.h
@@ -230,6 +230,122 @@
 /* OMAP44xx control McBSP padconf */
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP	0x061c
 
+/* TEMP_SENSOR OMAP4430 */
+#define OMAP4430_BGAP_TEMPSOFF_SHIFT			12
+#define OMAP4430_BGAP_TEMPSOFF_MASK			(1 << 12)
+#define OMAP4430_BGAP_TSHUT_SHIFT				11
+#define OMAP4430_BGAP_TSHUT_MASK				(1 << 11)
+#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_SHIFT		10
+#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_MASK		(1 << 10)
+#define OMAP4430_BGAP_TEMP_SENSOR_SOC_SHIFT		9
+#define OMAP4430_BGAP_TEMP_SENSOR_SOC_MASK			(1 << 9)
+#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_SHIFT		8
+#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 8)
+#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
+#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0xff << 0)
+
+/* TEMP_SENSOR OMAP4460 */
+#define OMAP4460_BGAP_TEMPSOFF_SHIFT			13
+#define OMAP4460_BGAP_TEMPSOFF_MASK			(1 << 13)
+#define OMAP4460_BGAP_TEMP_SENSOR_SOC_SHIFT		11
+#define OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK		(1 << 11)
+#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
+#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 10)
+#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
+#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
+
+/* BANDGAP_CTRL */
+#define OMAP4460_SINGLE_MODE_SHIFT			31
+#define OMAP4460_SINGLE_MODE_MASK			(1 << 31)
+#define OMAP4460_MASK_HOT_SHIFT				1
+#define OMAP4460_MASK_HOT_MASK				(1 << 1)
+#define OMAP4460_MASK_COLD_SHIFT			0
+#define OMAP4460_MASK_COLD_MASK				(1 << 0)
+
+/* BANDGAP_COUNTER */
+#define OMAP4460_COUNTER_SHIFT				0
+#define OMAP4460_COUNTER_MASK				(0xffffff << 0)
+
+/* BANDGAP_THRESHOLD */
+#define OMAP4460_T_HOT_SHIFT				16
+#define OMAP4460_T_HOT_MASK				(0x3ff << 16)
+#define OMAP4460_T_COLD_SHIFT				0
+#define OMAP4460_T_COLD_MASK				(0x3ff << 0)
+
+/* TSHUT_THRESHOLD */
+#define OMAP4460_TSHUT_HOT_SHIFT			16
+#define OMAP4460_TSHUT_HOT_MASK				(0x3ff << 16)
+#define OMAP4460_TSHUT_COLD_SHIFT			0
+#define OMAP4460_TSHUT_COLD_MASK			(0x3ff << 0)
+
+/* BANDGAP_STATUS */
+#define OMAP4460_CLEAN_STOP_SHIFT			3
+#define OMAP4460_CLEAN_STOP_MASK			(1 << 3)
+#define OMAP4460_BGAP_ALERT_SHIFT			2
+#define OMAP4460_BGAP_ALERT_MASK			(1 << 2)
+#define OMAP4460_HOT_FLAG_SHIFT				1
+#define OMAP4460_HOT_FLAG_MASK				(1 << 1)
+#define OMAP4460_COLD_FLAG_SHIFT			0
+#define OMAP4460_COLD_FLAG_MASK				(1 << 0)
+
+/* TEMP_SENSOR OMAP5430 */
+#define OMAP5430_BGAP_TEMP_SENSOR_SOC_SHIFT		12
+#define OMAP5430_BGAP_TEMP_SENSOR_SOC_MASK		(1 << 12)
+#define OMAP5430_BGAP_TEMPSOFF_SHIFT			11
+#define OMAP5430_BGAP_TEMPSOFF_MASK			(1 << 11)
+#define OMAP5430_BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
+#define OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 10)
+#define OMAP5430_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
+#define OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
+
+/* BANDGAP_CTRL */
+#define OMAP5430_MASK_HOT_CORE_SHIFT			5
+#define OMAP5430_MASK_HOT_CORE_MASK			(1 << 5)
+#define OMAP5430_MASK_COLD_CORE_SHIFT			4
+#define OMAP5430_MASK_COLD_CORE_MASK			(1 << 4)
+#define OMAP5430_MASK_HOT_MM_SHIFT			3
+#define OMAP5430_MASK_HOT_MM_MASK			(1 << 3)
+#define OMAP5430_MASK_COLD_MM_SHIFT			2
+#define OMAP5430_MASK_COLD_MM_MASK			(1 << 2)
+#define OMAP5430_MASK_HOT_MPU_SHIFT			1
+#define OMAP5430_MASK_HOT_MPU_MASK			(1 << 1)
+#define OMAP5430_MASK_COLD_MPU_SHIFT			0
+#define OMAP5430_MASK_COLD_MPU_MASK			(1 << 0)
+
+/* BANDGAP_COUNTER */
+#define OMAP5430_REPEAT_MODE_SHIFT			31
+#define OMAP5430_REPEAT_MODE_MASK			(1 << 31)
+#define OMAP5430_COUNTER_SHIFT				0
+#define OMAP5430_COUNTER_MASK				(0xffffff << 0)
+
+/* BANDGAP_THRESHOLD */
+#define OMAP5430_T_HOT_SHIFT				16
+#define OMAP5430_T_HOT_MASK				(0x3ff << 16)
+#define OMAP5430_T_COLD_SHIFT				0
+#define OMAP5430_T_COLD_MASK				(0x3ff << 0)
+
+/* TSHUT_THRESHOLD */
+#define OMAP5430_TSHUT_HOT_SHIFT			16
+#define OMAP5430_TSHUT_HOT_MASK				(0x3ff << 16)
+#define OMAP5430_TSHUT_COLD_SHIFT			0
+#define OMAP5430_TSHUT_COLD_MASK			(0x3ff << 0)
+
+/* BANDGAP_STATUS */
+#define OMAP5430_BGAP_ALERT_SHIFT			31
+#define OMAP5430_BGAP_ALERT_MASK			(1 << 31)
+#define OMAP5430_HOT_CORE_FLAG_SHIFT			5
+#define OMAP5430_HOT_CORE_FLAG_MASK			(1 << 5)
+#define OMAP5430_COLD_CORE_FLAG_SHIFT			4
+#define OMAP5430_COLD_CORE_FLAG_MASK			(1 << 4)
+#define OMAP5430_HOT_MM_FLAG_SHIFT			3
+#define OMAP5430_HOT_MM_FLAG_MASK			(1 << 3)
+#define OMAP5430_COLD_MM_FLAG_SHIFT			2
+#define OMAP5430_COLD_MM_FLAG_MASK			(1 << 2)
+#define OMAP5430_HOT_MPU_FLAG_SHIFT			1
+#define OMAP5430_HOT_MPU_FLAG_MASK			(1 << 1)
+#define OMAP5430_COLD_MPU_FLAG_SHIFT			0
+#define OMAP5430_COLD_MPU_FLAG_MASK			(1 << 0)
+
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
-- 
1.7.7.1.488.ge8e1c

