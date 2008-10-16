From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 22/28] [OMAPZOOM] ARM: OMAP: Add CSI2 register defines.
Date: Wed, 15 Oct 2008 20:33:57 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568857@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47413 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbYJPBeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:34:05 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1XxJM021475
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:34:04 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1XxZo019908
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:33:59 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

ARM: OMAP: Add CSI2 register defines.

Add CSI2 register defines to ispreg.h.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/ispreg.h |  403 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 394 insertions(+), 9 deletions(-)

Index: omapkernel/drivers/media/video/isp/ispreg.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispreg.h    2008-10-14 18:51:35.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispreg.h 2008-10-14 18:51:56.000000000 -0500
@@ -238,15 +238,6 @@
 #define ISPCSI2_COMPLEXIO1_IRQENABLE   0x480BD860
 #define ISPCSI2_DBG_P                  0x480BD868
 #define ISPCSI2_TIMING                 0x480BD86C
-#define ISPCSI2_CTX_CTRL1(n)           (0x480BD870+0x20*(n))
-#define ISPCSI2_CTX_CTRL2(n)           (0x480BD874+0x20*(n))
-#define ISPCSI2_CTX_DAT_OFST(n)                (0x480BD878+0x20*(n))
-#define ISPCSI2_CTX_DAT_PING_ADDR(n)   (0x480BD87C+0x20*(n))
-#define ISPCSI2_CTX_DAT_PONG_ADDR(n)   (0x480BD880+0x20*(n))
-#define ISPCSI2_CTX_IRQENABLE(n)       (0x480BD884+0x20*(n))
-#define ISPCSI2_CTX_IRQSTATUS(n)       (0x480BD888+0x20*(n))
-#define ISPCSI2_CTX_CTRL3(n)           (0x480BD88C+0x20*(n))
-
 #define ISP_CSIB_SYSCONFIG             ISPCSI1_SYSCONFIG
 #define ISP_CSIA_SYSCONFIG             ISPCSI2_SYSCONFIG

@@ -726,6 +717,7 @@
 #define ISPCTRL_SYNC_DETECT_HSRISE     (0x1 << ISPCTRL_SYNC_DETECT_SHIFT)
 #define ISPCTRL_SYNC_DETECT_VSFALL     (0x2 << ISPCTRL_SYNC_DETECT_SHIFT)
 #define ISPCTRL_SYNC_DETECT_VSRISE     (0x3 << ISPCTRL_SYNC_DETECT_SHIFT)
+#define ISPCTRL_SYNC_DETECT_MASK       (0x3 << ISPCTRL_SYNC_DETECT_SHIFT)

 #define ISPCTRL_CCDC_RAM_EN            (1 << 16)
 #define ISPCTRL_PREV_RAM_EN            (1 << 17)
@@ -890,6 +882,8 @@
 #define ISPCCDC_CFG_BW656                      (1 << 5)
 #define ISPCCDC_CFG_FIDMD_SHIFT                        6
 #define ISPCCDC_CFG_WENLOG                     (1 << 8)
+#define ISPCCDC_CFG_WENLOG_AND                 (0 << 8)
+#define ISPCCDC_CFG_WENLOG_OR          (1 << 8)
 #define ISPCCDC_CFG_Y8POS                      (1 << 11)
 #define ISPCCDC_CFG_BSWD                       (1 << 12)
 #define ISPCCDC_CFG_MSBINVI                    (1 << 13)
@@ -1280,4 +1274,395 @@
 #define ISPCSI1_MIDLEMODE_NOSTANDBY            0x1
 #define ISPCSI1_MIDLEMODE_SMARTSTANDBY         0x2

+/* CSI2 receiver registers (ES2.0) */
+#define ISPCSI2_REVISION                       0x480BD800
+#define ISPCSI2_SYSCONFIG                      0x480BD810
+#define ISPCSI2_SYSCONFIG_MSTANDBY_MODE_SHIFT  12
+#define ISPCSI2_SYSCONFIG_MSTANDBY_MODE_MASK \
+                               (0x3 << ISPCSI2_SYSCONFIG_MSTANDBY_MODE_SHIFT)
+#define ISPCSI2_SYSCONFIG_MSTANDBY_MODE_FORCE \
+                               (0x0 << ISPCSI2_SYSCONFIG_MSTANDBY_MODE_SHIFT)
+#define ISPCSI2_SYSCONFIG_MSTANDBY_MODE_NO \
+                               (0x1 << ISPCSI2_SYSCONFIG_MSTANDBY_MODE_SHIFT)
+#define ISPCSI2_SYSCONFIG_MSTANDBY_MODE_SMART \
+                               (0x2 << ISPCSI2_SYSCONFIG_MSTANDBY_MODE_SHIFT)
+#define ISPCSI2_SYSCONFIG_SOFT_RESET_SHIFT     1
+#define ISPCSI2_SYSCONFIG_SOFT_RESET_MASK \
+                               (0x1 << ISPCSI2_SYSCONFIG_SOFT_RESET_SHIFT)
+#define ISPCSI2_SYSCONFIG_SOFT_RESET_NORMAL \
+                               (0x0 << ISPCSI2_SYSCONFIG_SOFT_RESET_SHIFT)
+#define ISPCSI2_SYSCONFIG_SOFT_RESET_RESET \
+                               (0x1 << ISPCSI2_SYSCONFIG_SOFT_RESET_SHIFT)
+#define ISPCSI2_SYSCONFIG_AUTO_IDLE_SHIFT      0
+#define ISPCSI2_SYSCONFIG_AUTO_IDLE_MASK \
+                               (0x1 << ISPCSI2_SYSCONFIG_AUTO_IDLE_SHIFT)
+#define ISPCSI2_SYSCONFIG_AUTO_IDLE_FREE \
+                               (0x0 << ISPCSI2_SYSCONFIG_AUTO_IDLE_SHIFT)
+#define ISPCSI2_SYSCONFIG_AUTO_IDLE_AUTO \
+                               (0x1 << ISPCSI2_SYSCONFIG_AUTO_IDLE_SHIFT)
+#define ISPCSI2_SYSSTATUS                      0x480BD814
+#define ISPCSI2_SYSSTATUS_RESET_DONE_SHIFT     0
+#define ISPCSI2_SYSSTATUS_RESET_DONE_MASK \
+                               (0x1 << ISPCSI2_SYSSTATUS_RESET_DONE_SHIFT)
+#define ISPCSI2_SYSSTATUS_RESET_DONE_ONGOING \
+                               (0x0 << ISPCSI2_SYSSTATUS_RESET_DONE_SHIFT)
+#define ISPCSI2_SYSSTATUS_RESET_DONE_DONE \
+                               (0x1 << ISPCSI2_SYSSTATUS_RESET_DONE_SHIFT)
+#define ISPCSI2_IRQSTATUS                              0x480BD818
+#define ISPCSI2_IRQSTATUS_OCP_ERR_IRQ                  (1 << 14)
+#define ISPCSI2_IRQSTATUS_SHORT_PACKET_IRQ             (1 << 13)
+#define ISPCSI2_IRQSTATUS_ECC_CORRECTION_IRQ           (1 << 12)
+#define ISPCSI2_IRQSTATUS_ECC_NO_CORRECTION_IRQ                (1 << 11)
+#define ISPCSI2_IRQSTATUS_COMPLEXIO2_ERR_IRQ           (1 << 10)
+#define ISPCSI2_IRQSTATUS_COMPLEXIO1_ERR_IRQ           (1 << 9)
+#define ISPCSI2_IRQSTATUS_FIFO_OVF_IRQ                 (1 << 8)
+#define ISPCSI2_IRQSTATUS_CONTEXT(n)                   (1 << (n))
+
+#define ISPCSI2_IRQENABLE                      0x480BD81C
+#define ISPCSI2_CTRL                           0x480BD840
+#define ISPCSI2_CTRL_VP_CLK_EN_SHIFT   15
+#define ISPCSI2_CTRL_VP_CLK_EN_MASK    (0x1 << ISPCSI2_CTRL_VP_CLK_EN_SHIFT)
+#define ISPCSI2_CTRL_VP_CLK_EN_DISABLE (0x0 << ISPCSI2_CTRL_VP_CLK_EN_SHIFT)
+#define ISPCSI2_CTRL_VP_CLK_EN_ENABLE  (0x1 << ISPCSI2_CTRL_VP_CLK_EN_SHIFT)
+
+#define ISPCSI2_CTRL_VP_ONLY_EN_SHIFT  11
+#define ISPCSI2_CTRL_VP_ONLY_EN_MASK   (0x1 << ISPCSI2_CTRL_VP_ONLY_EN_SHIFT)
+#define ISPCSI2_CTRL_VP_ONLY_EN_DISABLE        (0x0 << ISPCSI2_CTRL_VP_ONLY_EN_SHIFT)
+#define ISPCSI2_CTRL_VP_ONLY_EN_ENABLE (0x1 << ISPCSI2_CTRL_VP_ONLY_EN_SHIFT)
+
+#define ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT         8
+#define ISPCSI2_CTRL_VP_OUT_CTRL_MASK          (0x3 << \
+                                               ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT)
+#define ISPCSI2_CTRL_VP_OUT_CTRL_DISABLE       (0x0 << \
+                                               ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT)
+#define ISPCSI2_CTRL_VP_OUT_CTRL_DIV2          (0x1 << \
+                                               ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT)
+#define ISPCSI2_CTRL_VP_OUT_CTRL_DIV3          (0x2 << \
+                                               ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT)
+#define ISPCSI2_CTRL_VP_OUT_CTRL_DIV4          (0x3 << \
+                                               ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT)
+
+#define ISPCSI2_CTRL_DBG_EN_SHIFT      7
+#define ISPCSI2_CTRL_DBG_EN_MASK       (0x1 << ISPCSI2_CTRL_DBG_EN_SHIFT)
+#define ISPCSI2_CTRL_DBG_EN_DISABLE    (0x0 << ISPCSI2_CTRL_DBG_EN_SHIFT)
+#define ISPCSI2_CTRL_DBG_EN_ENABLE     (0x1 << ISPCSI2_CTRL_DBG_EN_SHIFT)
+
+#define ISPCSI2_CTRL_BURST_SIZE_SHIFT          5
+#define ISPCSI2_CTRL_BURST_SIZE_MASK           (0x3 << \
+                                               ISPCSI2_CTRL_BURST_SIZE_SHIFT)
+#define ISPCSI2_CTRL_BURST_SIZE_MYSTERY_VAL            (0x2 << \
+                                               ISPCSI2_CTRL_BURST_SIZE_SHIFT)
+
+#define ISPCSI2_CTRL_FRAME_SHIFT       3
+#define ISPCSI2_CTRL_FRAME_MASK                (0x1 << ISPCSI2_CTRL_FRAME_SHIFT)
+#define ISPCSI2_CTRL_FRAME_DISABLE_IMM (0x0 << ISPCSI2_CTRL_FRAME_SHIFT)
+#define ISPCSI2_CTRL_FRAME_DISABLE_FEC (0x1 << ISPCSI2_CTRL_FRAME_SHIFT)
+
+#define ISPCSI2_CTRL_ECC_EN_SHIFT      2
+#define ISPCSI2_CTRL_ECC_EN_MASK       (0x1 << ISPCSI2_CTRL_ECC_EN_SHIFT)
+#define ISPCSI2_CTRL_ECC_EN_DISABLE    (0x0 << ISPCSI2_CTRL_ECC_EN_SHIFT)
+#define ISPCSI2_CTRL_ECC_EN_ENABLE     (0x1 << ISPCSI2_CTRL_ECC_EN_SHIFT)
+
+#define ISPCSI2_CTRL_SECURE_SHIFT      1
+#define ISPCSI2_CTRL_SECURE_MASK       (0x1 << ISPCSI2_CTRL_SECURE_SHIFT)
+#define ISPCSI2_CTRL_SECURE_DISABLE    (0x0 << ISPCSI2_CTRL_SECURE_SHIFT)
+#define ISPCSI2_CTRL_SECURE_ENABLE     (0x1 << ISPCSI2_CTRL_SECURE_SHIFT)
+
+#define ISPCSI2_CTRL_IF_EN_SHIFT       0
+#define ISPCSI2_CTRL_IF_EN_MASK                (0x1 << ISPCSI2_CTRL_IF_EN_SHIFT)
+#define ISPCSI2_CTRL_IF_EN_DISABLE     (0x0 << ISPCSI2_CTRL_IF_EN_SHIFT)
+#define ISPCSI2_CTRL_IF_EN_ENABLE      (0x1 << ISPCSI2_CTRL_IF_EN_SHIFT)
+
+#define ISPCSI2_DBG_H                          0x480BD844
+#define ISPCSI2_GNQ                            0x480BD848
+#define ISPCSI2_COMPLEXIO_CFG1                 0x480BD850
+#define ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_SHIFT                29
+#define ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_MASK \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_ONGOING \
+                       (0x0 << ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_DONE \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_RESET_DONE_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_SHIFT           27
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_MASK \
+                       (0x3 << ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_OFF \
+                       (0x0 << ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_ON \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_ULPW \
+                       (0x2 << ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_SHIFT                25
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_MASK \
+                       (0x3 << ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_OFF \
+                       (0x0 << ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_ON \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_ULPW \
+                       (0x2 << ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_SHIFT          24
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_MASK \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_DISABLE \
+                       (0x0 << ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_ENABLE \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_SHIFT)
+
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(n)       (3 + ((n) * 4))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POL_MASK(n) (0x1 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POL_PN(n) (0x0 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POL_NP(n) (0x1 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(n))
+
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n)  ((n) * 4)
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_MASK(n)   (0x7 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_NC(n)     (0x0 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_1(n)      (0x1 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_2(n)      (0x2 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_3(n)      (0x3 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_4(n)      (0x4 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+#define ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_5(n)      (0x5 << \
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(n))
+
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_SHIFT         3
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_MASK \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_PN \
+                       (0x0 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_NP \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_SHIFT)
+
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT            0
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_MASK \
+                       (0x7 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_1 \
+                       (0x1 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_2 \
+                       (0x2 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_3 \
+                       (0x3 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_4 \
+                       (0x4 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT)
+#define ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_5 \
+                       (0x5 << ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT)
+
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS                   0x480BD854
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEALLULPMEXIT  (1 << 26)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEALLULPMENTER (1 << 25)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEULPM5                (1 << 24)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEULPM4                (1 << 23)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEULPM3                (1 << 22)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEULPM2                (1 << 21)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_STATEULPM1                (1 << 20)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRCONTROL5       (1 << 19)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRCONTROL4       (1 << 18)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRCONTROL3       (1 << 17)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRCONTROL2       (1 << 16)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRCONTROL1       (1 << 15)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRESC5           (1 << 14)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRESC4           (1 << 13)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRESC3           (1 << 12)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRESC2           (1 << 11)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRESC1           (1 << 10)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTSYNCHS5     (1 << 9)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTSYNCHS4     (1 << 8)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTSYNCHS3     (1 << 7)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTSYNCHS2     (1 << 6)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTSYNCHS1     (1 << 5)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTHS5         (1 << 4)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTHS4         (1 << 3)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTHS3         (1 << 2)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTHS2         (1 << 1)
+#define ISPCSI2_COMPLEXIO1_IRQSTATUS_ERRSOTHS1         1
+
+#define ISPCSI2_SHORT_PACKET           0x480BD85C
+#define ISPCSI2_COMPLEXIO1_IRQENABLE                   0x480BD860
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEALLULPMEXIT  (1 << 26)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEALLULPMENTER (1 << 25)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM5                (1 << 24)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM4                (1 << 23)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM3                (1 << 22)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM2                (1 << 21)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM1                (1 << 20)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL5       (1 << 19)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL4       (1 << 18)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL3       (1 << 17)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL2       (1 << 16)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL1       (1 << 15)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC5           (1 << 14)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC4           (1 << 13)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC3           (1 << 12)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC2           (1 << 11)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC1           (1 << 10)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS5     (1 << 9)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS4     (1 << 8)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS3     (1 << 7)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS2     (1 << 6)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS1     (1 << 5)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS5         (1 << 4)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS4         (1 << 3)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS3         (1 << 2)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS2         (1 << 1)
+#define ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS1         1
+#define ISPCSI2_DBG_P                  0x480BD868
+#define ISPCSI2_TIMING                 0x480BD86C
+
+
+#define ISPCSI2_TIMING_FORCE_RX_MODE_IO_SHIFT(n)       ((16 * ((n) - 1)) + 15)
+#define ISPCSI2_TIMING_FORCE_RX_MODE_IO_MASK(n)        (0x1 << \
+                               ISPCSI2_TIMING_FORCE_RX_MODE_IO_SHIFT(n))
+#define ISPCSI2_TIMING_FORCE_RX_MODE_IO_DISABLE(n)     (0x0 << \
+                               ISPCSI2_TIMING_FORCE_RX_MODE_IO_SHIFT(n))
+#define ISPCSI2_TIMING_FORCE_RX_MODE_IO_ENABLE(n)      (0x1 << \
+                               ISPCSI2_TIMING_FORCE_RX_MODE_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_X16_IO_SHIFT(n)      ((16 * ((n) - 1)) + 14)
+#define ISPCSI2_TIMING_STOP_STATE_X16_IO_MASK(n)       (0x1 << \
+                               ISPCSI2_TIMING_STOP_STATE_X16_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_X16_IO_DISABLE(n)    (0x0 << \
+                               ISPCSI2_TIMING_STOP_STATE_X16_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_X16_IO_ENABLE(n)     (0x1 << \
+                               ISPCSI2_TIMING_STOP_STATE_X16_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_X4_IO_SHIFT(n)       ((16 * ((n) - 1)) + 13)
+#define ISPCSI2_TIMING_STOP_STATE_X4_IO_MASK(n)                (0x1 << \
+                               ISPCSI2_TIMING_STOP_STATE_X4_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_X4_IO_DISABLE(n)     (0x0 << \
+                               ISPCSI2_TIMING_STOP_STATE_X4_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_X4_IO_ENABLE(n)              (0x1 << \
+                               ISPCSI2_TIMING_STOP_STATE_X4_IO_SHIFT(n))
+#define ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_SHIFT(n)  (16 * ((n) - 1))
+#define ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_MASK(n)   (0x1FFF << \
+                               ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_SHIFT(n))
+
+#define ISPCSI2_CTX_CTRL1(n)           (0x480BD870 + 0x20 * (n))
+#define ISPCSI2_CTX_CTRL1_COUNT_SHIFT          8
+#define ISPCSI2_CTX_CTRL1_COUNT_MASK           (0xFF << \
+                                               ISPCSI2_CTX_CTRL1_COUNT_SHIFT)
+#define ISPCSI2_CTX_CTRL1_EOF_EN_SHIFT         7
+#define ISPCSI2_CTX_CTRL1_EOF_EN_MASK          (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_EOF_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_EOF_EN_DISABLE       (0x0 << \
+                                               ISPCSI2_CTX_CTRL1_EOF_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_EOF_EN_ENABLE                (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_EOF_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_EOL_EN_SHIFT         6
+#define ISPCSI2_CTX_CTRL1_EOL_EN_MASK          (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_EOL_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_EOL_EN_DISABLE       (0x0 << \
+                                               ISPCSI2_CTX_CTRL1_EOL_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_EOL_EN_ENABLE                (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_EOL_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_CS_EN_SHIFT          5
+#define ISPCSI2_CTX_CTRL1_CS_EN_MASK           (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_CS_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_CS_EN_DISABLE                (0x0 << \
+                                               ISPCSI2_CTX_CTRL1_CS_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_CS_EN_ENABLE         (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_CS_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_SHIFT                4
+#define ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_MASK         (0x1 << \
+                                       ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_DISABLE      (0x0 << \
+                                       ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_ENABLE       (0x1 << \
+                                       ISPCSI2_CTX_CTRL1_COUNT_UNLOCK_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_PING_PONG_SHIFT      3
+#define ISPCSI2_CTX_CTRL1_PING_PONG_MASK       (0x1 << \
+                                       ISPCSI2_CTX_CTRL1_PING_PONG_SHIFT)
+#define ISPCSI2_CTX_CTRL1_CTX_EN_SHIFT         0
+#define ISPCSI2_CTX_CTRL1_CTX_EN_MASK          (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_CTX_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_CTX_EN_DISABLE       (0x0 << \
+                                               ISPCSI2_CTX_CTRL1_CTX_EN_SHIFT)
+#define ISPCSI2_CTX_CTRL1_CTX_EN_ENABLE                (0x1 << \
+                                               ISPCSI2_CTX_CTRL1_CTX_EN_SHIFT)
+
+#define ISPCSI2_CTX_CTRL2(n)           (0x480BD874 + 0x20 * (n))
+#define ISPCSI2_CTX_CTRL2_VIRTUAL_ID_SHIFT     11
+#define ISPCSI2_CTX_CTRL2_VIRTUAL_ID_MASK      (0x3 << \
+                                       ISPCSI2_CTX_CTRL2_VIRTUAL_ID_SHIFT)
+#define ISPCSI2_CTX_CTRL2_FORMAT_SHIFT 0
+#define ISPCSI2_CTX_CTRL2_FORMAT_MASK  (0x3FF << \
+                                       ISPCSI2_CTX_CTRL2_FORMAT_SHIFT)
+
+#define ISPCSI2_CTX_DAT_OFST(n)                (0x480BD878 + 0x20 * (n))
+#define ISPCSI2_CTX_DAT_OFST_OFST_SHIFT        5
+#define ISPCSI2_CTX_DAT_OFST_OFST_MASK (0x7FF << \
+                                               ISPCSI2_CTX_DAT_OFST_OFST_SHIFT)
+
+#define ISPCSI2_CTX_DAT_PING_ADDR(n)   (0x480BD87C + 0x20 * (n))
+#define ISPCSI2_CTX_DAT_PONG_ADDR(n)   (0x480BD880 + 0x20 * (n))
+#define ISPCSI2_CTX_IRQENABLE(n)       (0x480BD884 + 0x20 * (n))
+#define ISPCSI2_CTX_IRQENABLE_ECC_CORRECTION_IRQ               (1 << 8)
+#define ISPCSI2_CTX_IRQENABLE_LINE_NUMBER_IRQ          (1 << 7)
+#define ISPCSI2_CTX_IRQENABLE_FRAME_NUMBER_IRQ         (1 << 6)
+#define ISPCSI2_CTX_IRQENABLE_CS_IRQ                   (1 << 5)
+#define ISPCSI2_CTX_IRQENABLE_LE_IRQ                   (1 << 3)
+#define ISPCSI2_CTX_IRQENABLE_LS_IRQ                   (1 << 2)
+#define ISPCSI2_CTX_IRQENABLE_FE_IRQ                   (1 << 1)
+#define ISPCSI2_CTX_IRQENABLE_FS_IRQ                   1
+#define ISPCSI2_CTX_IRQSTATUS(n)       (0x480BD888 + 0x20 * (n))
+#define ISPCSI2_CTX_IRQSTATUS_ECC_CORRECTION_IRQ               (1 << 8)
+#define ISPCSI2_CTX_IRQSTATUS_LINE_NUMBER_IRQ          (1 << 7)
+#define ISPCSI2_CTX_IRQSTATUS_FRAME_NUMBER_IRQ         (1 << 6)
+#define ISPCSI2_CTX_IRQSTATUS_CS_IRQ                   (1 << 5)
+#define ISPCSI2_CTX_IRQSTATUS_LE_IRQ                   (1 << 3)
+#define ISPCSI2_CTX_IRQSTATUS_LS_IRQ                   (1 << 2)
+#define ISPCSI2_CTX_IRQSTATUS_FE_IRQ                   (1 << 1)
+#define ISPCSI2_CTX_IRQSTATUS_FS_IRQ                   1
+
+#define ISPCSI2_CTX_CTRL3(n)           (0x480BD88C + 0x20 * (n))
+#define ISPCSI2_CTX_CTRL3_ALPHA_SHIFT  5
+#define ISPCSI2_CTX_CTRL3_ALPHA_MASK   (0x3FFF << \
+                                               ISPCSI2_CTX_CTRL3_ALPHA_SHIFT)
+
+#define ISPCSI2PHY_CFG0                                0x480BD970
+#define ISPCSI2PHY_CFG0_THS_TERM_SHIFT         8
+#define ISPCSI2PHY_CFG0_THS_TERM_MASK \
+                               (0xFF << ISPCSI2PHY_CFG0_THS_TERM_SHIFT)
+#define ISPCSI2PHY_CFG0_THS_TERM_RESETVAL \
+                               (0x04 << ISPCSI2PHY_CFG0_THS_TERM_SHIFT)
+#define ISPCSI2PHY_CFG0_THS_SETTLE_SHIFT               0
+#define ISPCSI2PHY_CFG0_THS_SETTLE_MASK \
+                               (0xFF << ISPCSI2PHY_CFG0_THS_SETTLE_SHIFT)
+#define ISPCSI2PHY_CFG0_THS_SETTLE_RESETVAL \
+                               (0x27 << ISPCSI2PHY_CFG0_THS_SETTLE_SHIFT)
+#define ISPCSI2PHY_CFG1                                0x480BD974
+#define ISPCSI2PHY_CFG1_TCLK_TERM_SHIFT                18
+#define ISPCSI2PHY_CFG1_TCLK_TERM_MASK \
+                               (0x7F << ISPCSI2PHY_CFG1_TCLK_TERM_SHIFT)
+#define ISPCSI2PHY_CFG1_TCLK_TERM__RESETVAL \
+                               (0x00 << ISPCSI2PHY_CFG1_TCLK_TERM_SHIFT)
+#define ISPCSI2PHY_CFG1_RESERVED1_SHIFT                10
+#define ISPCSI2PHY_CFG1_RESERVED1_MASK \
+                               (0xFF << ISPCSI2PHY_CFG1_RESERVED1_SHIFT)
+#define ISPCSI2PHY_CFG1_RESERVED1__RESETVAL \
+                               (0xB8 << ISPCSI2PHY_CFG1_RESERVED1_SHIFT)
+#define ISPCSI2PHY_CFG1_TCLK_MISS_SHIFT                8
+#define ISPCSI2PHY_CFG1_TCLK_MISS_MASK \
+                               (0x3 << ISPCSI2PHY_CFG1_TCLK_MISS_SHIFT)
+#define ISPCSI2PHY_CFG1_TCLK_MISS__RESETVAL \
+                               (0x1 << ISPCSI2PHY_CFG1_TCLK_MISS_SHIFT)
+#define ISPCSI2PHY_CFG1_TCLK_SETTLE_SHIFT              0
+#define ISPCSI2PHY_CFG1_TCLK_SETTLE_MASK \
+                               (0xFF << ISPCSI2PHY_CFG1_TCLK_TERM_SHIFT)
+#define ISPCSI2PHY_CFG1_TCLK_SETTLE__RESETVAL \
+                               (0x0E << ISPCSI2PHY_CFG1_TCLK_TERM_SHIFT)
+#define ISPCSI2PHY_CFG1__RESETVAL      (ISPCSI2PHY_CFG1_TCLK_TERM__RESETVAL | \
+                                       ISPCSI2PHY_CFG1_RESERVED1__RESETVAL | \
+                                       ISPCSI2PHY_CFG1_TCLK_MISS__RESETVAL | \
+                                       ISPCSI2PHY_CFG1_TCLK_SETTLE__RESETVAL)
+#define ISPCSI2PHY_CFG1__EDITABLE_MASK (ISPCSI2PHY_CFG1_TCLK_TERM_MASK | \
+                                       ISPCSI2PHY_CFG1_RESERVED1_MASK | \
+                                       ISPCSI2PHY_CFG1_TCLK_MISS_MASK | \
+                                       ISPCSI2PHY_CFG1_TCLK_SETTLE_MASK)
+
 #endif /* __ISPREG_H__ */
