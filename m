From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [REVIEW PATCH 07/14] OMAP: CAM: Add ISP CSI2 API
Date: Thu, 11 Dec 2008 14:38:04 -0600
Message-ID: <A24693684029E5489D1D202277BE894415E6E19C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla,
	Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

>From c442f389de719b47f8ec63f0ae07b5e2c2ef7b9d Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Thu, 11 Dec 2008 13:35:49 -0600
Subject: [PATCH] OMAP: CAM: Add ISP CSI2 API

Add ISP CSI2 API for operating OMAP3430 CSI2 receiver registers

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/ispcsi2.c | 2106 +++++++++++++++++++++++++++++++=
++++++
 drivers/media/video/isp/ispcsi2.h |  232 ++++
 2 files changed, 2338 insertions(+), 0 deletions(-)
 create mode 100644 drivers/media/video/isp/ispcsi2.c
 create mode 100644 drivers/media/video/isp/ispcsi2.h

diff --git a/drivers/media/video/isp/ispcsi2.c b/drivers/media/video/isp/=
ispcsi2.c
new file mode 100644
index 0000000..423ea3a
--- /dev/null
+++ b/drivers/media/video/isp/ispcsi2.c
@@ -0,0 +1,2106 @@
+/*
+ * drivers/media/video/isp/ispcsi2.c
+ *
+ * Driver Library for ISP CSI Control module in TI's OMAP3 Camera ISP
+ * ISP CSI interface and IRQ related APIs are defined here.
+ *
+ * Copyright (C) 2008 Texas Instruments.
+ *
+ * Contributors:
+ *     Sergio Aguirre <saaguirre@ti.com>
+ *     Dominic Curran <dcurran@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <asm/mach-types.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-int-device.h>
+#include <linux/io.h>
+#include <mach/io.h>
+
+#include "isp.h"
+#include "ispreg.h"
+#include "ispcsi2.h"
+
+static struct isp_csi2_cfg current_csi2_cfg;
+static struct isp_csi2_cfg_update current_csi2_cfg_update;
+
+static bool update_complexio_cfg1;
+static bool update_phy_cfg0;
+static bool update_phy_cfg1;
+static bool update_ctx_ctrl1[8];
+static bool update_ctx_ctrl2[8];
+static bool update_ctx_ctrl3[8];
+static bool update_timing;
+static bool update_ctrl;
+static bool uses_videoport;
+
+/**
+ * isp_csi2_complexio_lanes_config - Configuration of CSI2 ComplexIO lan=
es.
+ * @reqcfg: Pointer to structure containing desired lane configuration
+ *
+ * Validates and saves to internal driver memory the passed configuratio=
n.
+ * Returns 0 if successful, or -EINVAL if null pointer is passed, invali=
d
+ * lane position or polarity is set, and if 2 lanes try to occupy the sa=
me
+ * position. To apply this settings, use the isp_csi2_complexio_lanes_up=
date()
+ * function just after calling this function.
+ **/
+int isp_csi2_complexio_lanes_config(struct isp_csi2_lanes_cfg *reqcfg)
+{
+       int i;
+       bool pos_occupied[5] =3D {false, false, false, false, false};
+       struct isp_csi2_lanes_cfg *currlanes =3D &current_csi2_cfg.lanes;
+       struct isp_csi2_lanes_cfg_update *currlanes_u =3D
+                                       &current_csi2_cfg_update.lanes;
+
+       /* Validating parameters sent by driver */
+       if (reqcfg =3D=3D NULL) {
+               printk(KERN_ERR "Invalid Complex IO Configuration sent by=
"
+                                                               " sensor\=
n");
+               goto err_einval;
+       }
+
+       /* Data lanes verification */
+       for (i =3D 0; i < 4; i++) {
+               if ((reqcfg->data[i].pol > 1) || (reqcfg->data[i].pos > 5=
)) {
+                       printk(KERN_ERR "Invalid CSI-2 Complex IO configu=
ration"
+                                       " parameters for data lane #%d\n"=
, i);
+                       goto err_einval;
+               }
+               if ((pos_occupied[reqcfg->data[i].pos - 1] =3D=3D true) &=
&
+                                               reqcfg->data[i].pos > 0) =
{
+                       printk(KERN_ERR "Lane #%d already occupied\n",
+                                                       reqcfg->data[i].p=
os);
+                       goto err_einval;
+               } else
+                       pos_occupied[reqcfg->data[i].pos - 1] =3D true;
+       }
+
+       /* Clock lane verification */
+       if ((reqcfg->clk.pol > 1) || (reqcfg->clk.pos > 5) ||
+                                               (reqcfg->clk.pos =3D=3D 0=
)) {
+               printk(KERN_ERR "Invalid CSI-2 Complex IO configuration"
+                                               " parameters for clock la=
ne\n");
+               goto err_einval;
+       }
+       if (pos_occupied[reqcfg->clk.pos - 1] =3D=3D true) {
+               printk(KERN_ERR "Lane #%d already occupied",
+                                                       reqcfg->clk.pos);
+               goto err_einval;
+       } else
+               pos_occupied[reqcfg->clk.pos - 1] =3D true;
+
+       for (i =3D 0; i < 4; i++) {
+               if (currlanes->data[i].pos !=3D reqcfg->data[i].pos) {
+                       currlanes->data[i].pos =3D reqcfg->data[i].pos;
+                       currlanes_u->data[i] =3D true;
+                       update_complexio_cfg1 =3D true;
+               }
+               if (currlanes->data[i].pol !=3D reqcfg->data[i].pol) {
+                       currlanes->data[i].pol =3D reqcfg->data[i].pol;
+                       currlanes_u->data[i] =3D true;
+                       update_complexio_cfg1 =3D true;
+               }
+       }
+
+       if (currlanes->clk.pos !=3D reqcfg->clk.pos) {
+               currlanes->clk.pos =3D reqcfg->clk.pos;
+               currlanes_u->clk =3D true;
+               update_complexio_cfg1 =3D true;
+       }
+       if (currlanes->clk.pol !=3D reqcfg->clk.pol) {
+               currlanes->clk.pol =3D reqcfg->clk.pol;
+               currlanes_u->clk =3D true;
+               update_complexio_cfg1 =3D true;
+       }
+       return 0;
+err_einval:
+       return -EINVAL;
+}
+
+/**
+ * isp_csi2_complexio_lanes_update - Applies CSI2 ComplexIO lanes config=
uration.
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_complexio_lanes_config() fun=
ction.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_complexio_lanes_config() function, unless the force_update f=
lag is
+ * set to true.
+ * Always returns 0.
+ **/
+int isp_csi2_complexio_lanes_update(bool force_update)
+{
+       struct isp_csi2_lanes_cfg *currlanes =3D &current_csi2_cfg.lanes;
+       struct isp_csi2_lanes_cfg_update *currlanes_u =3D
+                                       &current_csi2_cfg_update.lanes;
+       u32 reg;
+       int i;
+
+       if ((update_complexio_cfg1 =3D=3D false) && (force_update =3D=3D =
false))
+               return 0;
+
+       reg =3D omap_readl(ISPCSI2_COMPLEXIO_CFG1);
+       for (i =3D 0; i < 4; i++) {
+               if ((currlanes_u->data[i] =3D=3D true) || (force_update =3D=
=3D true)) {
+                       reg &=3D ~(ISPCSI2_COMPLEXIO_CFG1_DATA_POL_MASK(i=
 + 1) |
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_MASK=
(i +
+                                                                       1=
));
+                       reg |=3D (currlanes->data[i].pol <<
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(i +=
 1));
+                       reg |=3D (currlanes->data[i].pos <<
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIF=
T(i +
+                                                                       1=
));
+                       currlanes_u->data[i] =3D false;
+               }
+       }
+
+       if ((currlanes_u->clk =3D=3D true) || (force_update =3D=3D true))=
 {
+               reg &=3D ~(ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_MASK |
+                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_MAS=
K);
+               reg |=3D (currlanes->clk.pol <<
+                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_SHIFT);
+               reg |=3D (currlanes->clk.pos <<
+                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHI=
FT);
+               currlanes_u->clk =3D false;
+       }
+       omap_writel(reg, ISPCSI2_COMPLEXIO_CFG1);
+
+       update_complexio_cfg1 =3D false;
+       return 0;
+}
+
+/**
+ * isp_csi2_complexio_lanes_get - Gets CSI2 ComplexIO lanes configuratio=
n.
+ *
+ * Gets settings from HW registers and fills in the internal driver memo=
ry
+ * Always returns 0.
+ **/
+int isp_csi2_complexio_lanes_get(void)
+{
+       struct isp_csi2_lanes_cfg *currlanes =3D &current_csi2_cfg.lanes;
+       struct isp_csi2_lanes_cfg_update *currlanes_u =3D
+                                       &current_csi2_cfg_update.lanes;
+       u32 reg;
+       int i;
+
+       reg =3D omap_readl(ISPCSI2_COMPLEXIO_CFG1);
+       for (i =3D 0; i < 4; i++) {
+               currlanes->data[i].pol =3D (reg &
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_MASK(i + =
1)) >>
+                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(i +=
 1);
+               currlanes->data[i].pos =3D (reg &
+                       ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_MASK(i + 1))=
 >>
+                       ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(i + 1)=
;
+               currlanes_u->data[i] =3D false;
+       }
+       currlanes->clk.pol =3D (reg & ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_MA=
SK) >>
+                                       ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_=
SHIFT;
+       currlanes->clk.pos =3D (reg &
+                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_MAS=
K) >>
+                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHI=
FT;
+       currlanes_u->clk =3D false;
+
+       update_complexio_cfg1 =3D false;
+       return 0;
+}
+
+/**
+ * isp_csi2_complexio_power_status - Gets CSI2 ComplexIO power status.
+ *
+ * Returns 3 possible valid states: ISP_CSI2_POWER_OFF, ISP_CSI2_POWER_O=
N,
+ * and ISP_CSI2_POWER_ULPW.
+ **/
+static enum isp_csi2_power_cmds isp_csi2_complexio_power_status(void)
+{
+       enum isp_csi2_power_cmds ret;
+       u32 reg;
+
+       reg =3D omap_readl(ISPCSI2_COMPLEXIO_CFG1) &
+                                       ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS=
_MASK;
+       switch (reg) {
+       case ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_OFF:
+               ret =3D ISP_CSI2_POWER_OFF;
+               break;
+       case ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_ON:
+               ret =3D ISP_CSI2_POWER_ON;
+               break;
+       case ISPCSI2_COMPLEXIO_CFG1_PWR_STATUS_ULPW:
+               ret =3D ISP_CSI2_POWER_ULPW;
+               break;
+       default:
+               return -EINVAL;
+       }
+       return ret;
+}
+
+/**
+ * isp_csi2_complexio_power_autoswitch - Sets CSI2 ComplexIO power autos=
witch.
+ * @enable: Sets or clears the autoswitch function enable flag.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_complexio_power_autoswitch(bool enable)
+{
+       u32 reg;
+
+       reg =3D omap_readl(ISPCSI2_COMPLEXIO_CFG1);
+       reg &=3D ~ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_MASK;
+
+       if (enable =3D=3D true)
+               reg |=3D ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_ENABLE;
+       else
+               reg |=3D ISPCSI2_COMPLEXIO_CFG1_PWR_AUTO_DISABLE;
+
+       omap_writel(reg, ISPCSI2_COMPLEXIO_CFG1);
+       return 0;
+}
+
+/**
+ * isp_csi2_complexio_power - Sets the desired power command for CSI2 Co=
mplexIO.
+ * @power_cmd: Power command to be set.
+ *
+ * Returns 0 if successful, or -EBUSY if the retry count is exceeded.
+ **/
+int isp_csi2_complexio_power(enum isp_csi2_power_cmds power_cmd)
+{
+       enum isp_csi2_power_cmds current_state;
+       u32 reg;
+       u8 retry_count;
+
+       reg =3D omap_readl(ISPCSI2_COMPLEXIO_CFG1) &
+                                       ~ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_M=
ASK;
+       switch (power_cmd) {
+       case ISP_CSI2_POWER_OFF:
+               reg |=3D ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_OFF;
+               break;
+       case ISP_CSI2_POWER_ON:
+               reg |=3D ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_ON;
+               break;
+       case ISP_CSI2_POWER_ULPW:
+               reg |=3D ISPCSI2_COMPLEXIO_CFG1_PWR_CMD_ULPW;
+               break;
+       default:
+               printk(KERN_ERR "CSI2: ERROR - Wrong Power command!\n");
+               return -EINVAL;
+       }
+       omap_writel(reg, ISPCSI2_COMPLEXIO_CFG1);
+
+       retry_count =3D 0;
+       do {
+               udelay(50);
+               current_state =3D isp_csi2_complexio_power_status();
+
+               if (current_state !=3D power_cmd) {
+                       printk(KERN_DEBUG "CSI2: Complex IO power command=
 not"
+                                                               " yet tak=
en.");
+                       if (++retry_count < 100) {
+                               printk(KERN_DEBUG " Retrying...\n");
+                               udelay(50);
+                       } else {
+                               printk(KERN_DEBUG " Retry count exceeded!=
\n");
+                       }
+               }
+       } while ((current_state !=3D power_cmd) && (retry_count < 100));
+
+       if (retry_count =3D=3D 100)
+               return -EBUSY;
+
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_frame_mode - Configure if_en behaviour for CSI2
+ * @frame_mode: Desired action for IF_EN switch off. 0 - disable IF imme=
diately
+ *              1 - disable after all Frame end Code is received in all
+ *              contexts.
+ *
+ * Validates and saves to internal driver memory the passed configuratio=
n.
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_frame_mode(enum isp_csi2_frame_mode frame_mode)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->frame_mode !=3D frame_mode) {
+               currctrl->frame_mode =3D frame_mode;
+               currctrl_u->frame_mode =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_vp_clk_enable - Enables/disables CSI2 Videoport =
clock.
+ * @vp_clk_enable: Boolean value to specify the Videoport clock state.
+ *
+ * Validates and saves to internal driver memory the passed configuratio=
n.
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_vp_clk_enable(bool vp_clk_enable)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->vp_clk_enable !=3D vp_clk_enable) {
+               currctrl->vp_clk_enable =3D vp_clk_enable;
+               currctrl_u->vp_clk_enable =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_vp_only_enable - Sets CSI2 Videoport clock as ex=
clusive
+ * @vp_only_enable: Boolean value to specify if the Videoport clock is
+ *                  exclusive, setting the OCP port as disabled.
+ *
+ * Validates and saves to internal driver memory the passed configuratio=
n.
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_vp_only_enable(bool vp_only_enable)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->vp_only_enable !=3D vp_only_enable) {
+               currctrl->vp_only_enable =3D vp_only_enable;
+               currctrl_u->vp_only_enable =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_vp_out_ctrl - Sets CSI2 Videoport clock divider
+ * @vp_out_ctrl: Divider value for setting videoport clock frequency bas=
ed on
+ *               OCP port frequency, valid dividers are between 1 and 4.
+ *
+ * Validates and saves to internal driver memory the passed configuratio=
n.
+ * Returns 0 if successful, or -EINVAL if wrong divider value is passed.
+ **/
+int isp_csi2_ctrl_config_vp_out_ctrl(u8 vp_out_ctrl)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if ((vp_out_ctrl =3D=3D 0) || (vp_out_ctrl > 4)) {
+               printk(KERN_ERR "CSI2: Wrong divisor value. Must be betwe=
en"
+                                                               " 1 and 4=
");
+               return -EINVAL;
+       }
+
+       if (currctrl->vp_out_ctrl !=3D vp_out_ctrl) {
+               currctrl->vp_out_ctrl =3D vp_out_ctrl;
+               currctrl_u->vp_out_ctrl =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_debug_enable - Sets CSI2 debug
+ * @debug_enable: Boolean for setting debug configuration on CSI2.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_debug_enable(bool debug_enable)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->debug_enable !=3D debug_enable) {
+               currctrl->debug_enable =3D debug_enable;
+               currctrl_u->debug_enable =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_burst_size - Sets CSI2 burst size.
+ * @burst_size: Burst size of the memory saving capability of receiver.
+ *
+ * Returns 0 if successful, or -EINVAL if burst size is wrong.
+ **/
+int isp_csi2_ctrl_config_burst_size(u8 burst_size)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+       if (burst_size > 3) {
+               printk(KERN_ERR "CSI2: Wrong burst size. Must be between"
+                                                               " 0 and 3=
");
+               return -EINVAL;
+       }
+
+       if (currctrl->burst_size !=3D burst_size) {
+               currctrl->burst_size =3D burst_size;
+               currctrl_u->burst_size =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_ecc_enable - Enables ECC on CSI2 Receiver
+ * @ecc_enable: Boolean to enable/disable the CSI2 receiver ECC handling=
.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_ecc_enable(bool ecc_enable)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->ecc_enable !=3D ecc_enable) {
+               currctrl->ecc_enable =3D ecc_enable;
+               currctrl_u->ecc_enable =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_ecc_enable - Enables ECC on CSI2 Receiver
+ * @ecc_enable: Boolean to enable/disable the CSI2 receiver ECC handling=
.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_secure_mode(bool secure_mode)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->secure_mode !=3D secure_mode) {
+               currctrl->secure_mode =3D secure_mode;
+               currctrl_u->secure_mode =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_config_if_enable - Enables CSI2 Receiver interface.
+ * @if_enable: Boolean to enable/disable the CSI2 receiver interface.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_config_if_enable(bool if_enable)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+
+       if (currctrl->if_enable !=3D if_enable) {
+               currctrl->if_enable =3D if_enable;
+               currctrl_u->if_enable =3D true;
+               update_ctrl =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_update - Applies CSI2 control configuration.
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_ctrl_config_*() functions.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_ctrl_config_*() functions, unless the force_update flag is
+ * set to true.
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_update(bool force_update)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+       u32 reg;
+
+       if ((update_ctrl =3D=3D true) || (force_update =3D=3D true)) {
+               reg =3D omap_readl(ISPCSI2_CTRL);
+               if ((currctrl_u->frame_mode =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_CTRL_FRAME_MASK;
+                       if (currctrl->frame_mode)
+                               reg |=3D ISPCSI2_CTRL_FRAME_DISABLE_FEC;
+                       else
+                               reg |=3D ISPCSI2_CTRL_FRAME_DISABLE_IMM;
+                       currctrl_u->frame_mode =3D false;
+               }
+               if ((currctrl_u->vp_clk_enable =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_CTRL_VP_CLK_EN_MASK;
+                       if (currctrl->vp_clk_enable)
+                               reg |=3D ISPCSI2_CTRL_VP_CLK_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTRL_VP_CLK_EN_DISABLE;
+                       currctrl_u->vp_clk_enable =3D false;
+               }
+               if ((currctrl_u->vp_only_enable =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~ISPCSI2_CTRL_VP_ONLY_EN_MASK;
+                       uses_videoport =3D currctrl->vp_only_enable;
+                       if (currctrl->vp_only_enable)
+                               reg |=3D ISPCSI2_CTRL_VP_ONLY_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTRL_VP_ONLY_EN_DISABLE;
+                       currctrl_u->vp_only_enable =3D false;
+               }
+               if ((currctrl_u->vp_out_ctrl =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~ISPCSI2_CTRL_VP_OUT_CTRL_MASK;
+                       reg |=3D (currctrl->vp_out_ctrl - 1) <<
+                                               ISPCSI2_CTRL_VP_OUT_CTRL_=
SHIFT;
+                       currctrl_u->vp_out_ctrl =3D false;
+               }
+               if ((currctrl_u->debug_enable =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~ISPCSI2_CTRL_DBG_EN_MASK;
+                       if (currctrl->debug_enable)
+                               reg |=3D ISPCSI2_CTRL_DBG_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTRL_DBG_EN_DISABLE;
+                       currctrl_u->debug_enable =3D false;
+               }
+               if ((currctrl_u->burst_size =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~ISPCSI2_CTRL_BURST_SIZE_MASK;
+                       reg |=3D currctrl->burst_size <<
+                                               ISPCSI2_CTRL_BURST_SIZE_S=
HIFT;
+                       currctrl_u->burst_size =3D false;
+               }
+               if ((currctrl_u->ecc_enable =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~ISPCSI2_CTRL_ECC_EN_MASK;
+                       if (currctrl->ecc_enable)
+                               reg |=3D ISPCSI2_CTRL_ECC_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTRL_ECC_EN_DISABLE;
+                       currctrl_u->ecc_enable =3D false;
+               }
+               if ((currctrl_u->secure_mode =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~ISPCSI2_CTRL_SECURE_MASK;
+                       if (currctrl->secure_mode)
+                               reg |=3D ISPCSI2_CTRL_SECURE_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTRL_SECURE_DISABLE;
+                       currctrl_u->secure_mode =3D false;
+               }
+               if ((currctrl_u->if_enable =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_CTRL_IF_EN_MASK;
+                       if (currctrl->if_enable)
+                               reg |=3D ISPCSI2_CTRL_IF_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTRL_IF_EN_DISABLE;
+                       currctrl_u->if_enable =3D false;
+               }
+               omap_writel(reg, ISPCSI2_CTRL);
+               update_ctrl =3D false;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctrl_get - Gets CSI2 control configuration
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctrl_get(void)
+{
+       struct isp_csi2_ctrl_cfg *currctrl =3D &current_csi2_cfg.ctrl;
+       struct isp_csi2_ctrl_cfg_update *currctrl_u =3D
+                                               &current_csi2_cfg_update.=
ctrl;
+       u32 reg;
+
+       reg =3D omap_readl(ISPCSI2_CTRL);
+       currctrl->frame_mode =3D (reg & ISPCSI2_CTRL_FRAME_MASK) >>
+                                               ISPCSI2_CTRL_FRAME_SHIFT;
+       currctrl_u->frame_mode =3D false;
+
+       if ((reg & ISPCSI2_CTRL_VP_CLK_EN_MASK) =3D=3D
+                                               ISPCSI2_CTRL_VP_CLK_EN_EN=
ABLE)
+               currctrl->vp_clk_enable =3D true;
+       else
+               currctrl->vp_clk_enable =3D false;
+       currctrl_u->vp_clk_enable =3D false;
+
+       if ((reg & ISPCSI2_CTRL_VP_ONLY_EN_MASK) =3D=3D
+                                               ISPCSI2_CTRL_VP_ONLY_EN_E=
NABLE)
+               currctrl->vp_only_enable =3D true;
+       else
+               currctrl->vp_only_enable =3D false;
+       uses_videoport =3D currctrl->vp_only_enable;
+       currctrl_u->vp_only_enable =3D false;
+
+       currctrl->vp_out_ctrl =3D ((reg & ISPCSI2_CTRL_VP_OUT_CTRL_MASK) =
>>
+                                       ISPCSI2_CTRL_VP_OUT_CTRL_SHIFT) +=
 1;
+       currctrl_u->vp_out_ctrl =3D false;
+
+       if ((reg & ISPCSI2_CTRL_DBG_EN_MASK) =3D=3D ISPCSI2_CTRL_DBG_EN_E=
NABLE)
+               currctrl->debug_enable =3D true;
+       else
+               currctrl->debug_enable =3D false;
+       currctrl_u->debug_enable =3D false;
+
+       currctrl->burst_size =3D (reg & ISPCSI2_CTRL_BURST_SIZE_MASK) >>
+                                       ISPCSI2_CTRL_BURST_SIZE_SHIFT;
+       currctrl_u->burst_size =3D false;
+
+       if ((reg & ISPCSI2_CTRL_ECC_EN_MASK) =3D=3D ISPCSI2_CTRL_ECC_EN_E=
NABLE)
+               currctrl->ecc_enable =3D true;
+       else
+               currctrl->ecc_enable =3D false;
+       currctrl_u->ecc_enable =3D false;
+
+       if ((reg & ISPCSI2_CTRL_SECURE_MASK) =3D=3D ISPCSI2_CTRL_SECURE_E=
NABLE)
+               currctrl->secure_mode =3D true;
+       else
+               currctrl->secure_mode =3D false;
+       currctrl_u->secure_mode =3D false;
+
+       if ((reg & ISPCSI2_CTRL_IF_EN_MASK) =3D=3D ISPCSI2_CTRL_IF_EN_ENA=
BLE)
+               currctrl->if_enable =3D true;
+       else
+               currctrl->if_enable =3D false;
+       currctrl_u->if_enable =3D false;
+
+       update_ctrl =3D false;
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_validate - Validates the context number value
+ * @ctxnum: Pointer to variable containing context number.
+ *
+ * If the value is not in range (3 bits), it is being ANDed with 0x7 to =
force
+ * it to be on range.
+ **/
+static void isp_csi2_ctx_validate(u8 *ctxnum)
+{
+       if (*ctxnum > 7) {
+               printk(KERN_ERR "Invalid context number. Forcing valid"
+                                                               " value..=
.\n");
+               *ctxnum &=3D ~(0x7);
+       }
+}
+
+/**
+ * isp_csi2_ctx_config_virtual_id - Maps a virtual ID with a CSI2 Rx con=
text
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @virtual_id: CSI2 Virtual ID to associate with specified context numb=
er.
+ *
+ * Returns 0 if successful, or -EINVAL if Virtual ID is not in range (0-=
3).
+ **/
+int isp_csi2_ctx_config_virtual_id(u8 ctxnum, u8 virtual_id)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       if (virtual_id > 3) {
+               printk(KERN_ERR "Wrong requested virtual_id\n");
+               return -EINVAL;
+       }
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->virtual_id !=3D virtual_id) {
+               selected_ctx->virtual_id =3D virtual_id;
+               selected_ctx_u->virtual_id =3D true;
+               update_ctx_ctrl2[ctxnum] =3D true;
+       }
+
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_frame_count - Sets frame count to be received in =
CSI2 Rx.
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @frame_count: Number of frames to acquire.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_frame_count(u8 ctxnum, u8 frame_count)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->frame_count !=3D frame_count) {
+               selected_ctx->frame_count =3D frame_count;
+               selected_ctx_u->frame_count =3D true;
+               update_ctx_ctrl1[ctxnum] =3D true;
+       }
+
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_format - Maps a pixel format to a specified conte=
xt.
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @pixformat: V4L2 structure for pixel format.
+ *
+ * Returns 0 if successful, or -EINVAL if the format is not supported by=
 the
+ * receiver.
+ **/
+int isp_csi2_ctx_config_format(u8 ctxnum, u32 pixformat)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+       struct v4l2_pix_format pix;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       pix.pixelformat =3D pixformat;
+       switch (pix.pixelformat) {
+       case V4L2_PIX_FMT_RGB565:
+       case V4L2_PIX_FMT_RGB565X:
+       case V4L2_PIX_FMT_YUYV:
+       case V4L2_PIX_FMT_UYVY:
+       case V4L2_PIX_FMT_RGB555:
+       case V4L2_PIX_FMT_RGB555X:
+       case V4L2_PIX_FMT_SGRBG10:
+       break;
+       default:
+               printk(KERN_ERR "Context config pixel format unsupported\=
n");
+               return -EINVAL;
+       }
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       selected_ctx->format =3D pix;
+       selected_ctx_u->format =3D true;
+       update_ctx_ctrl2[ctxnum] =3D true;
+
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_alpha - Sets the alpha value for pixel format
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @alpha: Alpha value.
+ *
+ * Returns 0 if successful, or -EINVAL if the alpha value is bigger than=
 16383.
+ **/
+int isp_csi2_ctx_config_alpha(u8 ctxnum, u16 alpha)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       if (alpha > 0x3FFF) {
+               printk(KERN_ERR "Wrong alpha value\n");
+               return -EINVAL;
+       }
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->alpha !=3D alpha) {
+               selected_ctx->alpha =3D alpha;
+               selected_ctx_u->alpha =3D true;
+               update_ctx_ctrl3[ctxnum] =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_data_offset - Sets the offset between received li=
nes
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @data_offset: Offset between first pixel of each 2 contiguous lines.
+ *
+ * Returns 0 if successful, or -EINVAL if the line offset is bigger than=
 1023.
+ **/
+int isp_csi2_ctx_config_data_offset(u8 ctxnum, u16 data_offset)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       if (data_offset > 0x3FF) {
+               printk(KERN_ERR "Wrong line offset\n");
+               return -EINVAL;
+       }
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->data_offset !=3D data_offset) {
+               selected_ctx->data_offset =3D data_offset;
+               selected_ctx_u->data_offset =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_ping_addr - Sets Ping address for CSI2 Rx. buffer=
 saving
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @ping_addr: 32 bit ISP MMU mapped address.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_ping_addr(u8 ctxnum, u32 ping_addr)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       ping_addr &=3D ~(0x1F);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->ping_addr !=3D ping_addr) {
+               selected_ctx->ping_addr =3D ping_addr;
+               selected_ctx_u->ping_addr =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_pong_addr - Sets Pong address for CSI2 Rx. buffer=
 saving
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @pong_addr: 32 bit ISP MMU mapped address.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_pong_addr(u8 ctxnum, u32 pong_addr)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       pong_addr &=3D ~(0x1F);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->pong_addr !=3D pong_addr) {
+               selected_ctx->pong_addr =3D pong_addr;
+               selected_ctx_u->pong_addr =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_eof_enabled - Enables EOF signal assertion
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @eof_enabled: Boolean to enable/disable EOF signal assertion on recei=
ved
+ *               packets.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_eof_enabled(u8 ctxnum, bool eof_enabled)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->eof_enabled !=3D eof_enabled) {
+               selected_ctx->eof_enabled =3D eof_enabled;
+               selected_ctx_u->eof_enabled =3D true;
+               update_ctx_ctrl1[ctxnum] =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_eol_enabled - Enables EOL signal assertion
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @eol_enabled: Boolean to enable/disable EOL signal assertion on recei=
ved
+ *               packets.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_eol_enabled(u8 ctxnum, bool eol_enabled)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->eol_enabled !=3D eol_enabled) {
+               selected_ctx->eol_enabled =3D eol_enabled;
+               selected_ctx_u->eol_enabled =3D true;
+               update_ctx_ctrl1[ctxnum] =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_checksum_enabled - Enables Checksum check in rcvd=
 packets
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @checksum_enabled: Boolean to enable/disable Checksum check on receiv=
ed
+ *                    packets
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_checksum_enabled(u8 ctxnum, bool checksum_enable=
d)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->checksum_enabled !=3D checksum_enabled) {
+               selected_ctx->checksum_enabled =3D checksum_enabled;
+               selected_ctx_u->checksum_enabled =3D true;
+               update_ctx_ctrl1[ctxnum] =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_config_enabled - Enables specified CSI2 context
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @enabled: Boolean to enable/disable specified context.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_config_enabled(u8 ctxnum, bool enabled)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if (selected_ctx->enabled !=3D enabled) {
+               selected_ctx->enabled =3D enabled;
+               selected_ctx_u->enabled =3D true;
+               update_ctx_ctrl1[ctxnum] =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_update - Applies CSI2 context configuration.
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_ctx_config_*() functions.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_ctx_config_*() functions, unless the force_update flag is
+ * set to true.
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_update(u8 ctxnum, bool force_update)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+       u32 reg;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       if ((update_ctx_ctrl1[ctxnum] =3D=3D true) || (force_update =3D=3D=
 true)) {
+               reg =3D omap_readl(ISPCSI2_CTX_CTRL1(ctxnum));
+               if ((selected_ctx_u->frame_count =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL1_COUNT_MASK);
+                       reg |=3D selected_ctx->frame_count <<
+                                               ISPCSI2_CTX_CTRL1_COUNT_S=
HIFT;
+                       selected_ctx_u->frame_count =3D false;
+               }
+               if ((selected_ctx_u->eof_enabled =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL1_EOF_EN_MASK);
+                       if (selected_ctx->eof_enabled =3D=3D true)
+                               reg |=3D ISPCSI2_CTX_CTRL1_EOF_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTX_CTRL1_EOF_EN_DISABLE=
;
+                       selected_ctx_u->eof_enabled =3D false;
+               }
+               if ((selected_ctx_u->eol_enabled =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL1_EOL_EN_MASK);
+                       if (selected_ctx->eol_enabled =3D=3D true)
+                               reg |=3D ISPCSI2_CTX_CTRL1_EOL_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTX_CTRL1_EOL_EN_DISABLE=
;
+                       selected_ctx_u->eol_enabled =3D false;
+               }
+               if ((selected_ctx_u->checksum_enabled =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL1_CS_EN_MASK);
+                       if (selected_ctx->checksum_enabled =3D=3D true)
+                               reg |=3D ISPCSI2_CTX_CTRL1_CS_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTX_CTRL1_CS_EN_DISABLE;
+                       selected_ctx_u->checksum_enabled =3D false;
+               }
+               if ((selected_ctx_u->enabled =3D=3D true) ||
+                                       (force_update =3D=3D true)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL1_CTX_EN_MASK);
+                       if (selected_ctx->enabled =3D=3D true)
+                               reg |=3D ISPCSI2_CTX_CTRL1_CTX_EN_ENABLE;
+                       else
+                               reg |=3D ISPCSI2_CTX_CTRL1_CTX_EN_DISABLE=
;
+                       selected_ctx_u->enabled =3D false;
+               }
+               omap_writel(reg, ISPCSI2_CTX_CTRL1(ctxnum));
+               update_ctx_ctrl1[ctxnum] =3D false;
+       }
+
+       if ((update_ctx_ctrl2[ctxnum] =3D=3D true) || (force_update =3D=3D=
 true)) {
+               reg =3D omap_readl(ISPCSI2_CTX_CTRL2(ctxnum));
+               if ((selected_ctx_u->virtual_id =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL2_VIRTUAL_ID_MASK);
+                       reg |=3D selected_ctx->virtual_id <<
+                                       ISPCSI2_CTX_CTRL2_VIRTUAL_ID_SHIF=
T;
+                       selected_ctx_u->virtual_id =3D false;
+               }
+
+               if ((selected_ctx_u->format =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       struct v4l2_pix_format *pix;
+                       u16 new_format =3D 0;
+
+                       reg &=3D ~(ISPCSI2_CTX_CTRL2_FORMAT_MASK);
+                       pix =3D &selected_ctx->format;
+                       switch (pix->pixelformat) {
+                       case V4L2_PIX_FMT_RGB565:
+                       case V4L2_PIX_FMT_RGB565X:
+                               new_format =3D 0x22;
+                               break;
+                       case V4L2_PIX_FMT_YUYV:
+                       case V4L2_PIX_FMT_UYVY:
+                               if (uses_videoport)
+                                       new_format =3D 0x9E;
+                               else
+                                       new_format =3D 0x1E;
+                               break;
+                       case V4L2_PIX_FMT_RGB555:
+                       case V4L2_PIX_FMT_RGB555X:
+                               new_format =3D 0xA1;
+                               break;
+                       case V4L2_PIX_FMT_SGRBG10:
+                               if (uses_videoport)
+                                       new_format =3D 0x12F;
+                               else
+                                       new_format =3D 0xAB;
+                               break;
+                       }
+                       reg |=3D (new_format << ISPCSI2_CTX_CTRL2_FORMAT_=
SHIFT);
+                       selected_ctx_u->format =3D false;
+               }
+               omap_writel(reg, ISPCSI2_CTX_CTRL2(ctxnum));
+               update_ctx_ctrl2[ctxnum] =3D false;
+       }
+
+       if ((update_ctx_ctrl3[ctxnum] =3D=3D true) || (force_update =3D=3D=
 true)) {
+               reg =3D omap_readl(ISPCSI2_CTX_CTRL3(ctxnum));
+               if ((selected_ctx_u->alpha =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~(ISPCSI2_CTX_CTRL3_ALPHA_MASK);
+                       reg |=3D (selected_ctx->alpha <<
+                                               ISPCSI2_CTX_CTRL3_ALPHA_S=
HIFT);
+                       selected_ctx_u->alpha =3D false;
+               }
+               omap_writel(reg, ISPCSI2_CTX_CTRL3(ctxnum));
+               update_ctx_ctrl3[ctxnum] =3D false;
+       }
+
+       if (selected_ctx_u->data_offset =3D=3D true) {
+               reg =3D omap_readl(ISPCSI2_CTX_DAT_OFST(ctxnum));
+               reg &=3D ~ISPCSI2_CTX_DAT_OFST_OFST_MASK;
+               reg |=3D selected_ctx->data_offset <<
+                                               ISPCSI2_CTX_DAT_OFST_OFST=
_SHIFT;
+               omap_writel(reg, ISPCSI2_CTX_DAT_OFST(ctxnum));
+               selected_ctx_u->data_offset =3D false;
+       }
+
+       if (selected_ctx_u->ping_addr =3D=3D true) {
+               reg =3D selected_ctx->ping_addr;
+               omap_writel(reg, ISPCSI2_CTX_DAT_PING_ADDR(ctxnum));
+               selected_ctx_u->ping_addr =3D false;
+       }
+
+       if (selected_ctx_u->pong_addr =3D=3D true) {
+               reg =3D selected_ctx->pong_addr;
+               omap_writel(reg, ISPCSI2_CTX_DAT_PONG_ADDR(ctxnum));
+               selected_ctx_u->pong_addr =3D false;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_get - Gets specific CSI2 Context configuration
+ * @ctxnum: Context number, valid between 0 and 7 values.
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_get(u8 ctxnum)
+{
+       struct isp_csi2_ctx_cfg *selected_ctx;
+       struct isp_csi2_ctx_cfg_update *selected_ctx_u;
+       u32 reg;
+
+       isp_csi2_ctx_validate(&ctxnum);
+
+       selected_ctx =3D &current_csi2_cfg.contexts[ctxnum];
+       selected_ctx_u =3D &current_csi2_cfg_update.contexts[ctxnum];
+
+       reg =3D omap_readl(ISPCSI2_CTX_CTRL1(ctxnum));
+       selected_ctx->frame_count =3D (reg & ISPCSI2_CTX_CTRL1_COUNT_MASK=
) >>
+                                               ISPCSI2_CTX_CTRL1_COUNT_S=
HIFT;
+       selected_ctx_u->frame_count =3D false;
+
+       if ((reg & ISPCSI2_CTX_CTRL1_EOF_EN_MASK) =3D=3D
+                                               ISPCSI2_CTX_CTRL1_EOF_EN_=
ENABLE)
+               selected_ctx->eof_enabled =3D true;
+       else
+               selected_ctx->eof_enabled =3D false;
+       selected_ctx_u->eof_enabled =3D false;
+
+       if ((reg & ISPCSI2_CTX_CTRL1_EOL_EN_MASK) =3D=3D
+                                               ISPCSI2_CTX_CTRL1_EOL_EN_=
ENABLE)
+               selected_ctx->eol_enabled =3D true;
+       else
+               selected_ctx->eol_enabled =3D false;
+       selected_ctx_u->eol_enabled =3D false;
+
+       if ((reg & ISPCSI2_CTX_CTRL1_CS_EN_MASK) =3D=3D
+                                               ISPCSI2_CTX_CTRL1_CS_EN_E=
NABLE)
+               selected_ctx->checksum_enabled =3D true;
+       else
+               selected_ctx->checksum_enabled =3D false;
+       selected_ctx_u->checksum_enabled =3D false;
+
+       if ((reg & ISPCSI2_CTX_CTRL1_CTX_EN_MASK) =3D=3D
+                                               ISPCSI2_CTX_CTRL1_CTX_EN_=
ENABLE)
+               selected_ctx->enabled =3D true;
+       else
+               selected_ctx->enabled =3D false;
+       selected_ctx_u->enabled =3D false;
+       update_ctx_ctrl1[ctxnum] =3D false;
+
+       reg =3D omap_readl(ISPCSI2_CTX_CTRL2(ctxnum));
+
+       selected_ctx->virtual_id =3D (reg & ISPCSI2_CTX_CTRL2_VIRTUAL_ID_=
MASK) >>
+                                       ISPCSI2_CTX_CTRL2_VIRTUAL_ID_SHIF=
T;
+       selected_ctx_u->virtual_id =3D false;
+
+       switch ((reg & ISPCSI2_CTX_CTRL2_FORMAT_MASK) >>
+                               ISPCSI2_CTX_CTRL2_FORMAT_SHIFT) {
+       case 0x22:
+               selected_ctx->format.pixelformat =3D V4L2_PIX_FMT_RGB565;
+               break;
+       case 0x9E:
+       case 0x1E:
+               selected_ctx->format.pixelformat =3D V4L2_PIX_FMT_YUYV;
+               break;
+       case 0xA1:
+               selected_ctx->format.pixelformat =3D V4L2_PIX_FMT_RGB555;
+               break;
+       case 0xAB:
+       case 0x12F:
+               selected_ctx->format.pixelformat =3D V4L2_PIX_FMT_SGRBG10=
;
+               break;
+       }
+       selected_ctx_u->format =3D false;
+       update_ctx_ctrl2[ctxnum] =3D false;
+
+       selected_ctx->alpha =3D (omap_readl(ISPCSI2_CTX_CTRL3(ctxnum)) &
+                                       ISPCSI2_CTX_CTRL3_ALPHA_MASK) >>
+                                       ISPCSI2_CTX_CTRL3_ALPHA_SHIFT;
+       selected_ctx_u->alpha =3D false;
+       update_ctx_ctrl3[ctxnum] =3D false;
+
+       selected_ctx->data_offset =3D (omap_readl(ISPCSI2_CTX_DAT_OFST(ct=
xnum)) &
+                               ISPCSI2_CTX_DAT_OFST_OFST_MASK) >>
+                               ISPCSI2_CTX_DAT_OFST_OFST_SHIFT;
+       selected_ctx_u->data_offset =3D false;
+
+       selected_ctx->ping_addr =3D omap_readl(ISPCSI2_CTX_DAT_PING_ADDR(=
ctxnum));
+       selected_ctx_u->ping_addr =3D false;
+
+       selected_ctx->pong_addr =3D omap_readl(ISPCSI2_CTX_DAT_PONG_ADDR(=
ctxnum));
+       selected_ctx_u->pong_addr =3D false;
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_update_all - Applies all CSI2 context configuration.
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_ctx_config_*() functions.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_ctx_config_*() functions, unless the force_update flag is
+ * set to true.
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_update_all(bool force_update)
+{
+       u8 ctxnum;
+
+       for (ctxnum =3D 0; ctxnum < 8; ctxnum++)
+               isp_csi2_ctx_update(ctxnum, force_update);
+
+       return 0;
+}
+
+/**
+ * isp_csi2_ctx_get_all - Gets all CSI2 Context configurations
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_ctx_get_all(void)
+{
+       u8 ctxnum;
+
+       for (ctxnum =3D 0; ctxnum < 8; ctxnum++)
+               isp_csi2_ctx_get(ctxnum);
+
+       return 0;
+}
+
+int isp_csi2_phy_config(struct isp_csi2_phy_cfg *desiredphyconfig)
+{
+       struct isp_csi2_phy_cfg *currphy =3D &current_csi2_cfg.phy;
+       struct isp_csi2_phy_cfg_update *currphy_u =3D
+                                               &current_csi2_cfg_update.=
phy;
+
+       if ((desiredphyconfig->tclk_term > 0x7f) ||
+                               (desiredphyconfig->tclk_miss > 0x3)) {
+               printk(KERN_ERR "Invalid PHY configuration sent by the"
+                                                               " driver\=
n");
+               return -EINVAL;
+       }
+
+       if (currphy->ths_term !=3D desiredphyconfig->ths_term) {
+               currphy->ths_term =3D desiredphyconfig->ths_term;
+               currphy_u->ths_term =3D true;
+               update_phy_cfg0 =3D true;
+       }
+       if (currphy->ths_settle !=3D desiredphyconfig->ths_settle) {
+               currphy->ths_settle =3D desiredphyconfig->ths_settle;
+               currphy_u->ths_settle =3D true;
+               update_phy_cfg0 =3D true;
+       }
+       if (currphy->tclk_term !=3D desiredphyconfig->tclk_term) {
+               currphy->tclk_term =3D desiredphyconfig->tclk_term;
+               currphy_u->tclk_term =3D true;
+               update_phy_cfg1 =3D true;
+       }
+       if (currphy->tclk_miss !=3D desiredphyconfig->tclk_miss) {
+               currphy->tclk_miss =3D desiredphyconfig->tclk_miss;
+               currphy_u->tclk_miss =3D true;
+               update_phy_cfg1 =3D true;
+       }
+       if (currphy->tclk_settle !=3D desiredphyconfig->tclk_settle) {
+               currphy->tclk_settle =3D desiredphyconfig->tclk_settle;
+               currphy_u->tclk_settle =3D true;
+               update_phy_cfg1 =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_calc_phy_cfg0 - Calculates D-PHY config based on the MIPIClk=
 speed.
+ * @mipiclk: MIPI clock frequency being used with CSI2 sensor.
+ * @lbound_hs_settle: Lower bound for CSI2 High Speed Settle transition.
+ * @ubound_hs_settle: Upper bound for CSI2 High Speed Settle transition.
+ *
+ * From TRM, we have the same calculation for HS Termination signal.
+ *  THS_TERM  =3D ceil( 12.5ns / DDRCLK period ) - 1
+ * But for Settle, we use the mid value between the two passed boundarie=
s from
+ * sensor:
+ *  THS_SETTLE =3D (Upper bound + Lower bound) / 2
+ *
+ * Always returns 0.
+ */
+int isp_csi2_calc_phy_cfg0(u32 mipiclk, u32 lbound_hs_settle,
+                                                       u32 ubound_hs_set=
tle)
+{
+       struct isp_csi2_phy_cfg *currphy =3D &current_csi2_cfg.phy;
+       struct isp_csi2_phy_cfg_update *currphy_u =3D
+                                               &current_csi2_cfg_update.=
phy;
+       u32 tmp, ddrclk =3D mipiclk >> 1;
+
+       /* Calculate THS_TERM */
+       tmp =3D ddrclk / 80000000;
+       if ((ddrclk % 80000000) > 0)
+               tmp++;
+       currphy->ths_term =3D tmp - 1;
+       currphy_u->ths_term =3D true;
+
+       /* Calculate THS_SETTLE */
+       currphy->ths_settle =3D (ubound_hs_settle + lbound_hs_settle) / 2=
;
+
+       currphy_u->ths_settle =3D true;
+       isp_csi2_phy_update(true);
+       return 0;
+}
+EXPORT_SYMBOL(isp_csi2_calc_phy_cfg0);
+
+/**
+ * isp_csi2_phy_update - Applies CSI2 D-PHY configuration.
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_phy_config_*() functions.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_phy_config_*() functions, unless the force_update flag is
+ * set to true.
+ * Always returns 0.
+ **/
+int isp_csi2_phy_update(bool force_update)
+{
+       struct isp_csi2_phy_cfg *currphy =3D &current_csi2_cfg.phy;
+       struct isp_csi2_phy_cfg_update *currphy_u =3D
+                                               &current_csi2_cfg_update.=
phy;
+       u32 reg;
+
+       if ((update_phy_cfg0 =3D=3D true) || (force_update =3D=3D true)) =
{
+               reg =3D omap_readl(ISPCSI2PHY_CFG0);
+               if ((currphy_u->ths_term =3D=3D true) || (force_update =3D=
=3D true)) {
+                       reg &=3D ~ISPCSI2PHY_CFG0_THS_TERM_MASK;
+                       reg |=3D (currphy->ths_term <<
+                                       ISPCSI2PHY_CFG0_THS_TERM_SHIFT);
+                       currphy_u->ths_term =3D false;
+               }
+               if ((currphy_u->ths_settle =3D=3D true) || (force_update =
=3D=3D true)) {
+                       reg &=3D ~ISPCSI2PHY_CFG0_THS_SETTLE_MASK;
+                       reg |=3D (currphy->ths_settle <<
+                                       ISPCSI2PHY_CFG0_THS_SETTLE_SHIFT)=
;
+                       currphy_u->ths_settle =3D false;
+               }
+               omap_writel(reg, ISPCSI2PHY_CFG0);
+               update_phy_cfg0 =3D false;
+       }
+
+       if ((update_phy_cfg1 =3D=3D true) || (force_update =3D=3D true)) =
{
+               reg =3D omap_readl(ISPCSI2PHY_CFG1);
+               if ((currphy_u->tclk_term =3D=3D true) || (force_update =3D=
=3D true)) {
+                       reg &=3D ~ISPCSI2PHY_CFG1_TCLK_TERM_MASK;
+                       reg |=3D (currphy->tclk_term <<
+                                       ISPCSI2PHY_CFG1_TCLK_TERM_SHIFT);
+                       currphy_u->tclk_term =3D false;
+               }
+               if ((currphy_u->tclk_miss =3D=3D true) || (force_update =3D=
=3D true)) {
+                       reg &=3D ~ISPCSI2PHY_CFG1_TCLK_MISS_MASK;
+                       reg |=3D (currphy->tclk_miss <<
+                                       ISPCSI2PHY_CFG1_TCLK_MISS_SHIFT);
+                       currphy_u->tclk_miss =3D false;
+               }
+               if ((currphy_u->tclk_settle =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2PHY_CFG1_TCLK_SETTLE_MASK;
+                       reg |=3D (currphy->tclk_settle <<
+                                       ISPCSI2PHY_CFG1_TCLK_SETTLE_SHIFT=
);
+                       currphy_u->tclk_settle =3D false;
+               }
+               omap_writel(reg, ISPCSI2PHY_CFG1);
+               update_phy_cfg1 =3D false;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_phy_get - Gets CSI2 D-PHY configuration
+ *
+ * Gets settings from HW registers and fills in the internal driver memo=
ry
+ * Always returns 0.
+ **/
+int isp_csi2_phy_get(void)
+{
+       struct isp_csi2_phy_cfg *currphy =3D &current_csi2_cfg.phy;
+       struct isp_csi2_phy_cfg_update *currphy_u =3D
+                                               &current_csi2_cfg_update.=
phy;
+       u32 reg;
+
+       reg =3D omap_readl(ISPCSI2PHY_CFG0);
+       currphy->ths_term =3D (reg & ISPCSI2PHY_CFG0_THS_TERM_MASK) >>
+                                               ISPCSI2PHY_CFG0_THS_TERM_=
SHIFT;
+       currphy_u->ths_term =3D false;
+
+       currphy->ths_settle =3D (reg & ISPCSI2PHY_CFG0_THS_SETTLE_MASK) >=
>
+                                       ISPCSI2PHY_CFG0_THS_SETTLE_SHIFT;
+       currphy_u->ths_settle =3D false;
+       update_phy_cfg0 =3D false;
+
+       reg =3D omap_readl(ISPCSI2PHY_CFG1);
+
+       currphy->tclk_term =3D (reg & ISPCSI2PHY_CFG1_TCLK_TERM_MASK) >>
+                                               ISPCSI2PHY_CFG1_TCLK_TERM=
_SHIFT;
+       currphy_u->tclk_term =3D false;
+
+       currphy->tclk_miss =3D (reg & ISPCSI2PHY_CFG1_TCLK_MISS_MASK) >>
+                                               ISPCSI2PHY_CFG1_TCLK_MISS=
_SHIFT;
+       currphy_u->tclk_miss =3D false;
+
+       currphy->tclk_settle =3D (reg & ISPCSI2PHY_CFG1_TCLK_SETTLE_MASK)=
 >>
+                                       ISPCSI2PHY_CFG1_TCLK_SETTLE_SHIFT=
;
+       currphy_u->tclk_settle =3D false;
+
+       update_phy_cfg1 =3D false;
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_config_forcerxmode - Sets Force Rx mode on stop stat=
e count
+ * @force_rx_mode: Boolean to enable/disable forcing Rx mode in CSI2 rec=
eiver
+ *
+ * Returns 0 if successful, or -EINVAL if wrong ComplexIO number is sele=
cted.
+ **/
+int isp_csi2_timings_config_forcerxmode(u8 io, bool force_rx_mode)
+{
+       struct isp_csi2_timings_cfg *currtimings;
+       struct isp_csi2_timings_cfg_update *currtimings_u;
+
+       if (io > 2) {
+               printk(KERN_ERR "CSI2 - Timings config: Invalid IO number=
\n");
+               return -EINVAL;
+       }
+
+       currtimings =3D &current_csi2_cfg.timings[io - 1];
+       currtimings_u =3D &current_csi2_cfg_update.timings[io - 1];
+       if (currtimings->force_rx_mode !=3D force_rx_mode) {
+               currtimings->force_rx_mode =3D force_rx_mode;
+               currtimings_u->force_rx_mode =3D true;
+               update_timing =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_config_stopstate_16x - Sets 16x factor for L3 cycles
+ * @stop_state_16x: Boolean to use or not use the 16x multiplier for sto=
p count
+ *
+ * Returns 0 if successful, or -EINVAL if wrong ComplexIO number is sele=
cted.
+ **/
+int isp_csi2_timings_config_stopstate_16x(u8 io, bool stop_state_16x)
+{
+       struct isp_csi2_timings_cfg *currtimings;
+       struct isp_csi2_timings_cfg_update *currtimings_u;
+
+       if (io > 2) {
+               printk(KERN_ERR "CSI2 - Timings config: Invalid IO number=
\n");
+               return -EINVAL;
+       }
+
+       currtimings =3D &current_csi2_cfg.timings[io - 1];
+       currtimings_u =3D &current_csi2_cfg_update.timings[io - 1];
+       if (currtimings->stop_state_16x !=3D stop_state_16x) {
+               currtimings->stop_state_16x =3D stop_state_16x;
+               currtimings_u->stop_state_16x =3D true;
+               update_timing =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_config_stopstate_4x - Sets 4x factor for L3 cycles
+ * @stop_state_4x: Boolean to use or not use the 4x multiplier for stop =
count
+ *
+ * Returns 0 if successful, or -EINVAL if wrong ComplexIO number is sele=
cted.
+ **/
+int isp_csi2_timings_config_stopstate_4x(u8 io, bool stop_state_4x)
+{
+       struct isp_csi2_timings_cfg *currtimings;
+       struct isp_csi2_timings_cfg_update *currtimings_u;
+
+       if (io > 2) {
+               printk(KERN_ERR "CSI2 - Timings config: Invalid IO number=
\n");
+               return -EINVAL;
+       }
+
+       currtimings =3D &current_csi2_cfg.timings[io - 1];
+       currtimings_u =3D &current_csi2_cfg_update.timings[io - 1];
+       if (currtimings->stop_state_4x !=3D stop_state_4x) {
+               currtimings->stop_state_4x =3D stop_state_4x;
+               currtimings_u->stop_state_4x =3D true;
+               update_timing =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_config_stopstate_cnt - Sets L3 cycles
+ * @stop_state_counter: Stop state counter value for L3 cycles
+ *
+ * Returns 0 if successful, or -EINVAL if wrong ComplexIO number is sele=
cted.
+ **/
+int isp_csi2_timings_config_stopstate_cnt(u8 io, u16 stop_state_counter)
+{
+       struct isp_csi2_timings_cfg *currtimings;
+       struct isp_csi2_timings_cfg_update *currtimings_u;
+
+       if (io > 2) {
+               printk(KERN_ERR "CSI2 - Timings config: Invalid IO number=
\n");
+               return -EINVAL;
+       }
+
+       currtimings =3D &current_csi2_cfg.timings[io - 1];
+       currtimings_u =3D &current_csi2_cfg_update.timings[io - 1];
+       if (currtimings->stop_state_counter !=3D stop_state_counter) {
+               currtimings->stop_state_counter =3D (stop_state_counter &=
 0x1FFF);
+               currtimings_u->stop_state_counter =3D true;
+               update_timing =3D true;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_update - Applies specified CSI2 timing configuration=
.
+ * @io: IO number (1 or 2) which specifies which ComplexIO are we updati=
ng
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_timings_config_*() functions=
.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_timings_config_*() functions, unless the force_update flag i=
s
+ * set to true.
+ * Returns 0 if successful, or -EINVAL if invalid IO number is passed.
+ **/
+int isp_csi2_timings_update(u8 io, bool force_update)
+{
+       struct isp_csi2_timings_cfg *currtimings;
+       struct isp_csi2_timings_cfg_update *currtimings_u;
+       u32 reg;
+
+       if (io > 2) {
+               printk(KERN_ERR "CSI2 - Timings config: Invalid IO number=
\n");
+               return -EINVAL;
+       }
+
+       currtimings =3D &current_csi2_cfg.timings[io - 1];
+       currtimings_u =3D &current_csi2_cfg_update.timings[io - 1];
+
+       if ((update_timing =3D=3D true) || (force_update =3D=3D true)) {
+               reg =3D omap_readl(ISPCSI2_TIMING);
+               if ((currtimings_u->force_rx_mode =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_TIMING_FORCE_RX_MODE_IO_MASK(io=
);
+                       if (currtimings->force_rx_mode =3D=3D true)
+                               reg |=3D ISPCSI2_TIMING_FORCE_RX_MODE_IO_=
ENABLE
+                                                                       (=
io);
+                       else
+                               reg |=3D ISPCSI2_TIMING_FORCE_RX_MODE_IO_=
DISABLE
+                                                                       (=
io);
+                       currtimings_u->force_rx_mode =3D false;
+               }
+               if ((currtimings_u->stop_state_16x =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_TIMING_STOP_STATE_X16_IO_MASK(i=
o);
+                       if (currtimings->stop_state_16x =3D=3D true)
+                               reg |=3D ISPCSI2_TIMING_STOP_STATE_X16_IO=
_ENABLE
+                                                                       (=
io);
+                       else
+                               reg |=3D ISPCSI2_TIMING_STOP_STATE_X16_IO=
_DISABLE
+                                                                       (=
io);
+                       currtimings_u->stop_state_16x =3D false;
+               }
+               if ((currtimings_u->stop_state_4x =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_TIMING_STOP_STATE_X4_IO_MASK(io=
);
+                       if (currtimings->stop_state_4x =3D=3D true) {
+                               reg |=3D ISPCSI2_TIMING_STOP_STATE_X4_IO_=
ENABLE
+                                                                       (=
io);
+                       } else {
+                               reg |=3D ISPCSI2_TIMING_STOP_STATE_X4_IO_=
DISABLE
+                                                                       (=
io);
+                       }
+                       currtimings_u->stop_state_4x =3D false;
+               }
+               if ((currtimings_u->stop_state_counter =3D=3D true) ||
+                                               (force_update =3D=3D true=
)) {
+                       reg &=3D ~ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_MA=
SK(io);
+                       reg |=3D currtimings->stop_state_counter <<
+                               ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_SHIF=
T(io);
+                       currtimings_u->stop_state_counter =3D false;
+               }
+               omap_writel(reg, ISPCSI2_TIMING);
+               update_timing =3D false;
+       }
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_get - Gets specific CSI2 ComplexIO timing configurat=
ion
+ * @io: IO number (1 or 2) which specifies which ComplexIO are we gettin=
g
+ *
+ * Gets settings from HW registers and fills in the internal driver memo=
ry
+ * Returns 0 if successful, or -EINVAL if invalid IO number is passed.
+ **/
+int isp_csi2_timings_get(u8 io)
+{
+       struct isp_csi2_timings_cfg *currtimings;
+       struct isp_csi2_timings_cfg_update *currtimings_u;
+       u32 reg;
+
+       if (io > 2) {
+               printk(KERN_ERR "CSI2 - Timings config: Invalid IO number=
\n");
+               return -EINVAL;
+       }
+
+       currtimings =3D &current_csi2_cfg.timings[io - 1];
+       currtimings_u =3D &current_csi2_cfg_update.timings[io - 1];
+
+       reg =3D omap_readl(ISPCSI2_TIMING);
+       if ((reg & ISPCSI2_TIMING_FORCE_RX_MODE_IO_MASK(io)) =3D=3D
+                               ISPCSI2_TIMING_FORCE_RX_MODE_IO_ENABLE(io=
))
+               currtimings->force_rx_mode =3D true;
+       else
+               currtimings->force_rx_mode =3D false;
+       currtimings_u->force_rx_mode =3D false;
+
+       if ((reg & ISPCSI2_TIMING_STOP_STATE_X16_IO_MASK(io)) =3D=3D
+                               ISPCSI2_TIMING_STOP_STATE_X16_IO_ENABLE(i=
o))
+               currtimings->stop_state_16x =3D true;
+       else
+               currtimings->stop_state_16x =3D false;
+       currtimings_u->stop_state_16x =3D false;
+
+       if ((reg & ISPCSI2_TIMING_STOP_STATE_X4_IO_MASK(io)) =3D=3D
+                               ISPCSI2_TIMING_STOP_STATE_X4_IO_ENABLE(io=
))
+               currtimings->stop_state_4x =3D true;
+       else
+               currtimings->stop_state_4x =3D false;
+       currtimings_u->stop_state_4x =3D false;
+
+       currtimings->stop_state_counter =3D (reg &
+                       ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_MASK(io)) >>
+                       ISPCSI2_TIMING_STOP_STATE_COUNTER_IO_SHIFT(io);
+       currtimings_u->stop_state_counter =3D false;
+       update_timing =3D false;
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_update_all - Applies specified CSI2 timing configura=
tion.
+ * @force_update: Flag to force rewrite of registers, even if they haven=
't been
+ *                updated with the isp_csi2_timings_config_*() functions=
.
+ *
+ * It only saves settings when they were previously updated using the
+ * isp_csi2_timings_config_*() functions, unless the force_update flag i=
s
+ * set to true.
+ * Always returns 0.
+ **/
+int isp_csi2_timings_update_all(bool force_update)
+{
+       int i;
+
+       for (i =3D 0; i < 2; i++)
+               isp_csi2_timings_update(i, force_update);
+       return 0;
+}
+
+/**
+ * isp_csi2_timings_get_all - Gets all CSI2 ComplexIO timing configurati=
ons
+ *
+ * Always returns 0.
+ **/
+int isp_csi2_timings_get_all(void)
+{
+       int i;
+
+       for (i =3D 0; i < 2; i++)
+               isp_csi2_timings_get(i);
+       return 0;
+}
+
+/**
+ * isp_csi2_isr - CSI2 interrupt handling.
+ **/
+void isp_csi2_isr(void)
+{
+       u32 csi2_irqstatus, cpxio1_irqstatus, ctxirqstatus;
+
+       csi2_irqstatus =3D omap_readl(ISPCSI2_IRQSTATUS);
+       omap_writel(csi2_irqstatus, ISPCSI2_IRQSTATUS);
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_COMPLEXIO1_ERR_IRQ) {
+               cpxio1_irqstatus =3D omap_readl(ISPCSI2_COMPLEXIO1_IRQSTA=
TUS);
+               omap_writel(cpxio1_irqstatus, ISPCSI2_COMPLEXIO1_IRQSTATU=
S);
+               printk(KERN_ERR "CSI2: ComplexIO Error IRQ %x\n",
+                                                       cpxio1_irqstatus)=
;
+       }
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_CONTEXT(0)) {
+               ctxirqstatus =3D omap_readl(ISPCSI2_CTX_IRQSTATUS(0));
+               omap_writel(ctxirqstatus, ISPCSI2_CTX_IRQSTATUS(0));
+       }
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_OCP_ERR_IRQ)
+               printk(KERN_ERR "CSI2: OCP Transmission Error\n");
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_SHORT_PACKET_IRQ)
+               printk(KERN_ERR "CSI2: Short packet receive error\n");
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_ECC_CORRECTION_IRQ)
+               printk(KERN_DEBUG "CSI2: ECC correction done\n");
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_ECC_NO_CORRECTION_IRQ)
+               printk(KERN_ERR "CSI2: ECC correction failed\n");
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_COMPLEXIO2_ERR_IRQ)
+               printk(KERN_ERR "CSI2: ComplexIO #2 failed\n");
+
+       if (csi2_irqstatus & ISPCSI2_IRQSTATUS_FIFO_OVF_IRQ)
+               printk(KERN_ERR "CSI2: FIFO overflow error\n");
+
+       return;
+}
+EXPORT_SYMBOL(isp_csi2_isr);
+
+/**
+ * isp_csi2_irq_complexio1_set - Enables CSI2 ComplexIO IRQs.
+ * @enable: Enable/disable CSI2 ComplexIO #1 interrupts
+ **/
+void isp_csi2_irq_complexio1_set(int enable)
+{
+       u32 reg;
+       reg =3D ISPCSI2_COMPLEXIO1_IRQENABLE_STATEALLULPMEXIT |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_STATEALLULPM=
ENTER |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM5 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL5 =
|
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC5 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS=
5 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS5 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM4 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL4 =
|
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC4 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS=
4 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS4 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM3 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL3 =
|
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC3 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS=
3 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS3 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM2 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL2 =
|
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC2 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS=
2 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS2 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_STATEULPM1 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRCONTROL1 =
|
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRESC1 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTSYNCHS=
1 |
+                               ISPCSI2_COMPLEXIO1_IRQENABLE_ERRSOTHS1;
+       omap_writel(reg, ISPCSI2_COMPLEXIO1_IRQSTATUS);
+       if (enable)
+               reg |=3D omap_readl(ISPCSI2_COMPLEXIO1_IRQENABLE);
+       else
+               reg =3D 0;
+       omap_writel(reg, ISPCSI2_COMPLEXIO1_IRQENABLE);
+}
+EXPORT_SYMBOL(isp_csi2_irq_complexio1_set);
+
+/**
+ * isp_csi2_irq_ctx_set - Enables CSI2 Context IRQs.
+ * @enable: Enable/disable CSI2 Context interrupts
+ **/
+void isp_csi2_irq_ctx_set(int enable)
+{
+       u32 reg;
+       int i;
+
+       reg =3D ISPCSI2_CTX_IRQSTATUS_FS_IRQ | ISPCSI2_CTX_IRQSTATUS_FE_I=
RQ;
+       for (i =3D 0; i < 8; i++) {
+               omap_writel(reg, ISPCSI2_CTX_IRQSTATUS(i));
+               if (enable) {
+                       omap_writel(omap_readl(ISPCSI2_CTX_IRQENABLE(i)) =
| reg,
+                                               ISPCSI2_CTX_IRQENABLE(i))=
;
+               } else
+                       omap_writel(0, ISPCSI2_CTX_IRQENABLE(i));
+       }
+
+}
+EXPORT_SYMBOL(isp_csi2_irq_ctx_set);
+
+/**
+ * isp_csi2_irq_status_set - Enables CSI2 Status IRQs.
+ * @enable: Enable/disable CSI2 Status interrupts
+ **/
+void isp_csi2_irq_status_set(int enable)
+{
+       u32 reg;
+       reg =3D ISPCSI2_IRQSTATUS_OCP_ERR_IRQ |
+                               ISPCSI2_IRQSTATUS_SHORT_PACKET_IRQ |
+                               ISPCSI2_IRQSTATUS_ECC_CORRECTION_IRQ |
+                               ISPCSI2_IRQSTATUS_ECC_NO_CORRECTION_IRQ |
+                               ISPCSI2_IRQSTATUS_COMPLEXIO2_ERR_IRQ |
+                               ISPCSI2_IRQSTATUS_COMPLEXIO1_ERR_IRQ |
+                               ISPCSI2_IRQSTATUS_FIFO_OVF_IRQ |
+                               ISPCSI2_IRQSTATUS_CONTEXT(0);
+       omap_writel(reg, ISPCSI2_IRQSTATUS);
+       if (enable)
+               reg |=3D omap_readl(ISPCSI2_IRQENABLE);
+       else
+               reg =3D 0;
+
+       omap_writel(reg, ISPCSI2_IRQENABLE);
+}
+EXPORT_SYMBOL(isp_csi2_irq_status_set);
+
+/**
+ * isp_csi2_irq_status_set - Enables main CSI2 IRQ.
+ * @enable: Enable/disable main CSI2 interrupt
+ **/
+void isp_csi2_irq_set(int enable)
+{
+       if (enable) {
+               omap_writel(IRQ0STATUS_CSIA_IRQ, ISP_IRQ0STATUS);
+               omap_writel(omap_readl(ISP_IRQ0ENABLE) | IRQ0ENABLE_CSIA_=
IRQ,
+                                                               ISP_IRQ0E=
NABLE);
+       } else {
+               omap_writel(IRQ0STATUS_CSIA_IRQ, ISP_IRQ0STATUS);
+               omap_writel(omap_readl(ISP_IRQ0ENABLE) & ~IRQ0ENABLE_CSIA=
_IRQ,
+                                                               ISP_IRQ0E=
NABLE);
+       }
+}
+EXPORT_SYMBOL(isp_csi2_irq_set);
+
+/**
+ * isp_csi2_irq_all_set - Enable/disable CSI2 interrupts.
+ * @enable: 0-Disable, 1-Enable.
+ **/
+void isp_csi2_irq_all_set(int enable)
+{
+       if (enable) {
+               isp_csi2_irq_complexio1_set(enable);
+               isp_csi2_irq_ctx_set(enable);
+               isp_csi2_irq_status_set(enable);
+               isp_csi2_irq_set(enable);
+       } else {
+               isp_csi2_irq_set(enable);
+               isp_csi2_irq_status_set(enable);
+               isp_csi2_irq_ctx_set(enable);
+               isp_csi2_irq_complexio1_set(enable);
+       }
+       return;
+}
+EXPORT_SYMBOL(isp_csi2_irq_all_set);
+
+/**
+ * isp_csi2_reset - Resets the CSI2 module.
+ *
+ * Returns 0 if successful, or -EBUSY if power command didn't respond.
+ **/
+int isp_csi2_reset(void)
+{
+       u32 reg;
+       u8 soft_reset_retries =3D 0;
+       int i;
+
+       reg =3D omap_readl(ISPCSI2_SYSCONFIG);
+       reg |=3D ISPCSI2_SYSCONFIG_SOFT_RESET_RESET;
+       omap_writel(reg, ISPCSI2_SYSCONFIG);
+
+       do {
+               reg =3D omap_readl(ISPCSI2_SYSSTATUS) &
+                               ISPCSI2_SYSSTATUS_RESET_DONE_MASK;
+               if (reg =3D=3D ISPCSI2_SYSSTATUS_RESET_DONE_DONE)
+                       break;
+               soft_reset_retries++;
+               if (soft_reset_retries < 5)
+                       udelay(100);
+       } while (soft_reset_retries < 5);
+
+       if (soft_reset_retries =3D=3D 5) {
+               printk(KERN_ERR "CSI2: Soft reset try count exceeded!\n")=
;
+               return -EBUSY;
+       }
+
+       reg =3D omap_readl(ISPCSI2_SYSCONFIG);
+       reg &=3D ~ISPCSI2_SYSCONFIG_MSTANDBY_MODE_MASK;
+       reg |=3D ISPCSI2_SYSCONFIG_MSTANDBY_MODE_NO;
+       reg &=3D ~ISPCSI2_SYSCONFIG_AUTO_IDLE_MASK;
+       omap_writel(reg, ISPCSI2_SYSCONFIG);
+
+       uses_videoport =3D false;
+       update_complexio_cfg1 =3D false;
+       update_phy_cfg0 =3D false;
+       update_phy_cfg1 =3D false;
+       for (i =3D 0; i < 8; i++) {
+               update_ctx_ctrl1[i] =3D false;
+               update_ctx_ctrl2[i] =3D false;
+               update_ctx_ctrl3[i] =3D false;
+       }
+       update_timing =3D false;
+       update_ctrl =3D false;
+
+       isp_csi2_complexio_lanes_get();
+       isp_csi2_ctrl_get();
+       isp_csi2_ctx_get_all();
+       isp_csi2_phy_get();
+       isp_csi2_timings_get_all();
+
+       isp_csi2_complexio_power_autoswitch(true);
+       isp_csi2_complexio_power(ISP_CSI2_POWER_ON);
+
+       isp_csi2_timings_config_forcerxmode(1, true);
+       isp_csi2_timings_config_stopstate_cnt(1, 0x1FF);
+       isp_csi2_timings_update_all(true);
+
+       return 0;
+}
+
+/**
+ * isp_csi2_enable - Enables the CSI2 module.
+ * @enable: Enables/disables the CSI2 module.
+ **/
+void isp_csi2_enable(int enable)
+{
+       if (enable) {
+               isp_csi2_ctx_config_enabled(0, true);
+               isp_csi2_ctx_config_eof_enabled(0, true);
+               isp_csi2_ctx_config_checksum_enabled(0, true);
+               isp_csi2_ctx_update(0, false);
+
+               isp_csi2_ctrl_config_ecc_enable(true);
+               isp_csi2_ctrl_config_if_enable(true);
+               isp_csi2_ctrl_update(false);
+       } else {
+               isp_csi2_ctx_config_enabled(0, false);
+               isp_csi2_ctx_config_eof_enabled(0, false);
+               isp_csi2_ctx_config_checksum_enabled(0, false);
+               isp_csi2_ctx_update(0, false);
+
+               isp_csi2_ctrl_config_ecc_enable(false);
+               isp_csi2_ctrl_config_if_enable(false);
+               isp_csi2_ctrl_update(false);
+       }
+}
+EXPORT_SYMBOL(isp_csi2_enable);
+
+/**
+ * isp_csi2_regdump - Prints CSI2 debug information.
+ **/
+void isp_csi2_regdump(void)
+{
+       printk(KERN_DEBUG "-------------Register dump-------------\n");
+
+       printk(KERN_DEBUG "ISP_CTRL: %x\n", omap_readl(ISP_CTRL));
+       printk(KERN_DEBUG "ISP_TCTRL_CTRL: %x\n", omap_readl(ISP_TCTRL_CT=
RL));
+
+       printk(KERN_DEBUG "ISPCCDC_SDR_ADDR: %x\n",
+                                               omap_readl(ISPCCDC_SDR_AD=
DR));
+       printk(KERN_DEBUG "ISPCCDC_SYN_MODE: %x\n",
+                                               omap_readl(ISPCCDC_SYN_MO=
DE));
+       printk(KERN_DEBUG "ISPCCDC_CFG: %x\n", omap_readl(ISPCCDC_CFG));
+       printk(KERN_DEBUG "ISPCCDC_FMTCFG: %x\n", omap_readl(ISPCCDC_FMTC=
FG));
+       printk(KERN_DEBUG "ISPCCDC_HSIZE_OFF: %x\n",
+                                               omap_readl(ISPCCDC_HSIZE_=
OFF));
+       printk(KERN_DEBUG "ISPCCDC_HORZ_INFO: %x\n",
+                                               omap_readl(ISPCCDC_HORZ_I=
NFO));
+       printk(KERN_DEBUG "ISPCCDC_VERT_START: %x\n",
+                                               omap_readl(ISPCCDC_VERT_S=
TART));
+       printk(KERN_DEBUG "ISPCCDC_VERT_LINES: %x\n",
+                                               omap_readl(ISPCCDC_VERT_L=
INES));
+
+       printk(KERN_DEBUG "ISPCSI2_COMPLEXIO_CFG1: %x\n",
+                                       omap_readl(ISPCSI2_COMPLEXIO_CFG1=
));
+       printk(KERN_DEBUG "ISPCSI2_SYSSTATUS: %x\n",
+                                               omap_readl(ISPCSI2_SYSSTA=
TUS));
+       printk(KERN_DEBUG "ISPCSI2_SYSCONFIG: %x\n",
+                                               omap_readl(ISPCSI2_SYSCON=
FIG));
+       printk(KERN_DEBUG "ISPCSI2_IRQENABLE: %x\n",
+                                               omap_readl(ISPCSI2_IRQENA=
BLE));
+       printk(KERN_DEBUG "ISPCSI2_IRQSTATUS: %x\n",
+                                               omap_readl(ISPCSI2_IRQSTA=
TUS));
+
+       printk(KERN_DEBUG "ISPCSI2_CTX_IRQENABLE(0): %x\n",
+                                       omap_readl(ISPCSI2_CTX_IRQENABLE(=
0)));
+       printk(KERN_DEBUG "ISPCSI2_CTX_IRQSTATUS(0): %x\n",
+                                       omap_readl(ISPCSI2_CTX_IRQSTATUS(=
0)));
+       printk(KERN_DEBUG "ISPCSI2_TIMING: %x\n", omap_readl(ISPCSI2_TIMI=
NG));
+       printk(KERN_DEBUG "ISPCSI2PHY_CFG0: %x\n", omap_readl(ISPCSI2PHY_=
CFG0));
+       printk(KERN_DEBUG "ISPCSI2PHY_CFG1: %x\n", omap_readl(ISPCSI2PHY_=
CFG1));
+       printk(KERN_DEBUG "ISPCSI2_CTX_CTRL1(0): %x\n",
+                                       omap_readl(ISPCSI2_CTX_CTRL1(0)))=
;
+       printk(KERN_DEBUG "ISPCSI2_CTX_CTRL2(0): %x\n",
+                                       omap_readl(ISPCSI2_CTX_CTRL2(0)))=
;
+       printk(KERN_DEBUG "ISPCSI2_CTX_CTRL3(0): %x\n",
+                                       omap_readl(ISPCSI2_CTX_CTRL3(0)))=
;
+       printk(KERN_DEBUG "ISPCSI2_CTX_DAT_OFST(0): %x\n",
+                                       omap_readl(ISPCSI2_CTX_DAT_OFST(0=
)));
+       printk(KERN_DEBUG "ISPCSI2_CTX_DAT_PING_ADDR(0): %x\n",
+                               omap_readl(ISPCSI2_CTX_DAT_PING_ADDR(0)))=
;
+       printk(KERN_DEBUG "ISPCSI2_CTX_DAT_PONG_ADDR(0): %x\n",
+                               omap_readl(ISPCSI2_CTX_DAT_PONG_ADDR(0)))=
;
+       printk(KERN_DEBUG "ISPCSI2_CTRL: %x\n", omap_readl(ISPCSI2_CTRL))=
;
+       printk(KERN_DEBUG "---------------------------------------\n");
+}
+
+/**
+ * isp_csi2_cleanup - Routine for module driver cleanup
+ **/
+void __exit isp_csi2_cleanup(void)
+{
+       return;
+}
+
+/**
+ * isp_csi2_init - Routine for module driver init
+ **/
+int __init isp_csi2_init(void)
+{
+       int i;
+
+       update_complexio_cfg1 =3D false;
+       update_phy_cfg0 =3D false;
+       update_phy_cfg1 =3D false;
+       for (i =3D 0; i < 8; i++) {
+               update_ctx_ctrl1[i] =3D false;
+               update_ctx_ctrl2[i] =3D false;
+               update_ctx_ctrl3[i] =3D false;
+       }
+       update_timing =3D false;
+       update_ctrl =3D false;
+
+       memset(&current_csi2_cfg, 0, sizeof(current_csi2_cfg));
+       memset(&current_csi2_cfg_update, 0, sizeof(current_csi2_cfg_updat=
e));
+       return 0;
+}
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("ISP CSI2 Receiver Module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/video/isp/ispcsi2.h b/drivers/media/video/isp/=
ispcsi2.h
new file mode 100644
index 0000000..1419bda
--- /dev/null
+++ b/drivers/media/video/isp/ispcsi2.h
@@ -0,0 +1,232 @@
+/*
+ * drivers/media/video/isp/ispcsi2.h
+ *
+ * Copyright (C) 2008 Texas Instruments.
+ *
+ * Contributors:
+ *     Sergio Aguirre <saaguirre@ti.com>
+ *     Dominic Curran <dcurran@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef OMAP_ISP_CSI2_API_H
+#define OMAP_ISP_CSI2_API_H
+#include <linux/videodev2.h>
+
+enum isp_csi2_irqevents {
+       OCP_ERR_IRQ =3D 0x4000,
+       SHORT_PACKET_IRQ =3D 0x2000,
+       ECC_CORRECTION_IRQ =3D 0x1000,
+       ECC_NO_CORRECTION_IRQ =3D 0x800,
+       COMPLEXIO2_ERR_IRQ =3D 0x400,
+       COMPLEXIO1_ERR_IRQ =3D 0x200,
+       FIFO_OVF_IRQ =3D 0x100,
+       CONTEXT7 =3D 0x80,
+       CONTEXT6 =3D 0x40,
+       CONTEXT5 =3D 0x20,
+       CONTEXT4 =3D 0x10,
+       CONTEXT3 =3D 0x8,
+       CONTEXT2 =3D 0x4,
+       CONTEXT1 =3D 0x2,
+       CONTEXT0 =3D 0x1,
+};
+
+enum isp_csi2_ctx_irqevents {
+       CTX_ECC_CORRECTION =3D 0x100,
+       CTX_LINE_NUMBER =3D 0x80,
+       CTX_FRAME_NUMBER =3D 0x40,
+       CTX_CS =3D 0x20,
+       CTX_LE =3D 0x8,
+       CTX_LS =3D 0x4,
+       CTX_FE =3D 0x2,
+       CTX_FS =3D 0x1,
+};
+
+enum isp_csi2_power_cmds {
+       ISP_CSI2_POWER_OFF,
+       ISP_CSI2_POWER_ON,
+       ISP_CSI2_POWER_ULPW,
+};
+
+enum isp_csi2_frame_mode {
+       ISP_CSI2_FRAME_IMMEDIATE,
+       ISP_CSI2_FRAME_AFTERFEC,
+};
+
+struct csi2_lanecfg {
+       u8 pos;
+       u8 pol;
+};
+
+struct isp_csi2_lanes_cfg {
+       struct csi2_lanecfg data[4];
+       struct csi2_lanecfg clk;
+};
+
+struct isp_csi2_lanes_cfg_update {
+       bool data[4];
+       bool clk;
+};
+
+struct isp_csi2_phy_cfg {
+       u8 ths_term;
+       u8 ths_settle;
+       u8 tclk_term;
+       unsigned tclk_miss:1;
+       u8 tclk_settle;
+};
+
+struct isp_csi2_phy_cfg_update {
+       bool ths_term;
+       bool ths_settle;
+       bool tclk_term;
+       bool tclk_miss;
+       bool tclk_settle;
+};
+
+struct isp_csi2_ctx_cfg {
+       u8 virtual_id;
+       u8 frame_count;
+       struct v4l2_pix_format format;
+       u16 alpha;
+       u16 data_offset;
+       u32 ping_addr;
+       u32 pong_addr;
+       bool eof_enabled;
+       bool eol_enabled;
+       bool checksum_enabled;
+       bool enabled;
+};
+
+struct isp_csi2_ctx_cfg_update {
+       bool virtual_id;
+       bool frame_count;
+       bool format;
+       bool alpha;
+       bool data_offset;
+       bool ping_addr;
+       bool pong_addr;
+       bool eof_enabled;
+       bool eol_enabled;
+       bool checksum_enabled;
+       bool enabled;
+};
+
+struct isp_csi2_timings_cfg {
+       bool force_rx_mode;
+       bool stop_state_16x;
+       bool stop_state_4x;
+       u16 stop_state_counter;
+};
+
+struct isp_csi2_timings_cfg_update {
+       bool force_rx_mode;
+       bool stop_state_16x;
+       bool stop_state_4x;
+       bool stop_state_counter;
+};
+
+struct isp_csi2_ctrl_cfg {
+       bool vp_clk_enable;
+       bool vp_only_enable;
+       u8 vp_out_ctrl;
+       bool debug_enable;
+       u8 burst_size;
+       enum isp_csi2_frame_mode frame_mode;
+       bool ecc_enable;
+       bool secure_mode;
+       bool if_enable;
+};
+
+struct isp_csi2_ctrl_cfg_update {
+       bool vp_clk_enable;
+       bool vp_only_enable;
+       bool vp_out_ctrl;
+       bool debug_enable;
+       bool burst_size;
+       bool frame_mode;
+       bool ecc_enable;
+       bool secure_mode;
+       bool if_enable;
+};
+
+struct isp_csi2_cfg {
+       struct isp_csi2_lanes_cfg lanes;
+       struct isp_csi2_phy_cfg phy;
+       struct isp_csi2_ctx_cfg contexts[8];
+       struct isp_csi2_timings_cfg timings[2];
+       struct isp_csi2_ctrl_cfg ctrl;
+};
+
+struct isp_csi2_cfg_update {
+       struct isp_csi2_lanes_cfg_update lanes;
+       struct isp_csi2_phy_cfg_update phy;
+       struct isp_csi2_ctx_cfg_update contexts[8];
+       struct isp_csi2_timings_cfg_update timings[2];
+       struct isp_csi2_ctrl_cfg_update ctrl;
+};
+
+int isp_csi2_complexio_lanes_config(struct isp_csi2_lanes_cfg *reqcfg);
+int isp_csi2_complexio_lanes_update(bool force_update);
+int isp_csi2_complexio_lanes_get(void);
+int isp_csi2_complexio_power_autoswitch(bool enable);
+int isp_csi2_complexio_power(enum isp_csi2_power_cmds power_cmd);
+int isp_csi2_ctrl_config_frame_mode(enum isp_csi2_frame_mode frame_mode)=
;
+int isp_csi2_ctrl_config_vp_clk_enable(bool vp_clk_enable);
+int isp_csi2_ctrl_config_vp_only_enable(bool vp_only_enable);
+int isp_csi2_ctrl_config_debug_enable(bool debug_enable);
+int isp_csi2_ctrl_config_burst_size(u8 burst_size);
+int isp_csi2_ctrl_config_ecc_enable(bool ecc_enable);
+int isp_csi2_ctrl_config_secure_mode(bool secure_mode);
+int isp_csi2_ctrl_config_if_enable(bool if_enable);
+int isp_csi2_ctrl_config_vp_out_ctrl(u8 vp_out_ctrl);
+int isp_csi2_ctrl_update(bool force_update);
+int isp_csi2_ctrl_get(void);
+int isp_csi2_ctx_config_virtual_id(u8 ctxnum, u8 virtual_id);
+int isp_csi2_ctx_config_frame_count(u8 ctxnum, u8 frame_count);
+int isp_csi2_ctx_config_format(u8 ctxnum, u32 pixformat);
+int isp_csi2_ctx_config_alpha(u8 ctxnum, u16 alpha);
+int isp_csi2_ctx_config_data_offset(u8 ctxnum, u16 data_offset);
+int isp_csi2_ctx_config_ping_addr(u8 ctxnum, u32 ping_addr);
+int isp_csi2_ctx_config_pong_addr(u8 ctxnum, u32 pong_addr);
+int isp_csi2_ctx_config_eof_enabled(u8 ctxnum, bool eof_enabled);
+int isp_csi2_ctx_config_eol_enabled(u8 ctxnum, bool eol_enabled);
+int isp_csi2_ctx_config_checksum_enabled(u8 ctxnum, bool checksum_enable=
d);
+int isp_csi2_ctx_config_enabled(u8 ctxnum, bool enabled);
+int isp_csi2_ctx_update(u8 ctxnum, bool force_update);
+int isp_csi2_ctx_get(u8 ctxnum);
+int isp_csi2_ctx_update_all(bool force_update);
+int isp_csi2_ctx_get_all(void);
+int isp_csi2_phy_config(struct isp_csi2_phy_cfg *desiredphyconfig);
+int isp_csi2_calc_phy_cfg0(u32 mipiclk, u32 lbound_hs_settle,
+                                                       u32 ubound_hs_set=
tle);
+int isp_csi2_phy_update(bool force_update);
+int isp_csi2_phy_get(void);
+int isp_csi2_timings_config_forcerxmode(u8 io, bool force_rx_mode);
+int isp_csi2_timings_config_stopstate_16x(u8 io, bool stop_state_16x);
+int isp_csi2_timings_config_stopstate_4x(u8 io, bool stop_state_4x);
+int isp_csi2_timings_config_stopstate_cnt(u8 io, u16 stop_state_counter)=
;
+int isp_csi2_timings_update(u8 io, bool force_update);
+int isp_csi2_timings_get(u8 io);
+int isp_csi2_timings_update_all(bool force_update);
+int isp_csi2_timings_get_all(void);
+void isp_csi2_irq_complexio1_set(int enable);
+void isp_csi2_irq_ctx_set(int enable);
+void isp_csi2_irq_status_set(int enable);
+void isp_csi2_irq_set(int enable);
+void isp_csi2_irq_all_set(int enable);
+
+void isp_csi2_isr(void);
+int isp_csi2_reset(void);
+void isp_csi2_enable(int enable);
+void isp_csi2_regdump(void);
+
+#endif /* OMAP_ISP_CSI2_H */
+
--
1.5.6.5


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
