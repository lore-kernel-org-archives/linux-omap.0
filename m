From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC v2 14/18] ARM: OMAP2+: AM33XX: control: Add some control module registers and APIs
Date: Mon, 31 Dec 2012 18:37:07 +0530
Message-ID: <1356959231-17335-15-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59849 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2LaNIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 08:08:34 -0500
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Add minimal APIs for writing to the IPC and the M3_TXEV registers
in the Control module. These will be used in a subsequent patch which
adds suspend-resume support for AM33XX.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Tony Lingren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
v1->v2:
	This a new patch in the series to isolate
	the control module accesses as pointed out
	by Kevin Hilman.

 arch/arm/mach-omap2/control.c |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/control.h |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2adb268..c5d54ae 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -604,3 +604,23 @@ int omap3_ctrl_save_padconf(void)
 }
 
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
+
+#if defined(CONFIG_SOC_AM33XX) && defined(CONFIG_PM)
+void am33xx_txev_eoi(void)
+{
+	omap_ctrl_writel(AM33XX_M3_TXEV_ACK, AM33XX_CONTROL_M3_TXEV_EOI);
+}
+
+void am33xx_txev_enable(void)
+{
+	omap_ctrl_writel(AM33XX_M3_TXEV_ENABLE, AM33XX_CONTROL_M3_TXEV_EOI);
+}
+
+void am33xx_wkup_m3_ipc_cmd(struct am33xx_ipc_data *data)
+{
+	omap_ctrl_writel(data->resume_addr, AM33XX_CONTROL_IPC_MSG_REG0);
+	omap_ctrl_writel(data->sleep_mode, AM33XX_CONTROL_IPC_MSG_REG1);
+	omap_ctrl_writel(data->param1, AM33XX_CONTROL_IPC_MSG_REG2);
+	omap_ctrl_writel(data->param2, AM33XX_CONTROL_IPC_MSG_REG3);
+}
+#endif /* CONFIG_SOC_AM33XX && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 3d944d3..4b05eb9 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -358,6 +358,37 @@
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
 
+#define AM33XX_DDR_IO_CTRL		0x0E04
+#define AM33XX_VTP0_CTRL_REG		0x0E0C
+
+/* AM33XX VTP0_CTRL_REG bits */
+#define AM33XX_VTP_CTRL_START_EN	(1 << 0)
+#define AM33XX_VTP_CTRL_LOCK_EN		(1 << 4)
+#define AM33XX_VTP_CTRL_READY		(1 << 5)
+#define AM33XX_VTP_CTRL_ENABLE		(1 << 6)
+
+/* AM33XX M3_TXEV_EOI register */
+#define AM33XX_CONTROL_M3_TXEV_EOI	0x1324
+
+#define AM33XX_M3_TXEV_ACK		(0x1 << 0)
+#define AM33XX_M3_TXEV_ENABLE		(0x0 << 0)
+
+/* AM33XX IPC message registers */
+#define AM33XX_CONTROL_IPC_MSG_REG0	0x1328
+#define AM33XX_CONTROL_IPC_MSG_REG1	0x132C
+#define AM33XX_CONTROL_IPC_MSG_REG2	0x1330
+#define AM33XX_CONTROL_IPC_MSG_REG3	0x1334
+#define AM33XX_CONTROL_IPC_MSG_REG4	0x1338
+#define AM33XX_CONTROL_IPC_MSG_REG5	0x133C
+#define AM33XX_CONTROL_IPC_MSG_REG6	0x1340
+#define AM33XX_CONTROL_IPC_MSG_REG7	0x1344
+
+#define AM33XX_DDR_CMD0_IOCTRL		0x1404
+#define AM33XX_DDR_CMD1_IOCTRL		0x1408
+#define AM33XX_DDR_CMD2_IOCTRL		0x140C
+#define AM33XX_DDR_DATA0_IOCTRL		0x1440
+#define AM33XX_DDR_DATA1_IOCTRL		0x1444
+
 /* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
@@ -417,6 +448,16 @@ extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
+struct am33xx_ipc_data {
+	u32 resume_addr;
+	u32 param1;
+	u32 param2;
+	u32 sleep_mode;
+};
+extern void am33xx_wkup_m3_ipc_cmd(struct am33xx_ipc_data *data);
+extern void am33xx_txev_eoi(void);
+extern void am33xx_txev_enable(void);
+
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
-- 
1.7.0.4

