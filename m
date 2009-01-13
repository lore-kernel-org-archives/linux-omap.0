From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [REVIEW PATCH 05/14] OMAP: CAM: Add ISP Front end
Date: Mon, 12 Jan 2009 20:03:18 -0600
Message-ID: <A24693684029E5489D1D202277BE894416429F9B@dlee02.ent.ti.com>
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
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Nagalla,
	Hari" <hnagalla@ti.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This adds the OMAP ISP Front end modules to the kernel. Includes:
* ISP CCDC Driver

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/ispccdc.c | 1488 +++++++++++++++++++++++++++++++=
++++++
 drivers/media/video/isp/ispccdc.h |  200 +++++
 2 files changed, 1688 insertions(+), 0 deletions(-)
 create mode 100644 drivers/media/video/isp/ispccdc.c
 create mode 100644 drivers/media/video/isp/ispccdc.h

diff --git a/drivers/media/video/isp/ispccdc.c b/drivers/media/video/isp/=
ispccdc.c
new file mode 100644
index 0000000..f200baf
--- /dev/null
+++ b/drivers/media/video/isp/ispccdc.c
@@ -0,0 +1,1488 @@
+/*
+ * drivers/media/video/isp/ispccdc.c
+ *
+ * Driver Library for CCDC module in TI's OMAP3 Camera ISP
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ *
+ * Contributors:
+ *     Senthilvadivu Guruswamy <svadivu@ti.com>
+ *     Pallavi Kulkarni <p-kulkarni@ti.com>
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
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <asm/mach-types.h>
+#include <linux/io.h>
+#include <linux/scatterlist.h>
+#include <linux/uaccess.h>
+
+#include "isp.h"
+#include "ispreg.h"
+#include "ispccdc.h"
+#include "ispmmu.h"
+
+#define LSC_TABLE_INIT_SIZE    50052
+
+static u32 *fpc_table_add;
+static unsigned long fpc_table_add_m;
+
+/**
+ * struct isp_ccdc - Structure for the CCDC module to store its own info=
rmation
+ * @ccdc_inuse: Flag to determine if CCDC has been reserved or not (0 or=
 1).
+ * @ccdcout_w: CCDC output width.
+ * @ccdcout_h: CCDC output height.
+ * @ccdcin_w: CCDC input width.
+ * @ccdcin_h: CCDC input height.
+ * @ccdcin_woffset: CCDC input horizontal offset.
+ * @ccdcin_hoffset: CCDC input vertical offset.
+ * @crop_w: Crop width.
+ * @crop_h: Crop weight.
+ * @ccdc_inpfmt: CCDC input format.
+ * @ccdc_outfmt: CCDC output format.
+ * @vpout_en: Video port output enable.
+ * @wen: Data write enable.
+ * @exwen: External data write enable.
+ * @refmt_en: Reformatter enable.
+ * @ccdcslave: CCDC slave mode enable.
+ * @syncif_ipmod: Image
+ * @obclamp_en: Data input format.
+ * @mutexlock: Mutex used to get access to the CCDC.
+ */
+static struct isp_ccdc {
+       u8 ccdc_inuse;
+       u32 ccdcout_w;
+       u32 ccdcout_h;
+       u32 ccdcin_w;
+       u32 ccdcin_h;
+       u32 ccdcin_woffset;
+       u32 ccdcin_hoffset;
+       u32 crop_w;
+       u32 crop_h;
+       u8 ccdc_inpfmt;
+       u8 ccdc_outfmt;
+       u8 vpout_en;
+       u8 wen;
+       u8 exwen;
+       u8 refmt_en;
+       u8 ccdcslave;
+       u8 syncif_ipmod;
+       u8 obclamp_en;
+       u8 lsc_en;
+       struct mutex mutexlock; /* For checking/modifying ccdc_inuse */
+       u32 wenlog;
+} ispccdc_obj;
+
+static struct ispccdc_lsc_config lsc_config;
+static u8 *lsc_gain_table;
+static unsigned long lsc_ispmmu_addr;
+static int lsc_initialized;
+static int size_mismatch;
+static u8 ccdc_use_lsc;
+static u8 ispccdc_lsc_tbl[LSC_TABLE_INIT_SIZE];
+
+/* Structure for saving/restoring CCDC module registers*/
+static struct isp_reg ispccdc_reg_list[] =3D {
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_MODE, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_HD_VD_WID, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PIX_LINES, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_HORZ_INFO, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VERT_START, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VERT_LINES, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CULLING, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_HSIZE_OFF, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDR_ADDR, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CLAMP, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_DCSUB, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_COLPTN, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_BLKCMP, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC_ADDR, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VDINT, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_ALAW, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_REC656IF, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CFG, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCFG, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_HORZ, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_VERT, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR0, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR1, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR2, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR3, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR4, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR5, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR6, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_ADDR7, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PRGEVEN0, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PRGEVEN1, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PRGODD0, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PRGODD1, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VP_OUT, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_CONFIG, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_INITIAL, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_TABLE_BASE, 0},
+       {OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_TABLE_OFFSET, 0},
+       {0, ISP_TOK_TERM, 0}
+};
+
+/**
+ * omap34xx_isp_ccdc_config - Sets CCDC configuration from userspace
+ * @userspace_add: Structure containing CCDC configuration sent from use=
rspace.
+ *
+ * Returns 0 if successful, -EINVAL if the pointer to the configuration
+ * structure is null, or the copy_from_user function fails to copy user =
space
+ * memory to kernel space memory.
+ **/
+int omap34xx_isp_ccdc_config(void *userspace_add)
+{
+       struct ispccdc_bclamp bclamp_t;
+       struct ispccdc_blcomp blcomp_t;
+       struct ispccdc_fpc fpc_t;
+       struct ispccdc_culling cull_t;
+       struct ispccdc_update_config *ccdc_struct;
+       u32 old_size;
+
+       if (userspace_add =3D=3D NULL)
+               return -EINVAL;
+
+       ccdc_struct =3D (struct ispccdc_update_config *) userspace_add;
+
+       if (ISP_ABS_CCDC_ALAW & ccdc_struct->flag) {
+               if (ISP_ABS_CCDC_ALAW & ccdc_struct->update)
+                       ispccdc_config_alaw(ccdc_struct->alawip);
+               ispccdc_enable_alaw(1);
+       } else if (ISP_ABS_CCDC_ALAW & ccdc_struct->update)
+               ispccdc_enable_alaw(0);
+
+       if (ISP_ABS_CCDC_LPF & ccdc_struct->flag)
+               ispccdc_enable_lpf(1);
+       else
+               ispccdc_enable_lpf(0);
+
+       if (ISP_ABS_CCDC_BLCLAMP & ccdc_struct->flag) {
+               if (ISP_ABS_CCDC_BLCLAMP & ccdc_struct->update) {
+                       if (copy_from_user(&bclamp_t, (struct ispccdc_bcl=
amp *)
+                                               (ccdc_struct->bclamp),
+                                               sizeof(struct ispccdc_bcl=
amp)))
+                               goto copy_from_user_err;
+
+                       ispccdc_enable_black_clamp(1);
+                       ispccdc_config_black_clamp(bclamp_t);
+               } else
+                       ispccdc_enable_black_clamp(1);
+       } else {
+               if (ISP_ABS_CCDC_BLCLAMP & ccdc_struct->update) {
+                       ispccdc_enable_black_clamp(0);
+                       ispccdc_config_black_clamp(bclamp_t);
+               }
+       }
+
+       if (ISP_ABS_CCDC_BCOMP & ccdc_struct->update) {
+               if (copy_from_user(&blcomp_t, (struct ispccdc_blcomp *)
+                                                       (ccdc_struct->blc=
omp),
+                                                       sizeof(blcomp_t))=
)
+                       goto copy_from_user_err;
+
+               ispccdc_config_black_comp(blcomp_t);
+       }
+
+       if (ISP_ABS_CCDC_FPC & ccdc_struct->flag) {
+               if (ISP_ABS_CCDC_FPC & ccdc_struct->update) {
+                       if (copy_from_user(&fpc_t, (struct ispccdc_fpc *)
+                                                       (ccdc_struct->fpc=
),
+                                                       sizeof(fpc_t)))
+                               goto copy_from_user_err;
+                       fpc_table_add =3D kmalloc((64 + (fpc_t.fpnum * 4)=
),
+                                                       GFP_KERNEL | GFP_=
DMA);
+                       if (!fpc_table_add) {
+                               printk(KERN_ERR "Cannot allocate memory f=
or"
+                                                               " FPC tab=
le");
+                               return -ENOMEM;
+                       }
+                       while (((int)fpc_table_add & 0xFFFFFFC0) !=3D
+                                                       (int)fpc_table_ad=
d)
+                               fpc_table_add++;
+
+                       fpc_table_add_m =3D ispmmu_map(virt_to_phys
+                                                       (fpc_table_add),
+                                                       (fpc_t.fpnum) * 4=
);
+
+                       if (copy_from_user(fpc_table_add, (u32 *)fpc_t.fp=
caddr,
+                                                       fpc_t.fpnum * 4))
+                               goto copy_from_user_err;
+
+                       fpc_t.fpcaddr =3D fpc_table_add_m;
+                       ispccdc_config_fpc(fpc_t);
+               }
+               ispccdc_enable_fpc(1);
+       } else if (ISP_ABS_CCDC_FPC & ccdc_struct->update)
+                       ispccdc_enable_fpc(0);
+
+       if (ISP_ABS_CCDC_CULL & ccdc_struct->update) {
+               if (copy_from_user(&cull_t, (struct ispccdc_culling *)
+                                                       (ccdc_struct->cul=
l),
+                                                       sizeof(cull_t)))
+                       goto copy_from_user_err;
+               ispccdc_config_culling(cull_t);
+       }
+
+       if (is_isplsc_activated()) {
+               if (ISP_ABS_CCDC_CONFIG_LSC & ccdc_struct->flag) {
+                       if (ISP_ABS_CCDC_CONFIG_LSC & ccdc_struct->update=
) {
+                               old_size =3D lsc_config.size;
+                               if (copy_from_user(&lsc_config,
+                                               (struct ispccdc_lsc_confi=
g *)
+                                               (ccdc_struct->lsc_cfg),
+                                               sizeof(struct
+                                               ispccdc_lsc_config)))
+                                       goto copy_from_user_err;
+                               lsc_initialized =3D 0;
+                               if (lsc_config.size <=3D old_size)
+                                       size_mismatch =3D 0;
+                               else
+                                       size_mismatch =3D 1;
+                               ispccdc_config_lsc(&lsc_config);
+                       }
+                       ccdc_use_lsc =3D 1;
+               } else if (ISP_ABS_CCDC_CONFIG_LSC & ccdc_struct->update)=
 {
+                               ispccdc_enable_lsc(0);
+                               ccdc_use_lsc =3D 0;
+               }
+               if (ISP_ABS_TBL_LSC & ccdc_struct->update) {
+                       if (size_mismatch) {
+                               ispmmu_unmap(lsc_ispmmu_addr);
+                               kfree(lsc_gain_table);
+                               lsc_gain_table =3D kmalloc(
+                                       lsc_config.size,
+                                       GFP_KERNEL | GFP_DMA);
+                               if (!lsc_gain_table) {
+                                       printk(KERN_ERR
+                                               "Cannot allocate\
+                                               memory for \
+                                               gain tables \n");
+                                       return -ENOMEM;
+                               }
+                               lsc_ispmmu_addr =3D ispmmu_map(
+                                       virt_to_phys(lsc_gain_table),
+                                       lsc_config.size);
+                               isp_reg_writel(lsc_ispmmu_addr,
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_LSC_TABLE_BASE);
+                               lsc_initialized =3D 1;
+                               size_mismatch =3D 0;
+                       }
+                       if (copy_from_user(lsc_gain_table,
+                               (ccdc_struct->lsc), lsc_config.size))
+                               goto copy_from_user_err;
+               }
+       }
+
+       if (ISP_ABS_CCDC_COLPTN & ccdc_struct->update)
+               ispccdc_config_imgattr(ccdc_struct->colptn);
+
+       return 0;
+
+copy_from_user_err:
+       printk(KERN_ERR "CCDC Config:Copy From User Error");
+       return -EINVAL ;
+}
+EXPORT_SYMBOL(omap34xx_isp_ccdc_config);
+
+/**
+ * Set the value to be used for CCDC_CFG.WENLOG.
+ *  w - Value of wenlog.
+ */
+void ispccdc_set_wenlog(u32 wenlog)
+{
+       ispccdc_obj.wenlog =3D wenlog;
+}
+EXPORT_SYMBOL(ispccdc_set_wenlog);
+
+/**
+ * ispccdc_request - Reserves the CCDC module.
+ *
+ * Reserves the CCDC module and assures that is used only once at a time=
.
+ *
+ * Returns 0 if successful, or -EBUSY if CCDC module is busy.
+ **/
+int ispccdc_request(void)
+{
+       mutex_lock(&ispccdc_obj.mutexlock);
+       if (ispccdc_obj.ccdc_inuse) {
+               mutex_unlock(&ispccdc_obj.mutexlock);
+               DPRINTK_ISPCCDC("ISP_ERR : CCDC Module Busy");
+               return -EBUSY;
+       }
+
+       ispccdc_obj.ccdc_inuse =3D 1;
+       mutex_unlock(&ispccdc_obj.mutexlock);
+       isp_reg_or(OMAP3_ISP_IOMEM_MAIN, ISP_CTRL, ISPCTRL_CCDC_RAM_EN |
+                                                       ISPCTRL_CCDC_CLK_=
EN |
+                                                       ISPCTRL_SBL_WR1_R=
AM_EN);
+       isp_reg_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CFG, ISPCCDC_CFG_VDLC);
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_request);
+
+/**
+ * ispccdc_free - Frees the CCDC module.
+ *
+ * Frees the CCDC module so it can be used by another process.
+ *
+ * Returns 0 if successful, or -EINVAL if module has been already freed.
+ **/
+int ispccdc_free(void)
+{
+       mutex_lock(&ispccdc_obj.mutexlock);
+       if (!ispccdc_obj.ccdc_inuse) {
+               mutex_unlock(&ispccdc_obj.mutexlock);
+               DPRINTK_ISPCCDC("ISP_ERR: CCDC Module already freed\n");
+               return -EINVAL;
+       }
+
+       ispccdc_obj.ccdc_inuse =3D 0;
+       mutex_unlock(&ispccdc_obj.mutexlock);
+       isp_reg_and(OMAP3_ISP_IOMEM_MAIN, ISP_CTRL,
+                       ~(ISPCTRL_CCDC_CLK_EN |
+                       ISPCTRL_CCDC_RAM_EN |
+                       ISPCTRL_SBL_WR1_RAM_EN));
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_free);
+
+/**
+ * ispccdc_load_lsc - Load Lens Shading Compensation table.
+ * @table_size: LSC gain table size.
+ *
+ * Returns 0 if successful, or -ENOMEM of its no memory available.
+ **/
+int ispccdc_load_lsc(u32 table_size)
+{
+       if (!is_isplsc_activated())
+               return 0;
+
+       if (table_size =3D=3D 0)
+               return -EINVAL;
+
+       if (lsc_initialized)
+               return 0;
+
+       ispccdc_enable_lsc(0);
+       lsc_gain_table =3D kmalloc(table_size, GFP_KERNEL | GFP_DMA);
+
+       if (!lsc_gain_table) {
+               printk(KERN_ERR "Cannot allocate memory for gain tables \=
n");
+               return -ENOMEM;
+       }
+
+       memcpy(lsc_gain_table, ispccdc_lsc_tbl, table_size);
+       lsc_ispmmu_addr =3D ispmmu_map(virt_to_phys(lsc_gain_table), tabl=
e_size);
+       isp_reg_writel(lsc_ispmmu_addr, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC=
_TABLE_BASE);
+       lsc_initialized =3D 1;
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_load_lsc);
+
+/**
+ * ispccdc_config_lsc - Configures the lens shading compensation module
+ * @lsc_cfg: LSC configuration structure
+ **/
+void ispccdc_config_lsc(struct ispccdc_lsc_config *lsc_cfg)
+{
+       int reg;
+
+       if (!is_isplsc_activated())
+               return;
+
+       ispccdc_enable_lsc(0);
+       isp_reg_writel(lsc_cfg->offset, OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_LSC_TABLE_OFFSET);
+
+       reg =3D 0;
+       reg |=3D (lsc_cfg->gain_mode_n << ISPCCDC_LSC_GAIN_MODE_N_SHIFT);
+       reg |=3D (lsc_cfg->gain_mode_m << ISPCCDC_LSC_GAIN_MODE_M_SHIFT);
+       reg |=3D (lsc_cfg->gain_format << ISPCCDC_LSC_GAIN_FORMAT_SHIFT);
+       isp_reg_writel(reg, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_CONFIG);
+
+       reg =3D 0;
+       reg &=3D ~ISPCCDC_LSC_INITIAL_X_MASK;
+       reg |=3D (lsc_cfg->initial_x << ISPCCDC_LSC_INITIAL_X_SHIFT);
+       reg &=3D ~ISPCCDC_LSC_INITIAL_Y_MASK;
+       reg |=3D (lsc_cfg->initial_y << ISPCCDC_LSC_INITIAL_Y_SHIFT);
+       isp_reg_writel(reg, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_INITIAL);
+}
+EXPORT_SYMBOL(ispccdc_config_lsc);
+
+/**
+ * ispccdc_enable_lsc - Enables/Disables the Lens Shading Compensation m=
odule.
+ * @enable: 0 Disables LSC, 1 Enables LSC.
+ **/
+void ispccdc_enable_lsc(u8 enable)
+{
+       if (!is_isplsc_activated())
+               return;
+
+       if (enable) {
+               isp_reg_or(OMAP3_ISP_IOMEM_MAIN, ISP_CTRL,
+                       ISPCTRL_SBL_SHARED_RPORTB | ISPCTRL_SBL_RD_RAM_EN=
);
+
+               isp_reg_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_CONFIG, 0x1)=
;
+
+               ispccdc_obj.lsc_en =3D 1;
+       } else {
+               isp_reg_and(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_CONFIG, 0xF=
FFE);
+               ispccdc_obj.lsc_en =3D 0;
+       }
+}
+EXPORT_SYMBOL(ispccdc_enable_lsc);
+
+
+/**
+ * ispccdc_config_crop - Configures crop parameters for the ISP CCDC.
+ * @left: Left offset of the crop area.
+ * @top: Top offset of the crop area.
+ * @height: Height of the crop area.
+ * @width: Width of the crop area.
+ *
+ * The following restrictions are applied for the crop settings. If inco=
ming
+ * values do not follow these restrictions then we map the settings to t=
he
+ * closest acceptable crop value.
+ * 1) Left offset is always odd. This can be avoided if we enable byte s=
wap
+ *    option for incoming data into CCDC.
+ * 2) Top offset is always even.
+ * 3) Crop height is always even.
+ * 4) Crop width is always a multiple of 16 pixels
+ **/
+void ispccdc_config_crop(u32 left, u32 top, u32 height, u32 width)
+{
+       ispccdc_obj.ccdcin_woffset =3D left + ((left + 1) % 2);
+       ispccdc_obj.ccdcin_hoffset =3D top + (top % 2);
+
+       ispccdc_obj.crop_w =3D width - (width % 16);
+       ispccdc_obj.crop_h =3D height + (height % 2);
+
+       DPRINTK_ISPCCDC("\n\tOffsets L %d T %d W %d H %d\n",
+                                               ispccdc_obj.ccdcin_woffse=
t,
+                                               ispccdc_obj.ccdcin_hoffse=
t,
+                                               ispccdc_obj.crop_w,
+                                               ispccdc_obj.crop_h);
+}
+
+/**
+ * ispccdc_config_datapath - Specifies the input and output modules for =
CCDC.
+ * @input: Indicates the module that inputs the image to the CCDC.
+ * @output: Indicates the module to which the CCDC outputs the image.
+ *
+ * Configures the default configuration for the CCDC to work with.
+ *
+ * The valid values for the input are CCDC_RAW (0), CCDC_YUV_SYNC (1),
+ * CCDC_YUV_BT (2), and CCDC_OTHERS (3).
+ *
+ * The valid values for the output are CCDC_YUV_RSZ (0), CCDC_YUV_MEM_RS=
Z (1),
+ * CCDC_OTHERS_VP (2), CCDC_OTHERS_MEM (3), CCDC_OTHERS_VP_MEM (4).
+ *
+ * Returns 0 if successful, or -EINVAL if wrong I/O combination or wrong=
 input
+ * or output values.
+ **/
+int ispccdc_config_datapath(enum ccdc_input input, enum ccdc_output outp=
ut)
+{
+       u32 syn_mode =3D 0;
+       struct ispccdc_vp vpcfg;
+       struct ispccdc_syncif syncif;
+       struct ispccdc_bclamp blkcfg;
+
+       u32 colptn =3D (ISPCCDC_COLPTN_Gr_Cy << ISPCCDC_COLPTN_CP0PLC0_SH=
IFT) |
+               (ISPCCDC_COLPTN_R_Ye << ISPCCDC_COLPTN_CP0PLC1_SHIFT) |
+               (ISPCCDC_COLPTN_Gr_Cy << ISPCCDC_COLPTN_CP0PLC2_SHIFT) |
+               (ISPCCDC_COLPTN_R_Ye << ISPCCDC_COLPTN_CP0PLC3_SHIFT) |
+               (ISPCCDC_COLPTN_B_Mg << ISPCCDC_COLPTN_CP1PLC0_SHIFT) |
+               (ISPCCDC_COLPTN_Gb_G << ISPCCDC_COLPTN_CP1PLC1_SHIFT) |
+               (ISPCCDC_COLPTN_B_Mg << ISPCCDC_COLPTN_CP1PLC2_SHIFT) |
+               (ISPCCDC_COLPTN_Gb_G << ISPCCDC_COLPTN_CP1PLC3_SHIFT) |
+               (ISPCCDC_COLPTN_Gr_Cy << ISPCCDC_COLPTN_CP2PLC0_SHIFT) |
+               (ISPCCDC_COLPTN_R_Ye << ISPCCDC_COLPTN_CP2PLC1_SHIFT) |
+               (ISPCCDC_COLPTN_Gr_Cy << ISPCCDC_COLPTN_CP2PLC2_SHIFT) |
+               (ISPCCDC_COLPTN_R_Ye << ISPCCDC_COLPTN_CP2PLC3_SHIFT) |
+               (ISPCCDC_COLPTN_B_Mg << ISPCCDC_COLPTN_CP3PLC0_SHIFT) |
+               (ISPCCDC_COLPTN_Gb_G << ISPCCDC_COLPTN_CP3PLC1_SHIFT) |
+               (ISPCCDC_COLPTN_B_Mg << ISPCCDC_COLPTN_CP3PLC2_SHIFT) |
+               (ISPCCDC_COLPTN_Gb_G << ISPCCDC_COLPTN_CP3PLC3_SHIFT);
+
+       /* CCDC does not convert the image format */
+       if (((input =3D=3D CCDC_RAW) || (input =3D=3D CCDC_OTHERS)) &&
+                                               (output =3D=3D CCDC_YUV_R=
SZ)) {
+               DPRINTK_ISPCCDC("ISP_ERR: Wrong CCDC I/O Combination\n");
+               return -EINVAL;
+       }
+
+       syn_mode =3D isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_MODE=
);
+
+       switch (output) {
+       case CCDC_YUV_RSZ:
+               syn_mode |=3D ISPCCDC_SYN_MODE_SDR2RSZ;
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_WEN;
+               break;
+
+       case CCDC_YUV_MEM_RSZ:
+               syn_mode |=3D ISPCCDC_SYN_MODE_SDR2RSZ;
+               ispccdc_obj.wen =3D 1;
+               syn_mode |=3D ISPCCDC_SYN_MODE_WEN;
+               break;
+
+       case CCDC_OTHERS_VP:
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_VP2SDR;
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_SDR2RSZ;
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_WEN;
+               vpcfg.bitshift_sel =3D BIT9_0;
+               vpcfg.freq_sel =3D PIXCLKBY2;
+               ispccdc_config_vp(vpcfg);
+               ispccdc_enable_vp(1);
+               break;
+
+       case CCDC_OTHERS_MEM:
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_VP2SDR;
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_SDR2RSZ;
+               syn_mode |=3D ISPCCDC_SYN_MODE_WEN;
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_EXWEN;
+               isp_reg_and(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CFG, ~ISPCCDC_C=
FG_WENLOG);
+               vpcfg.bitshift_sel =3D BIT11_2;
+               vpcfg.freq_sel =3D PIXCLKBY2;
+               ispccdc_config_vp(vpcfg);
+               ispccdc_enable_vp(0);
+               break;
+
+       case CCDC_OTHERS_VP_MEM:
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_VP2SDR;
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_SDR2RSZ;
+               syn_mode |=3D ISPCCDC_SYN_MODE_WEN;
+               syn_mode |=3D ISPCCDC_SYN_MODE_EXWEN;
+               isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CFG,
+                                                       ~ISPCCDC_CFG_WENL=
OG,
+                                                       ispccdc_obj.wenlo=
g);
+               vpcfg.bitshift_sel =3D BIT9_0;
+               vpcfg.freq_sel =3D PIXCLKBY2;
+               ispccdc_config_vp(vpcfg);
+               ispccdc_enable_vp(1);
+               break;
+       default:
+               DPRINTK_ISPCCDC("ISP_ERR: Wrong CCDC Output");
+               return -EINVAL;
+       };
+
+       isp_reg_writel(syn_mode, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_MODE);
+
+       switch (input) {
+       case CCDC_RAW:
+               syncif.ccdc_mastermode =3D 0;
+               syncif.datapol =3D 0;
+               syncif.datsz =3D DAT10;
+               syncif.fldmode =3D 0;
+               syncif.fldout =3D 0;
+               syncif.fldpol =3D 0;
+               syncif.fldstat =3D 0;
+               syncif.hdpol =3D 0;
+               syncif.ipmod =3D RAW;
+               syncif.vdpol =3D 0;
+               ispccdc_config_sync_if(syncif);
+               ispccdc_config_imgattr(colptn);
+               blkcfg.dcsubval =3D 42;
+               ispccdc_config_black_clamp(blkcfg);
+               if (is_isplsc_activated()) {
+                       ispccdc_config_lsc(&lsc_config);
+                       ispccdc_load_lsc((u32)sizeof(ispccdc_lsc_tbl));
+               }
+
+               break;
+       case CCDC_YUV_SYNC:
+               syncif.ccdc_mastermode =3D 0;
+               syncif.datapol =3D 0;
+               syncif.datsz =3D DAT8;
+               syncif.fldmode =3D 0;
+               syncif.fldout =3D 0;
+               syncif.fldpol =3D 0;
+               syncif.fldstat =3D 0;
+               syncif.hdpol =3D 0;
+               syncif.ipmod =3D YUV16;
+               syncif.vdpol =3D 0;
+               ispccdc_config_imgattr(0);
+               ispccdc_config_sync_if(syncif);
+               blkcfg.dcsubval =3D 0;
+               ispccdc_config_black_clamp(blkcfg);
+               break;
+       case CCDC_YUV_BT:
+               break;
+       case CCDC_OTHERS:
+               break;
+       default:
+               DPRINTK_ISPCCDC("ISP_ERR: Wrong CCDC Input");
+               return -EINVAL;
+       }
+
+       ispccdc_obj.ccdc_inpfmt =3D input;
+       ispccdc_obj.ccdc_outfmt =3D output;
+       ispccdc_print_status();
+       isp_print_status();
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_config_datapath);
+
+/**
+ * ispccdc_config_sync_if - Sets the sync i/f params between sensor and =
CCDC.
+ * @syncif: Structure containing the sync parameters like field state, C=
CDC in
+ *          master/slave mode, raw/yuv data, polarity of data, field, hs=
, vs
+ *          signals.
+ **/
+void ispccdc_config_sync_if(struct ispccdc_syncif syncif)
+{
+       u32 syn_mode =3D isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_=
MODE);
+
+       syn_mode |=3D ISPCCDC_SYN_MODE_VDHDEN;
+
+       if (syncif.fldstat)
+               syn_mode |=3D ISPCCDC_SYN_MODE_FLDSTAT;
+       else
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_FLDSTAT;
+
+       syn_mode &=3D ISPCCDC_SYN_MODE_INPMOD_MASK;
+       ispccdc_obj.syncif_ipmod =3D syncif.ipmod;
+
+       switch (syncif.ipmod) {
+       case RAW:
+               break;
+       case YUV16:
+               syn_mode |=3D ISPCCDC_SYN_MODE_INPMOD_YCBCR16;
+               break;
+       case YUV8:
+               syn_mode |=3D ISPCCDC_SYN_MODE_INPMOD_YCBCR8;
+               break;
+       };
+
+       syn_mode &=3D ISPCCDC_SYN_MODE_DATSIZ_MASK;
+       switch (syncif.datsz) {
+       case DAT8:
+               syn_mode |=3D ISPCCDC_SYN_MODE_DATSIZ_8;
+               break;
+       case DAT10:
+               syn_mode |=3D ISPCCDC_SYN_MODE_DATSIZ_10;
+               break;
+       case DAT11:
+               syn_mode |=3D ISPCCDC_SYN_MODE_DATSIZ_11;
+               break;
+       case DAT12:
+               syn_mode |=3D ISPCCDC_SYN_MODE_DATSIZ_12;
+               break;
+       };
+
+       if (syncif.fldmode)
+               syn_mode |=3D ISPCCDC_SYN_MODE_FLDMODE;
+       else
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_FLDMODE;
+
+       if (syncif.datapol)
+               syn_mode |=3D ISPCCDC_SYN_MODE_DATAPOL;
+       else
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_DATAPOL;
+
+       if (syncif.fldpol)
+               syn_mode |=3D ISPCCDC_SYN_MODE_FLDPOL;
+       else
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_FLDPOL;
+
+       if (syncif.hdpol)
+               syn_mode |=3D ISPCCDC_SYN_MODE_HDPOL;
+       else
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_HDPOL;
+
+       if (syncif.vdpol)
+               syn_mode |=3D ISPCCDC_SYN_MODE_VDPOL;
+       else
+               syn_mode &=3D ~ISPCCDC_SYN_MODE_VDPOL;
+
+       if (syncif.ccdc_mastermode) {
+               syn_mode |=3D ISPCCDC_SYN_MODE_FLDOUT | ISPCCDC_SYN_MODE_=
VDHDOUT;
+               isp_reg_writel((syncif.hs_width << ISPCCDC_HD_VD_WID_HDW_=
SHIFT)
+                                               | (syncif.vs_width <<
+                                               ISPCCDC_HD_VD_WID_VDW_SHI=
FT),
+                                               OMAP3_ISP_IOMEM_CCDC,
+                                               ISPCCDC_HD_VD_WID);
+
+               isp_reg_writel(syncif.ppln << ISPCCDC_PIX_LINES_PPLN_SHIF=
T
+                       | syncif.hlprf << ISPCCDC_PIX_LINES_HLPRF_SHIFT,
+                       OMAP3_ISP_IOMEM_CCDC,
+                       ISPCCDC_PIX_LINES);
+       } else
+               syn_mode &=3D ~(ISPCCDC_SYN_MODE_FLDOUT |
+                                               ISPCCDC_SYN_MODE_VDHDOUT)=
;
+
+       isp_reg_writel(syn_mode, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_MODE);
+
+       if (!(syncif.bt_r656_en)) {
+               isp_reg_and(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_REC656IF,
+                                               ~ISPCCDC_REC656IF_R656ON)=
;
+       }
+}
+EXPORT_SYMBOL(ispccdc_config_sync_if);
+
+/**
+ * ispccdc_config_black_clamp - Configures the clamp parameters in CCDC.
+ * @bclamp: Structure containing the optical black average gain, optical=
 black
+ *          sample length, sample lines, and the start pixel position of=
 the
+ *          samples w.r.t the HS pulse.
+ * Configures the clamp parameters in CCDC. Either if its being used the
+ * optical black clamp, or the digital clamp. If its a digital clamp, th=
en
+ * assures to put a valid DC substraction level.
+ *
+ * Returns always 0 when completed.
+ **/
+int ispccdc_config_black_clamp(struct ispccdc_bclamp bclamp)
+{
+       u32 bclamp_val =3D 0;
+
+       if (ispccdc_obj.obclamp_en) {
+               bclamp_val |=3D bclamp.obgain << ISPCCDC_CLAMP_OBGAIN_SHI=
FT;
+               bclamp_val |=3D bclamp.oblen << ISPCCDC_CLAMP_OBSLEN_SHIF=
T;
+               bclamp_val |=3D bclamp.oblines << ISPCCDC_CLAMP_OBSLN_SHI=
FT;
+               bclamp_val |=3D bclamp.obstpixel << ISPCCDC_CLAMP_OBST_SH=
IFT;
+               isp_reg_writel(bclamp_val, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_=
CLAMP);
+       } else {
+               if (omap_rev() < OMAP3430_REV_ES2_0)
+                       if ((ispccdc_obj.syncif_ipmod =3D=3D YUV16) ||
+                                       (ispccdc_obj.syncif_ipmod =3D=3D =
YUV8) ||
+                                       (isp_reg_readl(OMAP3_ISP_IOMEM_CC=
DC,
+                                       ISPCCDC_REC656IF) &
+                                       ISPCCDC_REC656IF_R656ON))
+                               bclamp.dcsubval =3D 0;
+               isp_reg_writel(bclamp.dcsubval, OMAP3_ISP_IOMEM_CCDC, ISP=
CCDC_DCSUB);
+       }
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_config_black_clamp);
+
+/**
+ * ispccdc_enable_black_clamp - Enables/Disables the optical black clamp=
.
+ * @enable: 0 Disables optical black clamp, 1 Enables optical black clam=
p.
+ *
+ * Enables or disables the optical black clamp. When disabled, the digit=
al
+ * clamp operates.
+ **/
+void ispccdc_enable_black_clamp(u8 enable)
+{
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CLAMP,
+                                       ~ISPCCDC_CLAMP_CLAMPEN,
+                                       enable ? ISPCCDC_CLAMP_CLAMPEN : =
0);
+       ispccdc_obj.obclamp_en =3D enable;
+}
+EXPORT_SYMBOL(ispccdc_enable_black_clamp);
+
+/**
+ * ispccdc_config_fpc - Configures the Faulty Pixel Correction parameter=
s.
+ * @fpc: Structure containing the number of faulty pixels corrected in t=
he
+ *       frame, address of the FPC table.
+ *
+ * Returns 0 if successful, or -EINVAL if FPC Address is not on the 64 b=
yte
+ * boundary.
+ **/
+int ispccdc_config_fpc(struct ispccdc_fpc fpc)
+{
+       u32 fpc_val =3D 0;
+
+       fpc_val =3D isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC);
+
+       if ((fpc.fpcaddr & 0xFFFFFFC0) =3D=3D fpc.fpcaddr) {
+               isp_reg_writel(fpc_val & (~ISPCCDC_FPC_FPCEN),
+                                       OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC=
);
+               isp_reg_writel(fpc.fpcaddr,
+                               OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC_ADDR);
+       } else {
+               DPRINTK_ISPCCDC("FPC Address should be on 64byte boundary=
\n");
+               return -EINVAL;
+       }
+       isp_reg_writel(fpc_val | (fpc.fpnum << ISPCCDC_FPC_FPNUM_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC=
);
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_config_fpc);
+
+/**
+ * ispccdc_enable_fpc - Enables the Faulty Pixel Correction.
+ * @enable: 0 Disables FPC, 1 Enables FPC.
+ **/
+void ispccdc_enable_fpc(u8 enable)
+{
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FPC,
+                                       ~ISPCCDC_FPC_FPCEN,
+                                       enable ? ISPCCDC_FPC_FPCEN : 0);
+}
+EXPORT_SYMBOL(ispccdc_enable_fpc);
+
+/**
+ * ispccdc_config_black_comp - Configures Black Level Compensation param=
eters.
+ * @blcomp: Structure containing the black level compensation value for =
RGrGbB
+ *          pixels. in 2's complement.
+ **/
+void ispccdc_config_black_comp(struct ispccdc_blcomp blcomp)
+{
+       u32 blcomp_val =3D 0;
+
+       blcomp_val |=3D blcomp.b_mg << ISPCCDC_BLKCMP_B_MG_SHIFT;
+       blcomp_val |=3D blcomp.gb_g << ISPCCDC_BLKCMP_GB_G_SHIFT;
+       blcomp_val |=3D blcomp.gr_cy << ISPCCDC_BLKCMP_GR_CY_SHIFT;
+       blcomp_val |=3D blcomp.r_ye << ISPCCDC_BLKCMP_R_YE_SHIFT;
+
+       isp_reg_writel(blcomp_val, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_BLKCMP);
+}
+EXPORT_SYMBOL(ispccdc_config_black_comp);
+
+/**
+ * ispccdc_config_vp - Configures the Video Port Configuration parameter=
s.
+ * @vpcfg: Structure containing the Video Port input frequency, and the =
10 bit
+ *         format.
+ **/
+void ispccdc_config_vp(struct ispccdc_vp vpcfg)
+{
+       u32 fmtcfg_vp =3D isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT=
CFG);
+
+       fmtcfg_vp &=3D ISPCCDC_FMTCFG_VPIN_MASK & ISPCCDC_FMTCF_VPIF_FRQ_=
MASK;
+
+       switch (vpcfg.bitshift_sel) {
+       case BIT9_0:
+               fmtcfg_vp |=3D ISPCCDC_FMTCFG_VPIN_9_0;
+               break;
+       case BIT10_1:
+               fmtcfg_vp |=3D ISPCCDC_FMTCFG_VPIN_10_1;
+               break;
+       case BIT11_2:
+               fmtcfg_vp |=3D ISPCCDC_FMTCFG_VPIN_11_2;
+               break;
+       case BIT12_3:
+               fmtcfg_vp |=3D ISPCCDC_FMTCFG_VPIN_12_3;
+               break;
+       };
+       switch (vpcfg.freq_sel) {
+       case PIXCLKBY2:
+               fmtcfg_vp |=3D ISPCCDC_FMTCF_VPIF_FRQ_BY2;
+               break;
+       case PIXCLKBY3_5:
+               fmtcfg_vp |=3D ISPCCDC_FMTCF_VPIF_FRQ_BY3;
+               break;
+       case PIXCLKBY4_5:
+               fmtcfg_vp |=3D ISPCCDC_FMTCF_VPIF_FRQ_BY4;
+               break;
+       case PIXCLKBY5_5:
+               fmtcfg_vp |=3D ISPCCDC_FMTCF_VPIF_FRQ_BY5;
+               break;
+       case PIXCLKBY6_5:
+               fmtcfg_vp |=3D ISPCCDC_FMTCF_VPIF_FRQ_BY6;
+               break;
+       };
+       isp_reg_writel(fmtcfg_vp, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCFG);
+}
+EXPORT_SYMBOL(ispccdc_config_vp);
+
+/**
+ * ispccdc_enable_vp - Enables the Video Port.
+ * @enable: 0 Disables VP, 1 Enables VP
+ **/
+void ispccdc_enable_vp(u8 enable)
+{
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCFG,
+                                       ~ISPCCDC_FMTCFG_VPEN,
+                                       enable ? ISPCCDC_FMTCFG_VPEN : 0)=
;
+}
+EXPORT_SYMBOL(ispccdc_enable_vp);
+
+/**
+ * ispccdc_config_reformatter - Configures the Reformatter.
+ * @refmt: Structure containing the memory address to format and the bit=
 fields
+ *         for the reformatter registers.
+ *
+ * Configures the Reformatter register values if line alternating is dis=
abled.
+ * Else, just enabling line alternating is enough.
+ **/
+void ispccdc_config_reformatter(struct ispccdc_refmt refmt)
+{
+       u32 fmtcfg_val =3D 0;
+
+       fmtcfg_val =3D isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCFG=
);
+
+       if (refmt.lnalt)
+               fmtcfg_val |=3D ISPCCDC_FMTCFG_LNALT;
+       else {
+               fmtcfg_val &=3D ~ISPCCDC_FMTCFG_LNALT;
+               fmtcfg_val &=3D 0xFFFFF003;
+               fmtcfg_val |=3D refmt.lnum << ISPCCDC_FMTCFG_LNUM_SHIFT;
+               fmtcfg_val |=3D refmt.plen_even <<
+                                               ISPCCDC_FMTCFG_PLEN_EVEN_=
SHIFT;
+               fmtcfg_val |=3D refmt.plen_odd << ISPCCDC_FMTCFG_PLEN_ODD=
_SHIFT;
+
+               isp_reg_writel(refmt.prgeven0, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_PRGEVEN0);
+               isp_reg_writel(refmt.prgeven1, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_PRGEVEN1);
+               isp_reg_writel(refmt.prgodd0, OMAP3_ISP_IOMEM_CCDC, ISPCC=
DC_PRGODD0);
+               isp_reg_writel(refmt.prgodd1, OMAP3_ISP_IOMEM_CCDC, ISPCC=
DC_PRGODD1);
+               isp_reg_writel(refmt.fmtaddr0, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR0);
+               isp_reg_writel(refmt.fmtaddr1, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR1);
+               isp_reg_writel(refmt.fmtaddr2, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR2);
+               isp_reg_writel(refmt.fmtaddr3, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR3);
+               isp_reg_writel(refmt.fmtaddr4, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR4);
+               isp_reg_writel(refmt.fmtaddr5, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR5);
+               isp_reg_writel(refmt.fmtaddr6, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR6);
+               isp_reg_writel(refmt.fmtaddr7, OMAP3_ISP_IOMEM_CCDC, ISPC=
CDC_FMT_ADDR7);
+       }
+       isp_reg_writel(fmtcfg_val, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCFG);
+}
+EXPORT_SYMBOL(ispccdc_config_reformatter);
+
+/**
+ * ispccdc_enable_reformatter - Enables the Reformatter.
+ * @enable: 0 Disables Reformatter, 1- Enables Data Reformatter
+ **/
+void ispccdc_enable_reformatter(u8 enable)
+{
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCFG,
+                                       ~ISPCCDC_FMTCFG_FMTEN,
+                                       enable ? ISPCCDC_FMTCFG_FMTEN : 0=
);
+       ispccdc_obj.refmt_en =3D enable;
+}
+EXPORT_SYMBOL(ispccdc_enable_reformatter);
+
+/**
+ * ispccdc_config_culling - Configures the culling parameters.
+ * @cull: Structure containing the vertical culling pattern, and horizon=
tal
+ *        culling pattern for odd and even lines.
+ **/
+void ispccdc_config_culling(struct ispccdc_culling cull)
+{
+       u32 culling_val =3D 0;
+
+       culling_val |=3D cull.v_pattern << ISPCCDC_CULLING_CULV_SHIFT;
+       culling_val |=3D cull.h_even << ISPCCDC_CULLING_CULHEVN_SHIFT;
+       culling_val |=3D cull.h_odd << ISPCCDC_CULLING_CULHODD_SHIFT;
+
+       isp_reg_writel(culling_val, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CULLING=
);
+}
+EXPORT_SYMBOL(ispccdc_config_culling);
+
+/**
+ * ispccdc_enable_lpf - Enables the Low-Pass Filter (LPF).
+ * @enable: 0 Disables LPF, 1 Enables LPF
+ **/
+void ispccdc_enable_lpf(u8 enable)
+{
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_MODE,
+                                       ~ISPCCDC_SYN_MODE_LPF,
+                                       enable ? ISPCCDC_SYN_MODE_LPF : 0=
);
+}
+EXPORT_SYMBOL(ispccdc_enable_lpf);
+
+/**
+ * ispccdc_config_alaw - Configures the input width for A-law.
+ * @ipwidth: Input width for A-law
+ **/
+void ispccdc_config_alaw(enum alaw_ipwidth ipwidth)
+{
+       isp_reg_writel(ipwidth << ISPCCDC_ALAW_GWDI_SHIFT,
+                                       OMAP3_ISP_IOMEM_CCDC, ISPCCDC_ALA=
W);
+}
+EXPORT_SYMBOL(ispccdc_config_alaw);
+
+/**
+ * ispccdc_enable_alaw - Enables the A-law compression.
+ * @enable: 0 - Disables A-law, 1 - Enables A-law
+ **/
+void ispccdc_enable_alaw(u8 enable)
+{
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_ALAW,
+                                       ~ISPCCDC_ALAW_CCDTBL,
+                                       enable ? ISPCCDC_ALAW_CCDTBL : 0)=
;
+}
+EXPORT_SYMBOL(ispccdc_enable_alaw);
+
+/**
+ * ispccdc_config_imgattr - Configures the sensor image specific attribu=
tes.
+ * @colptn: Color pattern of the sensor.
+ **/
+void ispccdc_config_imgattr(u32 colptn)
+{
+       isp_reg_writel(colptn, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_COLPTN);
+}
+EXPORT_SYMBOL(ispccdc_config_imgattr);
+
+/**
+ * ispccdc_config_shadow_registers - Programs the shadow registers for C=
CDC.
+ * Currently nothing to program in shadow, but kept for future use.
+ **/
+void ispccdc_config_shadow_registers(void)
+{
+       return;
+}
+EXPORT_SYMBOL(ispccdc_config_shadow_registers);
+
+/**
+ * ispccdc_try_size - Checks if requested Input/output dimensions are va=
lid
+ * @input_w: input width for the CCDC in number of pixels per line
+ * @input_h: input height for the CCDC in number of lines
+ * @output_w: output width from the CCDC in number of pixels per line
+ * @output_h: output height for the CCDC in number of lines
+ *
+ * Calculates the number of pixels cropped if the reformater is disabled=
,
+ * Fills up the output width and height variables in the isp_ccdc struct=
ure.
+ *
+ * Returns 0 if successful, or -EINVAL if the input width is less than 2=
 pixels
+ **/
+int ispccdc_try_size(u32 input_w, u32 input_h, u32 *output_w, u32 *outpu=
t_h)
+{
+       if (input_w < 32 || input_h < 32) {
+               DPRINTK_ISPCCDC("ISP_ERR: CCDC cannot handle input width =
less"
+                               " than 32 pixels or height less than 32\n=
");
+               return -EINVAL;
+       }
+
+       if (ispccdc_obj.crop_w)
+               *output_w =3D ispccdc_obj.crop_w;
+       else
+               *output_w =3D input_w;
+
+       if (ispccdc_obj.crop_h)
+               *output_h =3D ispccdc_obj.crop_h;
+       else
+               *output_h =3D input_h;
+
+       if ((!ispccdc_obj.refmt_en) && ((ispccdc_obj.ccdc_outfmt !=3D
+               CCDC_OTHERS_MEM) && ispccdc_obj.ccdc_outfmt !=3D
+                                       CCDC_OTHERS_VP_MEM))
+               *output_h -=3D 1;
+
+       if ((ispccdc_obj.ccdc_outfmt =3D=3D CCDC_OTHERS_MEM) ||
+                                               (ispccdc_obj.ccdc_outfmt =
=3D=3D
+                                               CCDC_OTHERS_VP_MEM)) {
+               if (*output_w % 16) {
+                       *output_w -=3D (*output_w % 16);
+                       *output_w +=3D 16;
+               }
+       }
+
+       ispccdc_obj.ccdcout_w =3D *output_w;
+       ispccdc_obj.ccdcout_h =3D *output_h;
+       ispccdc_obj.ccdcin_w =3D input_w;
+       ispccdc_obj.ccdcin_h =3D input_h;
+
+       DPRINTK_ISPCCDC("try size: ccdcin_w=3D%u,ccdcin_h=3D%u,ccdcout_w=3D=
%u,"
+                                                       " ccdcout_h=3D%u\=
n",
+                                                       ispccdc_obj.ccdci=
n_w,
+                                                       ispccdc_obj.ccdci=
n_h,
+                                                       ispccdc_obj.ccdco=
ut_w,
+                                                       ispccdc_obj.ccdco=
ut_h);
+
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_try_size);
+
+/**
+ * ispccdc_config_size - Configure the dimensions of the CCDC input/outp=
ut
+ * @input_w: input width for the CCDC in number of pixels per line
+ * @input_h: input height for the CCDC in number of lines
+ * @output_w: output width from the CCDC in number of pixels per line
+ * @output_h: output height for the CCDC in number of lines
+ *
+ * Configures the appropriate values stored in the isp_ccdc structure to
+ * HORZ/VERT_INFO registers and the VP_OUT depending on whether the imag=
e
+ * is stored in memory or given to the another module in the ISP pipelin=
e.
+ *
+ * Returns 0 if successful, or -EINVAL if try_size was not called before=
 to
+ * validate the requested dimensions.
+ **/
+int ispccdc_config_size(u32 input_w, u32 input_h, u32 output_w, u32 outp=
ut_h)
+{
+       DPRINTK_ISPCCDC("config size: input_w=3D%u, input_h=3D%u, output_=
w=3D%u,"
+                                                       " output_h=3D%u\n=
",
+                                                       input_w, input_h,
+                                                       output_w, output_=
h);
+       if ((output_w !=3D ispccdc_obj.ccdcout_w) || (output_h !=3D
+                                               ispccdc_obj.ccdcout_h)) {
+               DPRINTK_ISPCCDC("ISP_ERR : ispccdc_try_size should"
+                                       " be called before config size\n"=
);
+               return -EINVAL;
+       }
+
+       if (ispccdc_obj.ccdc_outfmt =3D=3D CCDC_OTHERS_VP) {
+               isp_reg_writel((ispccdc_obj.ccdcin_woffset <<
+                                       ISPCCDC_FMT_HORZ_FMTSPH_SHIFT) |
+                                       (ispccdc_obj.ccdcin_w <<
+                                       ISPCCDC_FMT_HORZ_FMTLNH_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_FMT_HORZ);
+               isp_reg_writel((ispccdc_obj.ccdcin_hoffset <<
+                                       ISPCCDC_FMT_VERT_FMTSLV_SHIFT) |
+                                       (ispccdc_obj.ccdcin_h <<
+                                       ISPCCDC_FMT_VERT_FMTLNV_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_FMT_VERT);
+               isp_reg_writel((ispccdc_obj.ccdcout_w <<
+                                       ISPCCDC_VP_OUT_HORZ_NUM_SHIFT) |
+                                       (ispccdc_obj.ccdcout_h <<
+                                       ISPCCDC_VP_OUT_VERT_NUM_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VP_OUT);
+               isp_reg_writel((((ispccdc_obj.ccdcout_h - 25) &
+                                       ISPCCDC_VDINT_0_MASK) <<
+                                       ISPCCDC_VDINT_0_SHIFT) |
+                                       ((50 & ISPCCDC_VDINT_1_MASK) <<
+                                       ISPCCDC_VDINT_1_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VDINT);
+
+       } else if (ispccdc_obj.ccdc_outfmt =3D=3D CCDC_OTHERS_MEM) {
+               isp_reg_writel(0, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VP_OUT);
+               if (ispccdc_obj.ccdc_inpfmt =3D=3D CCDC_RAW) {
+                       isp_reg_writel(1 << ISPCCDC_HORZ_INFO_SPH_SHIFT
+                                       | ((ispccdc_obj.ccdcout_w - 1)
+                                       << ISPCCDC_HORZ_INFO_NPH_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_HORZ_INFO);
+               } else {
+                       isp_reg_writel(0 << ISPCCDC_HORZ_INFO_SPH_SHIFT
+                                       | ((ispccdc_obj.ccdcout_w - 1)
+                                       << ISPCCDC_HORZ_INFO_NPH_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_HORZ_INFO);
+               }
+               isp_reg_writel(0 << ISPCCDC_VERT_START_SLV0_SHIFT,
+                                                       OMAP3_ISP_IOMEM_C=
CDC,
+                                                       ISPCCDC_VERT_STAR=
T);
+               isp_reg_writel((ispccdc_obj.ccdcout_h - 1) <<
+                                               ISPCCDC_VERT_LINES_NLV_SH=
IFT,
+                                               OMAP3_ISP_IOMEM_CCDC,
+                                               ISPCCDC_VERT_LINES);
+
+               ispccdc_config_outlineoffset(ispccdc_obj.ccdcout_w * 2, 0=
, 0);
+               isp_reg_writel((((ispccdc_obj.ccdcout_h - 2) &
+                                       ISPCCDC_VDINT_0_MASK) <<
+                                       ISPCCDC_VDINT_0_SHIFT) |
+                                       ((50 & ISPCCDC_VDINT_1_MASK) <<
+                                       ISPCCDC_VDINT_1_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VDINT);
+       } else if (ispccdc_obj.ccdc_outfmt =3D=3D CCDC_OTHERS_VP_MEM) {
+               isp_reg_writel((1 << ISPCCDC_FMT_HORZ_FMTSPH_SHIFT) |
+                                       (ispccdc_obj.ccdcin_w <<
+                                       ISPCCDC_FMT_HORZ_FMTLNH_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_FMT_HORZ);
+               isp_reg_writel((0 << ISPCCDC_FMT_VERT_FMTSLV_SHIFT) |
+                                       ((ispccdc_obj.ccdcin_h) <<
+                                       ISPCCDC_FMT_VERT_FMTLNV_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_FMT_VERT);
+               isp_reg_writel((ispccdc_obj.ccdcout_w
+                                       << ISPCCDC_VP_OUT_HORZ_NUM_SHIFT)=
 |
+                                       (ispccdc_obj.ccdcout_h <<
+                                       ISPCCDC_VP_OUT_VERT_NUM_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VP_OUT);
+               isp_reg_writel(0 << ISPCCDC_HORZ_INFO_SPH_SHIFT |
+                                       ((ispccdc_obj.ccdcout_w - 1) <<
+                                       ISPCCDC_HORZ_INFO_NPH_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_HORZ_INFO);
+               isp_reg_writel(0 << ISPCCDC_VERT_START_SLV0_SHIFT,
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VERT_START);
+               isp_reg_writel((ispccdc_obj.ccdcout_h - 1) <<
+                                       ISPCCDC_VERT_LINES_NLV_SHIFT,
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VERT_LINES);
+               ispccdc_config_outlineoffset(ispccdc_obj.ccdcout_w * 2, 0=
, 0);
+               isp_reg_writel((((ispccdc_obj.ccdcout_h - 25) &
+                                       ISPCCDC_VDINT_0_MASK) <<
+                                       ISPCCDC_VDINT_0_SHIFT) |
+                                       ((50 & ISPCCDC_VDINT_1_MASK) <<
+                                       ISPCCDC_VDINT_1_SHIFT),
+                                       OMAP3_ISP_IOMEM_CCDC,
+                                       ISPCCDC_VDINT);
+       }
+
+       if (is_isplsc_activated()) {
+               if (ispccdc_obj.ccdc_inpfmt =3D=3D CCDC_RAW) {
+                       ispccdc_config_lsc(&lsc_config);
+                       ispccdc_load_lsc(lsc_config.size);
+               }
+       }
+
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_config_size);
+
+/**
+ * ispccdc_config_outlineoffset - Configures the output line offset
+ * @offset: Must be twice the Output width and aligned on 32 byte bounda=
ry
+ * @oddeven: Specifies the odd/even line pattern to be chosen to store t=
he
+ *           output.
+ * @numlines: Set the value 0-3 for +1-4lines, 4-7 for -1-4lines.
+ *
+ * - Configures the output line offset when stored in memory
+ * - Sets the odd/even line pattern to store the output
+ *    (EVENEVEN (1), ODDEVEN (2), EVENODD (3), ODDODD (4))
+ * - Configures the number of even and odd line fields in case of rearra=
nging
+ * the lines.
+ *
+ * Returns 0 if successful, or -EINVAL if the offset is not in 32 byte
+ * boundary.
+ **/
+int ispccdc_config_outlineoffset(u32 offset, u8 oddeven, u8 numlines)
+{
+       if ((offset & ISP_32B_BOUNDARY_OFFSET) =3D=3D offset)
+               isp_reg_writel((offset & 0xFFFF), OMAP3_ISP_IOMEM_CCDC, I=
SPCCDC_HSIZE_OFF);
+       else {
+               DPRINTK_ISPCCDC("ISP_ERR : Offset should be in 32 byte"
+                                                               " boundar=
y");
+               return -EINVAL;
+       }
+
+       isp_reg_and(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST, ~ISPCCDC_SDOFST=
_FINV);
+
+       isp_reg_and(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST, ISPCCDC_SDOFST_=
FOFST_1L);
+
+       switch (oddeven) {
+       case EVENEVEN:
+               isp_reg_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST,
+                       (numlines & 0x7) << ISPCCDC_SDOFST_LOFST0_SHIFT);
+               break;
+       case ODDEVEN:
+               isp_reg_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST,
+                       (numlines & 0x7) << ISPCCDC_SDOFST_LOFST1_SHIFT);
+               break;
+       case EVENODD:
+               isp_reg_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST,
+                       (numlines & 0x7) << ISPCCDC_SDOFST_LOFST2_SHIFT);
+               break;
+       case ODDODD:
+               isp_reg_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFST,
+                       (numlines & 0x7) << ISPCCDC_SDOFST_LOFST3_SHIFT);
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+EXPORT_SYMBOL(ispccdc_config_outlineoffset);
+
+/**
+ * ispccdc_set_outaddr - Sets the memory address where the output will b=
e saved
+ * @addr: 32-bit memory address aligned on 32 byte boundary.
+ *
+ * Sets the memory address where the output will be saved.
+ *
+ * Returns 0 if successful, or -EINVAL if the address is not in the 32 b=
yte
+ * boundary.
+ **/
+int ispccdc_set_outaddr(u32 addr)
+{
+       if ((addr & ISP_32B_BOUNDARY_BUF) =3D=3D addr) {
+               isp_reg_writel(addr, OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDR_AD=
DR);
+               return 0;
+       } else {
+               DPRINTK_ISPCCDC("ISP_ERR : Address should be in 32 byte"
+                                                               " boundar=
y");
+               return -EINVAL;
+       }
+
+}
+EXPORT_SYMBOL(ispccdc_set_outaddr);
+
+/**
+ * ispccdc_enable - Enables the CCDC module.
+ * @enable: 0 Disables CCDC, 1 Enables CCDC
+ *
+ * Client should configure all the sub modules in CCDC before this.
+ **/
+void ispccdc_enable(u8 enable)
+{
+       if (ccdc_use_lsc && !ispccdc_obj.lsc_en &&
+                               (ispccdc_obj.ccdc_inpfmt =3D=3D CCDC_RAW)=
 &&
+                               enable)
+               ispccdc_enable_lsc(1);
+
+       isp_reg_and_or(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PCR, ~ISPCCDC_PCR_EN=
,
+                                               enable ? ISPCCDC_PCR_EN :=
 0);
+}
+EXPORT_SYMBOL(ispccdc_enable);
+
+/**
+ * ispccdc_busy - Gets busy state of the CCDC.
+ **/
+int ispccdc_busy(void)
+{
+       return isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_PCR) &
+                                                       ISPCCDC_PCR_BUSY;
+}
+EXPORT_SYMBOL(ispccdc_busy);
+
+/**
+ * ispccdc_save_context - Saves the values of the CCDC module registers
+ **/
+void ispccdc_save_context(void)
+{
+       DPRINTK_ISPCCDC("Saving context\n");
+       isp_save_context(ispccdc_reg_list);
+}
+EXPORT_SYMBOL(ispccdc_save_context);
+
+/**
+ * ispccdc_restore_context - Restores the values of the CCDC module regi=
sters
+ **/
+void ispccdc_restore_context(void)
+{
+       DPRINTK_ISPCCDC("Restoring context\n");
+       isp_restore_context(ispccdc_reg_list);
+}
+EXPORT_SYMBOL(ispccdc_restore_context);
+
+/**
+ * ispccdc_print_status - Prints the values of the CCDC Module registers
+ *
+ * Also prints other debug information stored in the CCDC module.
+ **/
+void ispccdc_print_status(void)
+{
+       if (!is_ispccdc_debug_enabled())
+               return;
+
+       DPRINTK_ISPCCDC("Module in use =3D%d\n", ispccdc_obj.ccdc_inuse);
+       DPRINTK_ISPCCDC("Accepted CCDC Input (width =3D %d,Height =3D %d)=
\n",
+                                                       ispccdc_obj.ccdci=
n_w,
+                                                       ispccdc_obj.ccdci=
n_h);
+       DPRINTK_ISPCCDC("Accepted CCDC Output (width =3D %d,Height =3D %d=
)\n",
+                                                       ispccdc_obj.ccdco=
ut_w,
+                                                       ispccdc_obj.ccdco=
ut_h);
+       DPRINTK_ISPCCDC("###CCDC PCR=3D0x%x\n", isp_reg_readl(OMAP3_ISP_I=
OMEM_CCDC, ISPCCDC_PCR));
+       DPRINTK_ISPCCDC("ISP_CTRL =3D0x%x\n", isp_reg_readl(OMAP3_ISP_IOM=
EM_MAIN, ISP_CTRL));
+       switch (ispccdc_obj.ccdc_inpfmt) {
+       case CCDC_RAW:
+               DPRINTK_ISPCCDC("ccdc input format is CCDC_RAW\n");
+               break;
+       case CCDC_YUV_SYNC:
+               DPRINTK_ISPCCDC("ccdc input format is CCDC_YUV_SYNC\n");
+               break;
+       case CCDC_YUV_BT:
+               DPRINTK_ISPCCDC("ccdc input format is CCDC_YUV_BT\n");
+               break;
+       }
+
+       switch (ispccdc_obj.ccdc_outfmt) {
+       case CCDC_OTHERS_VP:
+               DPRINTK_ISPCCDC("ccdc output format is CCDC_OTHERS_VP\n")=
;
+               break;
+       case CCDC_OTHERS_MEM:
+               DPRINTK_ISPCCDC("ccdc output format is CCDC_OTHERS_MEM\n"=
);
+               break;
+       case CCDC_YUV_RSZ:
+               DPRINTK_ISPCCDC("ccdc output format is CCDC_YUV_RSZ\n");
+               break;
+       }
+
+       DPRINTK_ISPCCDC("###ISP_CTRL in ccdc =3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_MAIN, ISP_CTRL));
+       DPRINTK_ISPCCDC("###ISP_IRQ0ENABLE in ccdc =3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_MAIN, ISP_IRQ0ENABL=
E));
+       DPRINTK_ISPCCDC("###ISP_IRQ0STATUS in ccdc =3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_MAIN, ISP_IRQ0STATU=
S));
+       DPRINTK_ISPCCDC("###CCDC SYN_MODE=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SYN_M=
ODE));
+       DPRINTK_ISPCCDC("###CCDC HORZ_INFO=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_HORZ_=
INFO));
+       DPRINTK_ISPCCDC("###CCDC VERT_START=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VERT_=
START));
+       DPRINTK_ISPCCDC("###CCDC VERT_LINES=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VERT_=
LINES));
+       DPRINTK_ISPCCDC("###CCDC CULLING=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CULLI=
NG));
+       DPRINTK_ISPCCDC("###CCDC HSIZE_OFF=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_HSIZE=
_OFF));
+       DPRINTK_ISPCCDC("###CCDC SDOFST=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDOFS=
T));
+       DPRINTK_ISPCCDC("###CCDC SDR_ADDR=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDR_A=
DDR));
+       DPRINTK_ISPCCDC("###CCDC CLAMP=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CLAMP=
));
+       DPRINTK_ISPCCDC("###CCDC COLPTN=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_COLPT=
N));
+       DPRINTK_ISPCCDC("###CCDC CFG=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_CFG))=
;
+       DPRINTK_ISPCCDC("###CCDC VP_OUT=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VP_OU=
T));
+       DPRINTK_ISPCCDC("###CCDC_SDR_ADDR=3D 0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_SDR_A=
DDR));
+       DPRINTK_ISPCCDC("###CCDC FMTCFG=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMTCF=
G));
+       DPRINTK_ISPCCDC("###CCDC FMT_HORZ=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_H=
ORZ));
+       DPRINTK_ISPCCDC("###CCDC FMT_VERT=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_FMT_V=
ERT));
+       DPRINTK_ISPCCDC("###CCDC LSC_CONFIG=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_C=
ONFIG));
+       DPRINTK_ISPCCDC("###CCDC LSC_INIT=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_I=
NITIAL));
+       DPRINTK_ISPCCDC("###CCDC LSC_TABLE BASE=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_T=
ABLE_BASE));
+       DPRINTK_ISPCCDC("###CCDC LSC TABLE OFFSET=3D0x%x\n",
+                       isp_reg_readl(OMAP3_ISP_IOMEM_CCDC, ISPCCDC_LSC_T=
ABLE_OFFSET));
+}
+EXPORT_SYMBOL(ispccdc_print_status);
+
+/**
+ * isp_ccdc_init - CCDC module initialization.
+ *
+ * Always returns 0
+ **/
+int __init isp_ccdc_init(void)
+{
+       ispccdc_obj.ccdc_inuse =3D 0;
+       ispccdc_config_crop(0, 0, 0, 0);
+       mutex_init(&ispccdc_obj.mutexlock);
+
+       if (is_isplsc_activated()) {
+               memset(ispccdc_lsc_tbl, 0x40, LSC_TABLE_INIT_SIZE);
+               lsc_config.initial_x =3D 0;
+               lsc_config.initial_y =3D 0;
+               lsc_config.gain_mode_n =3D 0x6;
+               lsc_config.gain_mode_m =3D 0x6;
+               lsc_config.gain_format =3D 0x4;
+               lsc_config.offset =3D 0x60;
+               lsc_config.size =3D LSC_TABLE_INIT_SIZE;
+               ccdc_use_lsc =3D 1;
+       }
+
+       return 0;
+}
+
+/**
+ * isp_ccdc_cleanup - CCDC module cleanup.
+ **/
+void isp_ccdc_cleanup(void)
+{
+       if (is_isplsc_activated()) {
+               if (lsc_initialized) {
+                       ispmmu_unmap(lsc_ispmmu_addr);
+                       kfree(lsc_gain_table);
+                       lsc_initialized =3D 0;
+               }
+       }
+
+       if (fpc_table_add_m !=3D 0) {
+               ispmmu_unmap(fpc_table_add_m);
+               kfree(fpc_table_add);
+       }
+}
diff --git a/drivers/media/video/isp/ispccdc.h b/drivers/media/video/isp/=
ispccdc.h
new file mode 100644
index 0000000..f691279
--- /dev/null
+++ b/drivers/media/video/isp/ispccdc.h
@@ -0,0 +1,200 @@
+/*
+ * drivers/media/video/isp/ispccdc.h
+ *
+ * Driver header file for CCDC module in TI's OMAP3 Camera ISP
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ *
+ * Contributors:
+ *     Senthilvadivu Guruswamy <svadivu@ti.com>
+ *     Pallavi Kulkarni <p-kulkarni@ti.com>
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
+#ifndef OMAP_ISP_CCDC_H
+#define OMAP_ISP_CCDC_H
+
+#include <mach/isp_user.h>
+
+#define is_isplsc_activated()          1
+
+/* Enumeration constants for CCDC input output format */
+enum ccdc_input {
+       CCDC_RAW,
+       CCDC_YUV_SYNC,
+       CCDC_YUV_BT,
+       CCDC_OTHERS
+};
+
+enum ccdc_output {
+       CCDC_YUV_RSZ,
+       CCDC_YUV_MEM_RSZ,
+       CCDC_OTHERS_VP,
+       CCDC_OTHERS_MEM,
+       CCDC_OTHERS_VP_MEM
+};
+
+/* Enumeration constants for the sync interface parameters */
+enum inpmode {
+       RAW,
+       YUV16,
+       YUV8
+};
+enum datasize {
+       DAT8,
+       DAT10,
+       DAT11,
+       DAT12
+};
+
+
+/**
+ * struct ispccdc_syncif - Structure for Sync Interface between sensor a=
nd CCDC
+ * @ccdc_mastermode: Master mode. 1 - Master, 0 - Slave.
+ * @fldstat: Field state. 0 - Odd Field, 1 - Even Field.
+ * @ipmod: Input mode.
+ * @datsz: Data size.
+ * @fldmode: 0 - Progressive, 1 - Interlaced.
+ * @datapol: 0 - Positive, 1 - Negative.
+ * @fldpol: 0 - Positive, 1 - Negative.
+ * @hdpol: 0 - Positive, 1 - Negative.
+ * @vdpol: 0 - Positive, 1 - Negative.
+ * @fldout: 0 - Input, 1 - Output.
+ * @hs_width: Width of the Horizontal Sync pulse, used for HS/VS Output.
+ * @vs_width: Width of the Vertical Sync pulse, used for HS/VS Output.
+ * @ppln: Number of pixels per line, used for HS/VS Output.
+ * @hlprf: Number of half lines per frame, used for HS/VS Output.
+ * @bt_r656_en: 1 - Enable ITU-R BT656 mode, 0 - Sync mode.
+ */
+struct ispccdc_syncif {
+       u8 ccdc_mastermode;
+       u8 fldstat;
+       enum inpmode ipmod;
+       enum datasize datsz;
+       u8 fldmode;
+       u8 datapol;
+       u8 fldpol;
+       u8 hdpol;
+       u8 vdpol;
+       u8 fldout;
+       u8 hs_width;
+       u8 vs_width;
+       u8 ppln;
+       u8 hlprf;
+       u8 bt_r656_en;
+};
+
+/**
+ * ispccdc_refmt - Structure for Reformatter parameters
+ * @lnalt: Line alternating mode enable. 0 - Enable, 1 - Disable.
+ * @lnum: Number of output lines from 1 input line. 1 to 4 lines.
+ * @plen_even: Number of program entries in even line minus 1.
+ * @plen_odd: Number of program entries in odd line minus 1.
+ * @prgeven0: Program entries 0-7 for even lines register
+ * @prgeven1: Program entries 8-15 for even lines register
+ * @prgodd0: Program entries 0-7 for odd lines register
+ * @prgodd1: Program entries 8-15 for odd lines register
+ * @fmtaddr0: Output line in which the original pixel is to be placed
+ * @fmtaddr1: Output line in which the original pixel is to be placed
+ * @fmtaddr2: Output line in which the original pixel is to be placed
+ * @fmtaddr3: Output line in which the original pixel is to be placed
+ * @fmtaddr4: Output line in which the original pixel is to be placed
+ * @fmtaddr5: Output line in which the original pixel is to be placed
+ * @fmtaddr6: Output line in which the original pixel is to be placed
+ * @fmtaddr7: Output line in which the original pixel is to be placed
+ */
+struct ispccdc_refmt {
+       u8 lnalt;
+       u8 lnum;
+       u8 plen_even;
+       u8 plen_odd;
+       u32 prgeven0;
+       u32 prgeven1;
+       u32 prgodd0;
+       u32 prgodd1;
+       u32 fmtaddr0;
+       u32 fmtaddr1;
+       u32 fmtaddr2;
+       u32 fmtaddr3;
+       u32 fmtaddr4;
+       u32 fmtaddr5;
+       u32 fmtaddr6;
+       u32 fmtaddr7;
+};
+
+int ispccdc_request(void);
+
+int ispccdc_free(void);
+
+int ispccdc_config_datapath(enum ccdc_input input, enum ccdc_output outp=
ut);
+
+void ispccdc_config_crop(u32 left, u32 top, u32 height, u32 width);
+
+void ispccdc_config_sync_if(struct ispccdc_syncif syncif);
+
+int ispccdc_config_black_clamp(struct ispccdc_bclamp bclamp);
+
+void ispccdc_enable_black_clamp(u8 enable);
+
+int ispccdc_config_fpc(struct ispccdc_fpc fpc);
+
+void ispccdc_enable_fpc(u8 enable);
+
+void ispccdc_config_black_comp(struct ispccdc_blcomp blcomp);
+
+void ispccdc_config_vp(struct ispccdc_vp vp);
+
+void ispccdc_enable_vp(u8 enable);
+
+void ispccdc_config_reformatter(struct ispccdc_refmt refmt);
+
+void ispccdc_enable_reformatter(u8 enable);
+
+void ispccdc_config_culling(struct ispccdc_culling culling);
+
+void ispccdc_enable_lpf(u8 enable);
+
+void ispccdc_config_alaw(enum alaw_ipwidth ipwidth);
+
+void ispccdc_enable_alaw(u8 enable);
+
+int ispccdc_load_lsc(u32 table_size);
+
+void ispccdc_config_lsc(struct ispccdc_lsc_config *lsc_cfg);
+
+void ispccdc_enable_lsc(u8 enable);
+
+void ispccdc_config_imgattr(u32 colptn);
+
+void ispccdc_config_shadow_registers(void);
+
+int ispccdc_try_size(u32 input_w, u32 input_h, u32 *output_w, u32 *outpu=
t_h);
+
+int ispccdc_config_size(u32 input_w, u32 input_h, u32 output_w, u32 outp=
ut_h);
+
+int ispccdc_config_outlineoffset(u32 offset, u8 oddeven, u8 numlines);
+
+int ispccdc_set_outaddr(u32 addr);
+
+void ispccdc_enable(u8 enable);
+
+int ispccdc_busy(void);
+
+void ispccdc_save_context(void);
+
+void ispccdc_restore_context(void);
+
+void ispccdc_print_status(void);
+
+int omap34xx_isp_ccdc_config(void *userspace_add);
+
+void ispccdc_set_wenlog(u32 wenlog);
+
+#endif         /* OMAP_ISP_CCDC_H */
--
1.5.6.5


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
