From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 7/7] OMAP3ISP: Changes for kernel pre-emption
Date: Tue, 6 Jan 2009 14:42:08 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328064@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53344 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZAFUmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:42:17 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06KgC9T006096
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:17 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06KgC8p007789
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:12 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From e936ff0f4c82ccbdf4c7e8235c55d2def6979dfb Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:23:24 -0600
Subject: [PATCH] OMAP3ISP: Changes for kernel pre-emption

ISP support for kernel pre-emption

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c          |   17 +++--
 drivers/media/video/isp/isp_af.c       |   33 +++++++++-
 drivers/media/video/isp/ispccdc.c      |   67 +++++++++++++++++---
 drivers/media/video/isp/isph3a.c       |   34 ++++++++++-
 drivers/media/video/isp/isphist.c      |   15 ++++-
 drivers/media/video/isp/ispmmu.c       |    8 +++
 drivers/media/video/isp/isppreview.c   |  108 +++++++++++++++++++++++++++-----
 drivers/media/video/isp/ispresizer.c   |   16 ++++-
 drivers/media/video/isp/omap_resizer.c |    4 +
 9 files changed, 264 insertions(+), 38 deletions(-)
 mode change 100644 => 100755 drivers/media/video/isp/isp_af.c
 mode change 100644 => 100755 drivers/media/video/isp/ispccdc.c
 mode change 100644 => 100755 drivers/media/video/isp/isph3a.c
 mode change 100644 => 100755 drivers/media/video/isp/isphist.c
 mode change 100644 => 100755 drivers/media/video/isp/ispmmu.c
 mode change 100644 => 100755 drivers/media/video/isp/ispresizer.c
 mode change 100644 => 100755 drivers/media/video/isp/omap_resizer.c

diff --git a/drivers/media/video/isp/isp.c b/drivers/media/video/isp/isp.c
index e75e879..8bf55f7 100755
--- a/drivers/media/video/isp/isp.c
+++ b/drivers/media/video/isp/isp.c
@@ -50,6 +50,8 @@
 #include "ispresizer.h"
 #include "ispcsi2.h"

+static DECLARE_MUTEX(isp_mutex);
+
 #if ISP_WORKAROUND
 void *buff_addr;
 dma_addr_t buff_addr_mapped;
@@ -387,7 +389,6 @@ int isp_set_callback(enum isp_callback_type type, isp_callback_t callback,
        ispirq_obj.isp_callbk[type] = callback;
        ispirq_obj.isp_callbk_arg1[type] = arg1;
        ispirq_obj.isp_callbk_arg2[type] = arg2;
-       spin_unlock_irqrestore(&isp_obj.lock, irqflags);

        switch (type) {
        case CBK_HS_VS:
@@ -452,7 +453,7 @@ int isp_set_callback(enum isp_callback_type type, isp_callback_t callback,
        default:
                break;
        }
-
+       spin_unlock_irqrestore(&isp_obj.lock, irqflags);
        return 0;
 }
 EXPORT_SYMBOL(isp_set_callback);
@@ -472,7 +473,6 @@ int isp_unset_callback(enum isp_callback_type type)
        ispirq_obj.isp_callbk[type] = NULL;
        ispirq_obj.isp_callbk_arg1[type] = NULL;
        ispirq_obj.isp_callbk_arg2[type] = NULL;
-       spin_unlock_irqrestore(&isp_obj.lock, irqflags);

        switch (type) {
        case CBK_CCDC_VD0:
@@ -541,7 +541,7 @@ int isp_unset_callback(enum isp_callback_type type)
        default:
                break;
        }
-
+       spin_unlock_irqrestore(&isp_obj.lock, irqflags);
        return 0;
 }
 EXPORT_SYMBOL(isp_unset_callback);
@@ -937,9 +937,9 @@ int isp_configure_interface(struct isp_interface_config *config)

        ispctrl_val &= ~(ISPCTRL_SYNC_DETECT_VSRISE);
        ispctrl_val |= (config->hsvs_syncdetect);
-
+       spin_lock(&isp_obj.isp_temp_buf_lock);
        omap_writel(ispctrl_val, ISP_CTRL);
-
+       spin_unlock(&isp_obj.isp_temp_buf_lock);
        ispccdc_vdint_val = omap_readl(ISPCCDC_VDINT);
        ispccdc_vdint_val &= ~(ISPCCDC_VDINT_0_MASK << ISPCCDC_VDINT_0_SHIFT);
        ispccdc_vdint_val &= ~(ISPCCDC_VDINT_1_MASK << ISPCCDC_VDINT_1_SHIFT);
@@ -1238,8 +1238,9 @@ void isp_start(void)
                isppreview_enable(1);

        /* clear any pending IRQs */
+       spin_lock(&isp_obj.isp_temp_buf_lock);
        omap_writel(0xFFFFFFFF, ISP_IRQ0STATUS);
-
+       spin_unlock(&isp_obj.isp_temp_buf_lock);
        return;
 }
 EXPORT_SYMBOL(isp_start);
@@ -1279,8 +1280,10 @@ void isp_stop()

        timeout = 0;
        isp_save_ctx();
+       spin_lock(&isp_obj.isp_temp_buf_lock);
        omap_writel(omap_readl(ISP_SYSCONFIG) |
                ISP_SYSCONFIG_SOFTRESET, ISP_SYSCONFIG);
+       spin_unlock(&isp_obj.isp_temp_buf_lock);
        while (!(omap_readl(ISP_SYSSTATUS) & 0x1)) {
                timeout++;
                if (timeout >= 10) {
diff --git a/drivers/media/video/isp/isp_af.c b/drivers/media/video/isp/isp_af.c
old mode 100644
new mode 100755
index 5c63907..84c7cab
--- a/drivers/media/video/isp/isp_af.c
+++ b/drivers/media/video/isp/isp_af.c
@@ -39,6 +39,8 @@
 #include "isp_af.h"
 #include "ispmmu.h"

+static DECLARE_MUTEX(ispaf_mutex);
+
 /**
  * struct isp_af_buffer - AF frame stats buffer.
  * @virt_addr: Virtual address to mmap the buffer.
@@ -124,6 +126,7 @@ void isp_af_setxtrastats(struct isp_af_xtrastats *xtrastats, u8 updateflag)
        if (i == H3A_MAX_BUFF)
                return;

+       down(&ispaf_mutex);
        if (i == 0) {
                if (afstat.af_buff[H3A_MAX_BUFF - 1].locked == 0)
                        past_i = H3A_MAX_BUFF - 1;
@@ -147,6 +150,7 @@ void isp_af_setxtrastats(struct isp_af_xtrastats *xtrastats, u8 updateflag)
        if (updateflag & AF_UPDATEXS_FIELDCOUNT)
                afstat.af_buff[past_i].xtrastats.field_count =
                                                        xtrastats->field_count;
+       up(&ispaf_mutex);
 }
 EXPORT_SYMBOL(isp_af_setxtrastats);

@@ -287,12 +291,14 @@ static void isp_af_link_buffers(void)
 {
        int i;

+       down(&ispaf_mutex);
        for (i = 0; i < H3A_MAX_BUFF; i++) {
                if ((i + 1) < H3A_MAX_BUFF)
                        afstat.af_buff[i].next = &afstat.af_buff[i + 1];
                else
                        afstat.af_buff[i].next = &afstat.af_buff[0];
        }
+       up(&ispaf_mutex);
 }

 /* Function to perform hardware set up */
@@ -307,8 +313,10 @@ int isp_af_configure(struct af_configuration *afconfig)
                return -EINVAL;
        }

+       down(&ispaf_mutex);
        memcpy(af_dev_configptr->config, afconfig,
                                        sizeof(struct af_configuration));
+
        /* Get the value of PCR register */
        busyaf = omap_readl(ISPH3A_PCR);

@@ -321,17 +329,22 @@ int isp_af_configure(struct af_configuration *afconfig)

        /*Check IIR Coefficient and start Values */
        result = isp_af_check_iir();
-       if (result < 0)
+       if (result < 0) {
+               up(&ispaf_mutex);
                return result;
+       }

        /*Check Paxel Values */
        result = isp_af_check_paxel();
-       if (result < 0)
+       if (result < 0) {
+               up(&ispaf_mutex);
                return result;
+       }

        /*Check HMF Threshold Values */
        if (af_dev_configptr->config->hmf_config.threshold > AF_THRESHOLD_MAX) {
                DPRINTK_ISPH3A("Error : HMF Threshold is incorrect");
+               up(&ispaf_mutex);
                return -AF_ERR_THRESHOLD;
        }

@@ -369,6 +382,7 @@ int isp_af_configure(struct af_configuration *afconfig)
                        if (afstat.af_buff[i].virt_addr == 0) {
                                printk(KERN_ERR "Can't acquire memory for "
                                        "buffer[%d]\n", i);
+                               up(&ispaf_mutex);
                                return -ENOMEM;
                        }
                        afstat.af_buff[i].addr_align =
@@ -390,8 +404,10 @@ int isp_af_configure(struct af_configuration *afconfig)
        }

        result = isp_af_register_setup(af_dev_configptr);
-       if (result < 0)
+       if (result < 0) {
+               up(&ispaf_mutex);
                return result;
+       }
        af_dev_configptr->size_paxel = buff_size;
        afstat.initialized = 1;
        /*Set configuration flag to indicate HW setup done */
@@ -399,6 +415,7 @@ int isp_af_configure(struct af_configuration *afconfig)
                isp_af_enable(1);

        /*Success */
+       up(&ispaf_mutex);
        return 0;
 }
 EXPORT_SYMBOL(isp_af_configure);
@@ -445,6 +462,7 @@ int isp_af_register_setup(struct af_device *af_dev)
        } else
                pcr &= ~AF_MED_EN;

+       down(&ispaf_mutex);
        omap_writel(pcr, ISPH3A_PCR);

        pax1 &= ~PAXW;
@@ -516,13 +534,16 @@ int isp_af_register_setup(struct af_device *af_dev)
        omap_writel(af_dev->config->iir_config.coeff_set1[10],
                                                        ISPH3A_AFCOEF1010);

+       up(&ispaf_mutex);
        return 0;
 }

 /* Function to set address */
 void isp_af_set_address(unsigned long address)
 {
+       spin_lock(&afstat.buffer_lock);
        omap_writel(address, ISPH3A_AFBUFST);
+       spin_unlock(&afstat.buffer_lock);
 }

 static int isp_af_stats_available(struct isp_af_data *afdata)
@@ -563,11 +584,15 @@ static int isp_af_stats_available(struct isp_af_data *afdata)

 void isp_af_notify(int notify)
 {
+       down(&ispaf_mutex);
        camnotify = notify;
+       up(&ispaf_mutex);
        if (camnotify && afstat.initialized) {
                printk(KERN_DEBUG "Warning Camera Off \n");
+               down(&ispaf_mutex);
                afstat.stats_req = 0;
                afstat.stats_done = 1;
+               up(&ispaf_mutex);
                wake_up_interruptible(&afstat.stats_wait);
        }
 }
@@ -623,9 +648,11 @@ int isp_af_request_statistics(struct isp_af_data *afdata)
                        }
                        if (!camnotify) {
                                /* Block until frame in near future completes */
+                               down(&ispaf_mutex);
                                afstat.frame_req = afdata->frame_number;
                                afstat.stats_req = 1;
                                afstat.stats_done = 0;
+                               up(&ispaf_mutex);
                                init_waitqueue_entry(&wqt, current);
                                ret =
                                   wait_event_interruptible(afstat.stats_wait,
diff --git a/drivers/media/video/isp/ispccdc.c b/drivers/media/video/isp/ispccdc.c
old mode 100644
new mode 100755
index d52c6fa..75a4a06
--- a/drivers/media/video/isp/ispccdc.c
+++ b/drivers/media/video/isp/ispccdc.c
@@ -36,6 +36,8 @@

 #define LSC_TABLE_INIT_SIZE    50052

+static DECLARE_MUTEX(ispccdc_mutex);
+
 static u32 *fpc_table_add;
 static unsigned long fpc_table_add_m;

@@ -82,6 +84,7 @@ static struct isp_ccdc {
        u8 obclamp_en;
        u8 lsc_en;
        struct mutex mutexlock; /* For checking/modifying ccdc_inuse */
+       spinlock_t ispccdc_lock; /* spinlock to protect for pre-emption*/
        u32 wenlog;
        u32 dcsub;
 } ispccdc_obj;
@@ -217,11 +220,13 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
                                                        (ccdc_struct->fpc),
                                                        sizeof(fpc_t)))
                                goto copy_from_user_err;
+                       down(&ispccdc_mutex);
                        fpc_table_add = kmalloc((64 + (fpc_t.fpnum * 4)),
                                                        GFP_KERNEL | GFP_DMA);
                        if (!fpc_table_add) {
                                printk(KERN_ERR "Cannot allocate memory for"
                                                                " FPC table");
+                               up(&ispccdc_mutex);
                                return -ENOMEM;
                        }
                        while (((int)fpc_table_add & 0xFFFFFFC0) !=
@@ -231,7 +236,7 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
                        fpc_table_add_m = ispmmu_map(virt_to_phys
                                                        (fpc_table_add),
                                                        (fpc_t.fpnum) * 4);
-
+                       up(&ispccdc_mutex);
                        if (copy_from_user(fpc_table_add, (u32 *)fpc_t.fpcaddr,
                                                        fpc_t.fpnum * 4))
                                goto copy_from_user_err;
@@ -264,11 +269,13 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
                                                sizeof(struct
                                                ispccdc_lsc_config)))
                                        goto copy_from_user_err;
+                               down(&ispccdc_mutex);
                                lsc_initialized = 0;
                                if (lsc_config.size <= old_size)
                                        size_mismatch = 0;
                                else
                                        size_mismatch = 1;
+                               up(&ispccdc_mutex);
                                ispccdc_config_lsc(&lsc_config);
                        }
                        ccdc_use_lsc = 1;
@@ -277,6 +284,7 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
                                ispccdc_enable_lsc(0);
                                ccdc_use_lsc = 0;
                }
+               down(&ispccdc_mutex);
                if ((ISP_ABS_TBL_LSC & ccdc_struct->update)
                        == ISP_ABS_TBL_LSC) {
                        if (size_mismatch) {
@@ -290,6 +298,7 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
                                                "Cannot allocate\
                                                memory for \
                                                gain tables \n");
+                                       up(&ispccdc_mutex);
                                        return -ENOMEM;
                                }
                                lsc_ispmmu_addr = ispmmu_map(
@@ -301,9 +310,12 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
                                size_mismatch = 0;
                        }
                        if (copy_from_user(lsc_gain_table,
-                               (ccdc_struct->lsc), lsc_config.size))
+                               (ccdc_struct->lsc), lsc_config.size)) {
+                               up(&ispccdc_mutex);
                                goto copy_from_user_err;
+                       }
                }
+               up(&ispccdc_mutex);
        }

        if ((ISP_ABS_CCDC_COLPTN & ccdc_struct->update) == ISP_ABS_CCDC_COLPTN)
@@ -346,20 +358,20 @@ EXPORT_SYMBOL(ispccdc_set_dcsub);
  **/
 int ispccdc_request(void)
 {
-       mutex_lock(&ispccdc_obj.mutexlock);
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (ispccdc_obj.ccdc_inuse) {
-               mutex_unlock(&ispccdc_obj.mutexlock);
+               spin_unlock(&ispccdc_obj.ispccdc_lock);
                DPRINTK_ISPCCDC("ISP_ERR : CCDC Module Busy");
                return -EBUSY;
        }

        ispccdc_obj.ccdc_inuse = 1;
-       mutex_unlock(&ispccdc_obj.mutexlock);
        omap_writel((omap_readl(ISP_CTRL)) | ISPCTRL_CCDC_RAM_EN |
                                                        ISPCTRL_CCDC_CLK_EN |
                                                        ISPCTRL_SBL_WR1_RAM_EN,
                                                        ISP_CTRL);
        omap_writel((omap_readl(ISPCCDC_CFG)) | ISPCCDC_CFG_VDLC, ISPCCDC_CFG);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
        return 0;
 }
 EXPORT_SYMBOL(ispccdc_request);
@@ -373,19 +385,19 @@ EXPORT_SYMBOL(ispccdc_request);
  **/
 int ispccdc_free(void)
 {
-       mutex_lock(&ispccdc_obj.mutexlock);
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (!ispccdc_obj.ccdc_inuse) {
-               mutex_unlock(&ispccdc_obj.mutexlock);
+               spin_unlock(&ispccdc_obj.ispccdc_lock);
                DPRINTK_ISPCCDC("ISP_ERR: CCDC Module already freed\n");
                return -EINVAL;
        }

        ispccdc_obj.ccdc_inuse = 0;
-       mutex_unlock(&ispccdc_obj.mutexlock);
        omap_writel((omap_readl(ISP_CTRL)) & ~(ISPCTRL_CCDC_CLK_EN |
                                                ISPCTRL_CCDC_RAM_EN |
                                                ISPCTRL_SBL_WR1_RAM_EN),
                                                ISP_CTRL);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
        return 0;
 }
 EXPORT_SYMBOL(ispccdc_free);
@@ -417,8 +429,10 @@ int ispccdc_load_lsc(u32 table_size)

        memcpy(lsc_gain_table, ispccdc_lsc_tbl, table_size);
        lsc_ispmmu_addr = ispmmu_map(virt_to_phys(lsc_gain_table), table_size);
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(lsc_ispmmu_addr, ISPCCDC_LSC_TABLE_BASE);
        lsc_initialized = 1;
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
        return 0;
 }
 EXPORT_SYMBOL(ispccdc_load_lsc);
@@ -435,6 +449,7 @@ void ispccdc_config_lsc(struct ispccdc_lsc_config *lsc_cfg)
                return;

        ispccdc_enable_lsc(0);
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(lsc_cfg->offset, ISPCCDC_LSC_TABLE_OFFSET);

        reg = 0;
@@ -449,6 +464,7 @@ void ispccdc_config_lsc(struct ispccdc_lsc_config *lsc_cfg)
        reg &= ~ISPCCDC_LSC_INITIAL_Y_MASK;
        reg |= (lsc_cfg->initial_y << ISPCCDC_LSC_INITIAL_Y_SHIFT);
        omap_writel(reg, ISPCCDC_LSC_INITIAL);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_config_lsc);

@@ -583,8 +599,10 @@ int ispccdc_config_datapath(enum ccdc_input input, enum ccdc_output output)
                syn_mode &= ~ISPCCDC_SYN_MODE_SDR2RSZ;
                syn_mode |= ISPCCDC_SYN_MODE_WEN;
                syn_mode &= ~ISPCCDC_SYN_MODE_EXWEN;
+               spin_lock(&ispccdc_obj.ispccdc_lock);
                omap_writel((omap_readl(ISPCCDC_CFG)) & ~ISPCCDC_CFG_WENLOG,
                                                                ISPCCDC_CFG);
+               spin_unlock(&ispccdc_obj.ispccdc_lock);
                vpcfg.bitshift_sel = BIT11_2;
                vpcfg.freq_sel = PIXCLKBY2;
                ispccdc_config_vp(vpcfg);
@@ -596,8 +614,10 @@ int ispccdc_config_datapath(enum ccdc_input input, enum ccdc_output output)
                syn_mode &= ~ISPCCDC_SYN_MODE_SDR2RSZ;
                syn_mode |= ISPCCDC_SYN_MODE_WEN;
                syn_mode |= ISPCCDC_SYN_MODE_EXWEN;
+               spin_lock(&ispccdc_obj.ispccdc_lock);
                omap_writel((omap_readl(ISPCCDC_CFG) & ~ISPCCDC_CFG_WENLOG) |
                                        ispccdc_obj.wenlog, ISPCCDC_CFG);
+               spin_unlock(&ispccdc_obj.ispccdc_lock);
                vpcfg.bitshift_sel = BIT9_0;
                vpcfg.freq_sel = PIXCLKBY2;
                ispccdc_config_vp(vpcfg);
@@ -621,7 +641,9 @@ int ispccdc_config_datapath(enum ccdc_input input, enum ccdc_output output)
                return -EINVAL;
        };

+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(syn_mode, ISPCCDC_SYN_MODE);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);

        switch (input) {
        case CCDC_RAW:
@@ -817,6 +839,7 @@ int ispccdc_config_black_clamp(struct ispccdc_bclamp bclamp)
 {
        u32 bclamp_val = 0;

+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (ispccdc_obj.obclamp_en) {
                bclamp_val |= bclamp.obgain << ISPCCDC_CLAMP_OBGAIN_SHIFT;
                bclamp_val |= bclamp.oblen << ISPCCDC_CLAMP_OBSLEN_SHIFT;
@@ -833,6 +856,7 @@ int ispccdc_config_black_clamp(struct ispccdc_bclamp bclamp)
                                bclamp.dcsubval = 0;
                omap_writel(bclamp.dcsubval, ISPCCDC_DCSUB);
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
        return 0;
 }
 EXPORT_SYMBOL(ispccdc_config_black_clamp);
@@ -846,6 +870,7 @@ EXPORT_SYMBOL(ispccdc_config_black_clamp);
  **/
 void ispccdc_enable_black_clamp(u8 enable)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (enable) {
                omap_writel((omap_readl(ISPCCDC_CLAMP))|ISPCCDC_CLAMP_CLAMPEN,
                                                                ISPCCDC_CLAMP);
@@ -855,6 +880,7 @@ void ispccdc_enable_black_clamp(u8 enable)
                                        ~ISPCCDC_CLAMP_CLAMPEN, ISPCCDC_CLAMP);
                ispccdc_obj.obclamp_en = 0;
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_enable_black_clamp);

@@ -870,6 +896,7 @@ int ispccdc_config_fpc(struct ispccdc_fpc fpc)
 {
        u32 fpc_val = 0;

+       spin_lock(&ispccdc_obj.ispccdc_lock);
        fpc_val = omap_readl(ISPCCDC_FPC);

        if ((fpc.fpcaddr & 0xFFFFFFC0) == fpc.fpcaddr) {
@@ -877,10 +904,12 @@ int ispccdc_config_fpc(struct ispccdc_fpc fpc)
                omap_writel(fpc.fpcaddr, ISPCCDC_FPC_ADDR);
        } else {
                DPRINTK_ISPCCDC("FPC Address should be on 64byte boundary\n");
+               spin_unlock(&ispccdc_obj.ispccdc_lock);
                return -EINVAL;
        }
        omap_writel(fpc_val | (fpc.fpnum << ISPCCDC_FPC_FPNUM_SHIFT),
                                                                ISPCCDC_FPC);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
        return 0;
 }
 EXPORT_SYMBOL(ispccdc_config_fpc);
@@ -891,6 +920,7 @@ EXPORT_SYMBOL(ispccdc_config_fpc);
  **/
 void ispccdc_enable_fpc(u8 enable)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (enable) {
                omap_writel(omap_readl(ISPCCDC_FPC) | ISPCCDC_FPC_FPCEN,
                                                                ISPCCDC_FPC);
@@ -898,6 +928,7 @@ void ispccdc_enable_fpc(u8 enable)
                omap_writel(omap_readl(ISPCCDC_FPC) & ~ISPCCDC_FPC_FPCEN,
                                                                ISPCCDC_FPC);
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_enable_fpc);

@@ -916,7 +947,9 @@ void ispccdc_config_black_comp(struct ispccdc_blcomp blcomp)
                                                ISPCCDC_BLKCMP_GR_CY_SHIFT);
        blcomp_val |= (((u32)blcomp.r_ye & 0xFF) << ISPCCDC_BLKCMP_R_YE_SHIFT);

+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(blcomp_val, ISPCCDC_BLKCMP);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_config_black_comp);

@@ -962,7 +995,9 @@ void ispccdc_config_vp(struct ispccdc_vp vpcfg)
                fmtcfg_vp |= ISPCCDC_FMTCF_VPIF_FRQ_BY6;
                break;
        };
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(fmtcfg_vp, ISPCCDC_FMTCFG);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_config_vp);

@@ -972,6 +1007,7 @@ EXPORT_SYMBOL(ispccdc_config_vp);
  **/
 void ispccdc_enable_vp(u8 enable)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (enable) {
                omap_writel((omap_readl(ISPCCDC_FMTCFG)) |
                                        ISPCCDC_FMTCFG_VPEN, ISPCCDC_FMTCFG);
@@ -979,6 +1015,7 @@ void ispccdc_enable_vp(u8 enable)
                omap_writel(omap_readl(ISPCCDC_FMTCFG) &
                                        ~ISPCCDC_FMTCFG_VPEN, ISPCCDC_FMTCFG);
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_enable_vp);

@@ -1019,7 +1056,9 @@ void ispccdc_config_reformatter(struct ispccdc_refmt refmt)
                omap_writel(refmt.fmtaddr6, ISPCCDC_FMT_ADDR6);
                omap_writel(refmt.fmtaddr7, ISPCCDC_FMT_ADDR7);
        }
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(fmtcfg_val, ISPCCDC_FMTCFG);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_config_reformatter);

@@ -1029,6 +1068,7 @@ EXPORT_SYMBOL(ispccdc_config_reformatter);
  **/
 void ispccdc_enable_reformatter(u8 enable)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (enable) {
                omap_writel((omap_readl(ISPCCDC_FMTCFG)) |
                                                        ISPCCDC_FMTCFG_FMTEN,
@@ -1040,6 +1080,7 @@ void ispccdc_enable_reformatter(u8 enable)
                                                        ISPCCDC_FMTCFG);
                ispccdc_obj.refmt_en = 0;
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_enable_reformatter);

@@ -1056,7 +1097,9 @@ void ispccdc_config_culling(struct ispccdc_culling cull)
        culling_val |= cull.h_even << ISPCCDC_CULLING_CULHEVN_SHIFT;
        culling_val |= cull.h_odd << ISPCCDC_CULLING_CULHODD_SHIFT;

+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(culling_val, ISPCCDC_CULLING);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_config_culling);

@@ -1066,6 +1109,7 @@ EXPORT_SYMBOL(ispccdc_config_culling);
  **/
 void ispccdc_enable_lpf(u8 enable)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (enable) {
                omap_writel(omap_readl(ISPCCDC_SYN_MODE) |
                                                        ISPCCDC_SYN_MODE_LPF,
@@ -1075,6 +1119,7 @@ void ispccdc_enable_lpf(u8 enable)
                                                        ~ISPCCDC_SYN_MODE_LPF,
                                                        ISPCCDC_SYN_MODE);
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_enable_lpf);

@@ -1084,7 +1129,9 @@ EXPORT_SYMBOL(ispccdc_enable_lpf);
  **/
 void ispccdc_config_alaw(enum alaw_ipwidth ipwidth)
 {
+       down(&ispccdc_mutex);
        omap_writel(ipwidth << ISPCCDC_ALAW_GWDI_SHIFT, ISPCCDC_ALAW);
+       up(&ispccdc_mutex);
 }
 EXPORT_SYMBOL(ispccdc_config_alaw);

@@ -1094,6 +1141,7 @@ EXPORT_SYMBOL(ispccdc_config_alaw);
  **/
 void ispccdc_enable_alaw(u8 enable)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        if (enable) {
                omap_writel((omap_readl(ISPCCDC_ALAW)) | ISPCCDC_ALAW_CCDTBL,
                                                                ISPCCDC_ALAW);
@@ -1101,6 +1149,7 @@ void ispccdc_enable_alaw(u8 enable)
                omap_writel((omap_readl(ISPCCDC_ALAW)) & ~ISPCCDC_ALAW_CCDTBL,
                                                                ISPCCDC_ALAW);
        }
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_enable_alaw);

@@ -1110,7 +1159,9 @@ EXPORT_SYMBOL(ispccdc_enable_alaw);
  **/
 void ispccdc_config_imgattr(u32 colptn)
 {
+       spin_lock(&ispccdc_obj.ispccdc_lock);
        omap_writel(colptn, ISPCCDC_COLPTN);
+       spin_unlock(&ispccdc_obj.ispccdc_lock);
 }
 EXPORT_SYMBOL(ispccdc_config_imgattr);

diff --git a/drivers/media/video/isp/isph3a.c b/drivers/media/video/isp/isph3a.c
old mode 100644
new mode 100755
index 8e75927..fe66521
--- a/drivers/media/video/isp/isph3a.c
+++ b/drivers/media/video/isp/isph3a.c
@@ -36,6 +36,8 @@
 #include "ispmmu.h"
 #include "isppreview.h"

+static DECLARE_MUTEX(isph3a_mutex);
+
 /**
  * struct isph3a_aewb_buffer - AE, AWB frame stats buffer.
  * @virt_addr: Virtual address to mmap the buffer.
@@ -412,13 +414,17 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                WRITE_SAT_LIM(aewb_regs.reg_pcr, user_cfg->saturation_limit);
                aewb_config_local.saturation_limit =
                                                user_cfg->saturation_limit;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (aewb_config_local.alaw_enable != user_cfg->alaw_enable) {
                WRITE_ALAW(aewb_regs.reg_pcr, user_cfg->alaw_enable);
                aewb_config_local.alaw_enable = user_cfg->alaw_enable;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->win_height < MIN_WIN_H) ||
@@ -430,7 +436,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
        } else if (aewb_config_local.win_height != user_cfg->win_height) {
                WRITE_WIN_H(aewb_regs.reg_win1, user_cfg->win_height);
                aewb_config_local.win_height = user_cfg->win_height;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->win_width < MIN_WIN_W) ||
@@ -442,7 +450,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
        } else if (aewb_config_local.win_width != user_cfg->win_width) {
                WRITE_WIN_W(aewb_regs.reg_win1, user_cfg->win_width);
                aewb_config_local.win_width = user_cfg->win_width;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->ver_win_count < 1) ||
@@ -454,7 +464,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                                != user_cfg->ver_win_count) {
                WRITE_VER_C(aewb_regs.reg_win1, user_cfg->ver_win_count);
                aewb_config_local.ver_win_count = user_cfg->ver_win_count;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->hor_win_count < 1) ||
@@ -468,7 +480,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                        user_cfg->hor_win_count);
                aewb_config_local.hor_win_count =
                                        user_cfg->hor_win_count;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely(user_cfg->ver_win_start > MAX_WINSTART)) {
@@ -479,7 +493,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                                != user_cfg->ver_win_start) {
                WRITE_VER_WIN_ST(aewb_regs.reg_start, user_cfg->ver_win_start);
                aewb_config_local.ver_win_start = user_cfg->ver_win_start;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely(user_cfg->hor_win_start > MAX_WINSTART)) {
@@ -492,7 +508,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                         user_cfg->hor_win_start);
                aewb_config_local.hor_win_start =
                                        user_cfg->hor_win_start;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely(user_cfg->blk_ver_win_start > MAX_WINSTART)) {
@@ -505,7 +523,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                        user_cfg->blk_ver_win_start);
                aewb_config_local.blk_ver_win_start =
                                        user_cfg->blk_ver_win_start;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->blk_win_height < MIN_WIN_H)
@@ -520,7 +540,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                user_cfg->blk_win_height);
                aewb_config_local.blk_win_height
                                = user_cfg->blk_win_height;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->subsample_ver_inc < MIN_SUB_INC)
@@ -535,7 +557,9 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                                user_cfg->subsample_ver_inc);
                aewb_config_local.subsample_ver_inc
                                        = user_cfg->subsample_ver_inc;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

        if (unlikely((user_cfg->subsample_hor_inc < MIN_SUB_INC)
@@ -550,13 +574,17 @@ static int isph3a_aewb_set_params(struct isph3a_aewb_config *user_cfg)
                                                user_cfg->subsample_hor_inc);
                aewb_config_local.subsample_hor_inc
                                        = user_cfg->subsample_hor_inc;
+               spin_lock(&aewbstat.buffer_lock);
                aewbstat.update = 1;
+               spin_unlock(&aewbstat.buffer_lock);
        }

+       spin_lock(&aewbstat.buffer_lock);
        if ((!aewbstat.initialized) || (0 == aewb_config_local.aewb_enable)) {
                isph3a_aewb_update_regs();
                aewbstat.initialized = 1;
        }
+       spin_unlock(&aewbstat.buffer_lock);
        return 0;
 }

@@ -601,6 +629,7 @@ int isph3a_aewb_configure(struct isph3a_aewb_config *aewbcfg)
        win_count += (win_count % 8) ? 1 : 0;
        win_count += ret;

+       down(&isph3a_mutex);
        aewbstat.win_count = win_count;
        aewbstat.curr_cfg_buf_size = win_count * AEWB_PACKET_SIZE;

@@ -636,6 +665,7 @@ int isph3a_aewb_configure(struct isph3a_aewb_config *aewbcfg)
                        if (aewbstat.h3a_buff[i].virt_addr == 0) {
                                printk(KERN_ERR "Can't acquire memory for "
                                        "buffer[%d]\n", i);
+                               up(&isph3a_mutex);
                                return -ENOMEM;
                        }
                        aewbstat.h3a_buff[i].addr_align =
@@ -671,7 +701,7 @@ int isph3a_aewb_configure(struct isph3a_aewb_config *aewbcfg)
        }
        isph3a_aewb_enable(aewbcfg->aewb_enable);
        isph3a_print_status();
-
+       up(&isph3a_mutex);
        return 0;
 }
 EXPORT_SYMBOL(isph3a_aewb_configure);
@@ -756,9 +786,11 @@ int isph3a_aewb_request_statistics(struct isph3a_aewb_data *aewbdata)
                                DPRINTK_ISPH3A("Waiting on stats IRQ "
                                        "for frame %d\n",
                                        aewbdata->frame_number);
+                               down(&isph3a_mutex);
                                aewbstat.frame_req = aewbdata->frame_number;
                                aewbstat.stats_req = 1;
                                aewbstat.stats_done = 0;
+                               up(&isph3a_mutex);
                                init_waitqueue_entry(&wqt, current);
                                ret = wait_event_interruptible
                                                (aewbstat.stats_wait,
diff --git a/drivers/media/video/isp/isphist.c b/drivers/media/video/isp/isphist.c
old mode 100644
new mode 100755
index ef99668..5706adb
--- a/drivers/media/video/isp/isphist.c
+++ b/drivers/media/video/isp/isphist.c
@@ -36,6 +36,8 @@
 #include "ispmmu.h"
 #include "isppreview.h"

+static DECLARE_MUTEX(isphist_mutex);
+
 /**
  * struct isp_hist_status - Histogram status.
  * @hist_enable: Enables the histogram module.
@@ -154,6 +156,7 @@ static void isp_hist_enable(u8 enable)
  **/
 static void isp_hist_update_regs(void)
 {
+       down(&isphist_mutex);
        omap_writel(hist_regs.reg_pcr, ISPHIST_PCR);
        omap_writel(hist_regs.reg_cnt, ISPHIST_CNT);
        omap_writel(hist_regs.reg_wb_gain, ISPHIST_WB_GAIN);
@@ -170,7 +173,7 @@ static void isp_hist_update_regs(void)
        omap_writel(hist_regs.reg_hist_radd, ISPHIST_RADD);
        omap_writel(hist_regs.reg_hist_radd_off, ISPHIST_RADD_OFF);
        omap_writel(hist_regs.reg_h_v_info, ISPHIST_H_V_INFO);
-
+       up(&isphist_mutex);
 }

 /**
@@ -235,6 +238,7 @@ static int isp_hist_set_params(struct isp_hist_config *user_cfg)
        if (omap_readl(ISPHIST_PCR) & ISPHIST_PCR_BUSY_MASK)
                return -EINVAL;

+       down(&isphist_mutex);
        if (user_cfg->input_bit_width > MIN_BIT_WIDTH)
                WRITE_DATA_SIZE(hist_regs.reg_cnt, 0);
        else
@@ -252,6 +256,7 @@ static int isp_hist_set_params(struct isp_hist_config *user_cfg)
                } else {
                        printk(KERN_ERR "Address should be in 32 byte boundary"
                                                                        "\n");
+                       up(&isphist_mutex);
                        return -EINVAL;
                }

@@ -262,6 +267,7 @@ static int isp_hist_set_params(struct isp_hist_config *user_cfg)
                } else {
                        printk(KERN_ERR "Offset should be in 32 byte boundary"
                                                                        "\n");
+                       up(&isphist_mutex);
                        return -EINVAL;
                }

@@ -270,6 +276,7 @@ static int isp_hist_set_params(struct isp_hist_config *user_cfg)
        isp_hist_reset_mem();
        DPRINTK_ISPHIST("ISPHIST: Memory Cleared\n");
        histstat.frame_req = user_cfg->hist_frames;
+       up(&isphist_mutex);

        if (unlikely((user_cfg->wb_gain_R > MAX_WB_GAIN) ||
                                (user_cfg->wb_gain_RG > MAX_WB_GAIN) ||
@@ -450,8 +457,10 @@ int isp_hist_configure(struct isp_hist_config *histcfg)
                return ret;
        }

+       down(&isphist_mutex);
        histstat.frame_cnt = 0;
        histstat.completed = 0;
+       up(&isphist_mutex);
        isp_hist_enable(1);
        isp_hist_print_status();

@@ -478,8 +487,10 @@ int isp_hist_request_statistics(struct isp_hist_data *histdata)
        if (!histstat.completed && histstat.initialized)
                return -EINVAL;

+       down(&isphist_mutex);
        omap_writel((omap_readl(ISPHIST_CNT)) | ISPHIST_CNT_CLR_EN,
                                                                ISPHIST_CNT);
+       up(&isphist_mutex);

        for (i = 0; i < HIST_MEM_SIZE; i++) {
                curr = omap_readl(ISPHIST_DATA);
@@ -492,9 +503,11 @@ int isp_hist_request_statistics(struct isp_hist_data *histdata)
                }
        }

+       down(&isphist_mutex);
        omap_writel((omap_readl(ISPHIST_CNT)) & ~ISPHIST_CNT_CLR_EN,
                                                                ISPHIST_CNT);
        histstat.completed = 0;
+       up(&isphist_mutex);
        return 0;
 }
 EXPORT_SYMBOL(isp_hist_request_statistics);
diff --git a/drivers/media/video/isp/ispmmu.c b/drivers/media/video/isp/ispmmu.c
old mode 100644
new mode 100755
index 7d9cc73..6c75c9b
--- a/drivers/media/video/isp/ispmmu.c
+++ b/drivers/media/video/isp/ispmmu.c
@@ -68,6 +68,8 @@ static struct isp_reg ispmmu_reg_list[] = {
        {ISP_TOK_TERM, 0x0000}
 };

+static DECLARE_MUTEX(ispmmu_mutex);
+
 /* Page structure for statically allocated l1 and l2 page tables */
 static struct page *ttb_page;
 static struct page *l2p_page;
@@ -362,7 +364,9 @@ dma_addr_t ispmmu_map(u32 p_addr, int size)
        DPRINTK_ISPMMU("mapped to ISP virtual address 0x%x\n",
                (u32)((idx << 20) + (p_addr & (PAGE_SIZE - 1))));

+       down(&ispmmu_mutex);
        omap_writel(1, ISPMMU_GFLUSH);
+       up(&ispmmu_mutex);
        ret_addr = (dma_addr_t)((idx << 20) + (p_addr & (PAGE_SIZE - 1)));
        return ret_addr;

@@ -446,7 +450,9 @@ dma_addr_t ispmmu_map_sg(const struct scatterlist *sglist, int sglen)
                (u32)((idx << 20) + (sg_dma_address(sglist + 0) &
                                                (PAGE_SIZE - 1))), idx);

+       down(&ispmmu_mutex);
        omap_writel(1, ISPMMU_GFLUSH);
+       up(&ispmmu_mutex);
        ret_addr = (dma_addr_t)((idx << 20) + (sg_dma_address(sglist + 0) &
                                                        (PAGE_SIZE - 1)));
        return ret_addr;
@@ -508,7 +514,9 @@ int ispmmu_unmap(dma_addr_t v_addr)
                        break;
                }
        }
+       down(&ispmmu_mutex);
        omap_writel(1, ISPMMU_GFLUSH);
+       up(&ispmmu_mutex);

        DPRINTK_ISPMMU("-ispmmu_unmap()\n");
        return 0;
diff --git a/drivers/media/video/isp/isppreview.c b/drivers/media/video/isp/isppreview.c
index 3c214c3..abee2d5 100755
--- a/drivers/media/video/isp/isppreview.c
+++ b/drivers/media/video/isp/isppreview.c
@@ -29,6 +29,8 @@
 #include "ispreg.h"
 #include "isppreview.h"

+static DECLARE_MUTEX(isppreview_mutex);
+
 static struct ispprev_nf prev_nf_t;
 static struct ispprev_csc prev_csc_t;
 static struct prev_params *params;
@@ -374,10 +376,15 @@ int omap34xx_isp_preview_config(void *userspace_add)

        if ((ISP_ABS_PREV_COLOR_CONV & preview_struct->update) ==
                                                ISP_ABS_PREV_COLOR_CONV) {
+               down(&isppreview_mutex);
                if (copy_from_user(&prev_csc_t, (struct ispprev_csc *)
                                                (preview_struct->prev_csc),
-                                               sizeof(struct ispprev_csc)))
+                                               sizeof(struct ispprev_csc))) {
+                       up(&isppreview_mutex);
                        goto err_copy_from_user;
+               }
+               up(&isppreview_mutex);
+
                spin_lock(&ispprev_obj.ispprev_lock);
                if (ispprev_obj.stream_on == 0) {
                        isppreview_config_rgb_to_ycbcr(prev_csc_t);
@@ -458,10 +465,15 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
                params->features |= (PREV_NOISE_FILTER);
                if ((ISP_ABS_TBL_NF & isptables_struct->update) ==
                                                        ISP_ABS_TBL_NF) {
+                       down(&isppreview_mutex);
                        if (copy_from_user(&prev_nf_t, (struct ispprev_nf *)
                                                (isptables_struct->prev_nf),
-                                               sizeof(struct ispprev_nf)))
+                                               sizeof(struct ispprev_nf))) {
+                               up(&isppreview_mutex);
                                goto err_copy_from_user;
+                       }
+                       up(&isppreview_mutex);
+
                        spin_lock(&ispprev_obj.ispprev_lock);
                        if (ispprev_obj.stream_on == 0) {
                                NF_update = 0;
@@ -485,10 +497,13 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)

        if ((ISP_ABS_TBL_REDGAMMA & isptables_struct->update) ==
                                                        ISP_ABS_TBL_REDGAMMA) {
+               down(&isppreview_mutex);
                if (copy_from_user(redgamma_table, isptables_struct->red_gamma,
                                                sizeof(redgamma_table))) {
+                       up(&isppreview_mutex);
                        goto err_copy_from_user;
                }
+               up(&isppreview_mutex);
                spin_lock(&ispprev_obj.ispprev_lock);
                if (ispprev_obj.stream_on == 0) {
                        omap_writel(ISPPRV_TBL_ADDR_RED_G_START,
@@ -500,15 +515,22 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
                        RG_update = 1;

                spin_unlock(&ispprev_obj.ispprev_lock);
-       } else
+       } else {
+               spin_lock(&ispprev_obj.ispprev_lock);
                RG_update = 0;
+               spin_unlock(&ispprev_obj.ispprev_lock);
+       }

        if ((ISP_ABS_TBL_GREENGAMMA & isptables_struct->update) ==
                                                ISP_ABS_TBL_GREENGAMMA) {
+               down(&isppreview_mutex);
                if (copy_from_user(greengamma_table,
                                                isptables_struct->green_gamma,
-                                               sizeof(greengamma_table)))
+                                               sizeof(greengamma_table))) {
+                       up(&isppreview_mutex);
                        goto err_copy_from_user;
+               }
+               up(&isppreview_mutex);
                spin_lock(&ispprev_obj.ispprev_lock);
                if (ispprev_obj.stream_on == 0) {
                        omap_writel(ISPPRV_TBL_ADDR_GREEN_G_START,
@@ -520,16 +542,22 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
                        GG_update = 1;

                spin_unlock(&ispprev_obj.ispprev_lock);
-       } else
-                GG_update = 0;
+       } else {
+               spin_lock(&ispprev_obj.ispprev_lock);
+               GG_update = 0;
+               spin_unlock(&ispprev_obj.ispprev_lock);
+       }

        if ((ISP_ABS_TBL_BLUEGAMMA & isptables_struct->update) ==
                                        ISP_ABS_TBL_BLUEGAMMA) {
+               down(&isppreview_mutex);
                if (copy_from_user(bluegamma_table, (isptables_struct->
                                                blue_gamma),
                                                sizeof(bluegamma_table))) {
+                       up(&isppreview_mutex);
                        goto err_copy_from_user;
                }
+               up(&isppreview_mutex);
                spin_lock(&ispprev_obj.ispprev_lock);
                if (ispprev_obj.stream_on == 0) {
                        omap_writel(ISPPRV_TBL_ADDR_BLUE_G_START,
@@ -541,8 +569,11 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
                        BG_update = 1;

                spin_unlock(&ispprev_obj.ispprev_lock);
-       } else
-                BG_update = 0;
+       } else {
+               spin_lock(&ispprev_obj.ispprev_lock);
+               BG_update = 0;
+               spin_unlock(&ispprev_obj.ispprev_lock);
+       }

        return 0;

@@ -755,10 +786,12 @@ int isppreview_config_datapath(enum preview_input input,
                printk(KERN_ERR "ISP_ERR : Wrong Output\n");
                return -EINVAL;
        }
+       spin_lock(&ispprev_obj.ispprev_lock);
        omap_writel(pcr, ISPPRV_PCR);

        isppreview_config_ycpos(params->pix_fmt);

+       spin_unlock(&ispprev_obj.ispprev_lock);
        if (params->cfa.cfa_table != NULL)
                isppreview_config_cfa(params->cfa);
        if (params->csup.hypf_en == 1)
@@ -861,12 +894,14 @@ void isppreview_enable_invalaw(u8 enable)
        u32 pcr_val = 0;
        pcr_val = omap_readl(ISPPRV_PCR);

+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable)
                omap_writel(pcr_val | ISPPRV_PCR_WIDTH | ISPPRV_PCR_INVALAW,
                                                                ISPPRV_PCR);
        else
                omap_writel(pcr_val & ~(ISPPRV_PCR_WIDTH | ISPPRV_PCR_INVALAW),
                                                                ISPPRV_PCR);
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_invalaw);

@@ -879,12 +914,14 @@ EXPORT_SYMBOL(isppreview_enable_invalaw);
  **/
 void isppreview_enable_drkframe(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable)
                omap_writel(omap_readl(ISPPRV_PCR) | ISPPRV_PCR_DRKFEN,
                                                                ISPPRV_PCR);
        else
                omap_writel((omap_readl(ISPPRV_PCR)) & ~ISPPRV_PCR_DRKFEN,
                                                                ISPPRV_PCR);
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_drkframe);

@@ -897,7 +934,7 @@ EXPORT_SYMBOL(isppreview_enable_drkframe);
  **/
 void isppreview_enable_shadcomp(u8 enable)
 {
-
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_SCOMP_EN,
                                                                ISPPRV_PCR);
@@ -906,6 +943,7 @@ void isppreview_enable_shadcomp(u8 enable)
                omap_writel((omap_readl(ISPPRV_PCR)) & ~ISPPRV_PCR_SCOMP_EN,
                                                                ISPPRV_PCR);
        }
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_shadcomp);

@@ -918,8 +956,10 @@ void isppreview_config_drkf_shadcomp(u8 scomp_shtval)
        u32 pcr_val = omap_readl(ISPPRV_PCR);

        pcr_val &= ISPPRV_PCR_SCOMP_SFT_MASK;
+       spin_lock(&ispprev_obj.ispprev_lock);
        omap_writel(pcr_val | (scomp_shtval << ISPPRV_PCR_SCOMP_SFT_SHIFT),
                                                                ISPPRV_PCR);
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_config_drkf_shadcomp);

@@ -929,6 +969,7 @@ EXPORT_SYMBOL(isppreview_config_drkf_shadcomp);
  **/
 void isppreview_enable_hmed(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_HMEDEN,
                        ISPPRV_PCR);
@@ -938,6 +979,7 @@ void isppreview_enable_hmed(u8 enable)
                        ISPPRV_PCR);
                ispprev_obj.hmed_en = 0;
        }
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_hmed);

@@ -962,10 +1004,11 @@ void isppreview_config_hmed(struct ispprev_hmed prev_hmed)
        else
                evendist = ISPPRV_HMED_EVENDIST;

+       spin_lock(&ispprev_obj.ispprev_lock);
        omap_writel(odddist | evendist | (prev_hmed.thres <<
                                                ISPPRV_HMED_THRESHOLD_SHIFT),
                                                ISPPRV_HMED);
-
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_config_hmed);

@@ -990,6 +1033,7 @@ EXPORT_SYMBOL(isppreview_config_noisefilter);
  **/
 void isppreview_config_dcor(struct ispprev_dcor prev_dcor)
 {
+       down(&isppreview_mutex);
        if (prev_dcor.couplet_mode_en) {
                omap_writel(prev_dcor.detect_correct[0], ISPPRV_CDC_THR0);
                omap_writel(prev_dcor.detect_correct[1], ISPPRV_CDC_THR1);
@@ -1001,6 +1045,7 @@ void isppreview_config_dcor(struct ispprev_dcor prev_dcor)
                omap_writel((omap_readl(ISPPRV_PCR)) & ~ISPPRV_PCR_DCCOUP,
                                                                ISPPRV_PCR);
        }
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_dcor);

@@ -1012,6 +1057,7 @@ EXPORT_SYMBOL(isppreview_config_dcor);
 void isppreview_config_cfa(struct ispprev_cfa prev_cfa)
 {
        int i = 0;
+       down(&isppreview_mutex);
        ispprev_obj.cfafmt = prev_cfa.cfafmt;

        omap_writel((omap_readl(ISPPRV_PCR)) | (prev_cfa.cfafmt <<
@@ -1027,6 +1073,7 @@ void isppreview_config_cfa(struct ispprev_cfa prev_cfa)

        for (i = 0; i < 576; i++)
                omap_writel(prev_cfa.cfa_table[i], ISPPRV_SET_TBL_DATA);
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_cfa);

@@ -1038,6 +1085,7 @@ void isppreview_config_gammacorrn(struct ispprev_gtable gtable)
 {
        int i = 0;

+       down(&isppreview_mutex);
        omap_writel(ISPPRV_REDGAMMA_TABLE_ADDR, ISPPRV_SET_TBL_ADDR);
        for (i = 0; i < 1024; i++)
                omap_writel(gtable.redtable[i], ISPPRV_SET_TBL_DATA);
@@ -1049,6 +1097,7 @@ void isppreview_config_gammacorrn(struct ispprev_gtable gtable)
        omap_writel(ISPPRV_BLUEGAMMA_TABLE_ADDR, ISPPRV_SET_TBL_ADDR);
        for (i = 0; i < 1024; i++)
                omap_writel(gtable.bluetable[i], ISPPRV_SET_TBL_DATA);
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_gammacorrn);

@@ -1059,9 +1108,11 @@ EXPORT_SYMBOL(isppreview_config_gammacorrn);
 void isppreview_config_luma_enhancement(u32 *ytable)
 {
        int i = 0;
+       down(&isppreview_mutex);
        omap_writel(ISPPRV_YENH_TABLE_ADDR, ISPPRV_SET_TBL_ADDR);
        for (i = 0; i < 128; i++)
                omap_writel(ytable[i], ISPPRV_SET_TBL_DATA);
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_luma_enhancement);

@@ -1072,9 +1123,11 @@ EXPORT_SYMBOL(isppreview_config_luma_enhancement);
  **/
 void isppreview_config_chroma_suppression(struct ispprev_csup csup)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        omap_writel(csup.gain | (csup.thres << ISPPRV_CSUP_THRES_SHIFT) |
                                (csup.hypf_en << ISPPRV_CSUP_HPYF_SHIFT),
                                ISPPRV_CSUP);
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_config_chroma_suppression);

@@ -1102,6 +1155,7 @@ EXPORT_SYMBOL(isppreview_enable_noisefilter);
  **/
 void isppreview_enable_dcor(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_DCOREN,
                                                                ISPPRV_PCR);
@@ -1111,6 +1165,7 @@ void isppreview_enable_dcor(u8 enable)
                                                                ISPPRV_PCR);
                ispprev_obj.dcor_en = 0;
        }
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_dcor);

@@ -1120,6 +1175,7 @@ EXPORT_SYMBOL(isppreview_enable_dcor);
  **/
 void isppreview_enable_cfa(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_CFAEN,
                                                                ISPPRV_PCR);
@@ -1129,7 +1185,7 @@ void isppreview_enable_cfa(u8 enable)
                                                                ISPPRV_PCR);
                ispprev_obj.cfa_en = 0;
        }
-
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_cfa);

@@ -1140,6 +1196,7 @@ EXPORT_SYMBOL(isppreview_enable_cfa);
  **/
 void isppreview_enable_gammabypass(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_GAMMA_BYPASS,
                                                                ISPPRV_PCR);
@@ -1148,6 +1205,7 @@ void isppreview_enable_gammabypass(u8 enable)
                                                ~ISPPRV_PCR_GAMMA_BYPASS,
                                                ISPPRV_PCR);
        }
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_gammabypass);

@@ -1157,6 +1215,7 @@ EXPORT_SYMBOL(isppreview_enable_gammabypass);
  **/
 void isppreview_enable_luma_enhancement(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_YNENHEN,
                                                                ISPPRV_PCR);
@@ -1166,6 +1225,7 @@ void isppreview_enable_luma_enhancement(u8 enable)
                                                                ISPPRV_PCR);
                ispprev_obj.yenh_en = 0;
        }
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_luma_enhancement);

@@ -1175,6 +1235,7 @@ EXPORT_SYMBOL(isppreview_enable_luma_enhancement);
  **/
 void isppreview_enable_chroma_suppression(u8 enable)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        if (enable) {
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_SUPEN,
                                                                ISPPRV_PCR);
@@ -1184,6 +1245,7 @@ void isppreview_enable_chroma_suppression(u8 enable)
                                                                ISPPRV_PCR);
                ispprev_obj.csup_en = 0;
        }
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_enable_chroma_suppression);

@@ -1196,7 +1258,7 @@ EXPORT_SYMBOL(isppreview_enable_chroma_suppression);
  **/
 void isppreview_config_whitebalance(struct ispprev_wbal prev_wbal)
 {
-
+       down(&isppreview_mutex);
        omap_writel(prev_wbal.dgain, ISPPRV_WB_DGAIN);
        omap_writel(prev_wbal.coef0 |
                                prev_wbal.coef1 << ISPPRV_WBGAIN_COEF1_SHIFT |
@@ -1221,7 +1283,7 @@ void isppreview_config_whitebalance(struct ispprev_wbal prev_wbal)
                        (ISPPRV_WBSEL_COEF2 << ISPPRV_WBSEL_N3_2_SHIFT) |
                        (ISPPRV_WBSEL_COEF3 << ISPPRV_WBSEL_N3_3_SHIFT),
                        ISPPRV_WBSEL);
-
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_whitebalance);

@@ -1234,6 +1296,7 @@ EXPORT_SYMBOL(isppreview_config_whitebalance);
  **/
 void isppreview_config_whitebalance2(struct prev_white_balance prev_wbal)
 {
+       down(&isppreview_mutex);
        omap_writel(prev_wbal.wb_dgain, ISPPRV_WB_DGAIN);
        omap_writel(prev_wbal.wb_gain[0] |
                (prev_wbal.wb_gain[1] << ISPPRV_WBGAIN_COEF1_SHIFT) |
@@ -1258,6 +1321,7 @@ void isppreview_config_whitebalance2(struct prev_white_balance prev_wbal)
                prev_wbal.wb_coefmatrix[3][2] << ISPPRV_WBSEL_N3_2_SHIFT |
                prev_wbal.wb_coefmatrix[3][3] << ISPPRV_WBSEL_N3_3_SHIFT,
                ISPPRV_WBSEL);
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_whitebalance2);

@@ -1268,11 +1332,13 @@ EXPORT_SYMBOL(isppreview_config_whitebalance2);
  **/
 void isppreview_config_blkadj(struct ispprev_blkadj prev_blkadj)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        omap_writel(prev_blkadj.blue | (prev_blkadj.green <<
                                        ISPPRV_BLKADJOFF_G_SHIFT) |
                                        (prev_blkadj.red <<
                                        ISPPRV_BLKADJOFF_R_SHIFT),
                                        ISPPRV_BLKADJOFF);
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_config_blkadj);

@@ -1283,6 +1349,7 @@ EXPORT_SYMBOL(isppreview_config_blkadj);
  **/
 void isppreview_config_rgb_blending(struct ispprev_rgbtorgb rgb2rgb)
 {
+       down(&isppreview_mutex);
        omap_writel((rgb2rgb.matrix[0][0] << ISPPRV_RGB_MAT1_MTX_RR_SHIFT) |
                                                (rgb2rgb.matrix[0][1] <<
                                                ISPPRV_RGB_MAT1_MTX_GR_SHIFT),
@@ -1312,7 +1379,7 @@ void isppreview_config_rgb_blending(struct ispprev_rgbtorgb rgb2rgb)

        omap_writel(rgb2rgb.offset[2] << ISPPRV_RGB_OFF2_MTX_OFFB_SHIFT,
                                                ISPPRV_RGB_OFF2);
-
+       up(&isppreview_mutex);
 }
 EXPORT_SYMBOL(isppreview_config_rgb_blending);

@@ -1366,7 +1433,9 @@ EXPORT_SYMBOL(isppreview_query_contrast);
  **/
 void isppreview_update_contrast(u8 *contrast)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        ispprev_obj.contrast = *contrast;
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_update_contrast);

@@ -1407,7 +1476,9 @@ EXPORT_SYMBOL(isppreview_get_contrast_range);
  **/
 void isppreview_update_brightness(u8 *brightness)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        ispprev_obj.brightness = *brightness;
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_update_brightness);

@@ -1485,11 +1556,13 @@ EXPORT_SYMBOL(isppreview_get_color);
  **/
 void isppreview_config_yc_range(struct ispprev_yclimit yclimit)
 {
+       spin_lock(&ispprev_obj.ispprev_lock);
        omap_writel(((yclimit.maxC << ISPPRV_SETUP_YC_MAXC_SHIFT) |
                                (yclimit.maxY << ISPPRV_SETUP_YC_MAXY_SHIFT) |
                                (yclimit.minC << ISPPRV_SETUP_YC_MINC_SHIFT) |
                                (yclimit.minY << ISPPRV_SETUP_YC_MINY_SHIFT)),
                                ISPPRV_SETUP_YC);
+       spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_config_yc_range);

@@ -1539,6 +1612,7 @@ int isppreview_try_size(u32 input_w, u32 input_h, u32 *output_w, u32 *output_h)
                }
        }

+       down(&isppreview_mutex);
        if (ispprev_obj.hmed_en)
                prevout_w -= 4;
        if (ispprev_obj.nf_en) {
@@ -1563,6 +1637,8 @@ int isppreview_try_size(u32 input_w, u32 input_h, u32 *output_w, u32 *output_h)
        if ((ispprev_obj.yenh_en) || (ispprev_obj.csup_en))
                prevout_w -= 2;

+       up(&isppreview_mutex);
+
        /* Start at the correct row/column by skipping
         * a Sensor specific amount.
         */
@@ -1758,15 +1834,15 @@ void isppreview_enable(u8 enable)
        if (enable) {
                spin_lock(&ispprev_obj.ispprev_lock);
                ispprev_obj.stream_on = 1;
-               spin_unlock(&ispprev_obj.ispprev_lock);
                omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_EN,
                                                                ISPPRV_PCR);
+               spin_unlock(&ispprev_obj.ispprev_lock);
        } else {
                spin_lock(&ispprev_obj.ispprev_lock);
                ispprev_obj.stream_on = 0;
-               spin_unlock(&ispprev_obj.ispprev_lock);
                omap_writel((omap_readl(ISPPRV_PCR)) & ~ISPPRV_PCR_EN,
                                                                ISPPRV_PCR);
+               spin_unlock(&ispprev_obj.ispprev_lock);
        }
 }
 EXPORT_SYMBOL(isppreview_enable);
diff --git a/drivers/media/video/isp/ispresizer.c b/drivers/media/video/isp/ispresizer.c
old mode 100644
new mode 100755
index e841373..e3766d5
--- a/drivers/media/video/isp/ispresizer.c
+++ b/drivers/media/video/isp/ispresizer.c
@@ -33,6 +33,8 @@
 dma_addr_t buff_addr_lsc_wa;
 #endif

+static DECLARE_MUTEX(ispresizer_mutex);
+
 /* Default configuration of resizer,filter coefficients,yenh for camera isp */
 static struct isprsz_yenh ispreszdefaultyenh = {0, 0, 0, 0};
 static struct isprsz_coef ispreszdefcoef = {
@@ -218,9 +220,9 @@ int ispresizer_request()
        mutex_lock(&ispres_obj.ispres_mutex);
        if (!ispres_obj.res_inuse) {
                ispres_obj.res_inuse = 1;
-               mutex_unlock(&ispres_obj.ispres_mutex);
                omap_writel(omap_readl(ISP_CTRL) | ISPCTRL_SBL_WR0_RAM_EN |
                                                ISPCTRL_RSZ_CLK_EN, ISP_CTRL);
+               mutex_unlock(&ispres_obj.ispres_mutex);
                return 0;
        } else {
                mutex_unlock(&ispres_obj.ispres_mutex);
@@ -240,9 +242,9 @@ int ispresizer_free()
        mutex_lock(&ispres_obj.ispres_mutex);
        if (ispres_obj.res_inuse) {
                ispres_obj.res_inuse = 0;
-               mutex_unlock(&ispres_obj.ispres_mutex);
                omap_writel(omap_readl(ISP_CTRL) & ~(ISPCTRL_RSZ_CLK_EN |
                                        ISPCTRL_SBL_WR0_RAM_EN), ISP_CTRL);
+               mutex_unlock(&ispres_obj.ispres_mutex);
                return 0;
        } else {
                mutex_unlock(&ispres_obj.ispres_mutex);
@@ -284,7 +286,9 @@ int ispresizer_config_datapath(enum ispresizer_input input)
                printk(KERN_ERR "ISP_ERR : Wrong Input\n");
                return -EINVAL;
        }
+       down(&ispresizer_mutex);
        omap_writel(omap_readl(ISPRSZ_CNT) | cnt, ISPRSZ_CNT);
+       up(&ispresizer_mutex);
        ispresizer_config_ycpos(0);
        ispresizer_config_filter_coef(&ispreszdefcoef);
        ispresizer_enable_cbilin(0);
@@ -512,12 +516,14 @@ int ispresizer_config_size(u32 input_w, u32 input_h, u32 output_w,
        }
 #endif

+       down(&ispresizer_mutex);
        res = omap_readl(ISPRSZ_CNT) & (~(ISPRSZ_CNT_HSTPH_MASK |
                                        ISPRSZ_CNT_VSTPH_MASK));
        omap_writel(res | (ispres_obj.h_startphase << ISPRSZ_CNT_HSTPH_SHIFT) |
                                                (ispres_obj.v_startphase <<
                                                ISPRSZ_CNT_VSTPH_SHIFT),
                                                ISPRSZ_CNT);
+       up(&ispresizer_mutex);
 #if ISP_WORKAROUND
        omap_writel((0x00 <<    ISPRSZ_IN_START_HORZ_ST_SHIFT) |
                                        (0x00 <<
@@ -548,12 +554,14 @@ int ispresizer_config_size(u32 input_w, u32 input_h, u32 output_w,
                                                ISPRSZ_OUT_SIZE);
        }

+       down(&ispresizer_mutex);
        res = omap_readl(ISPRSZ_CNT) & (~(ISPRSZ_CNT_HRSZ_MASK |
                                                ISPRSZ_CNT_VRSZ_MASK));
        omap_writel(res | ((ispres_obj.h_resz - 1) << ISPRSZ_CNT_HRSZ_SHIFT) |
                                                ((ispres_obj.v_resz - 1) <<
                                                ISPRSZ_CNT_VRSZ_SHIFT),
                                                ISPRSZ_CNT);
+       up(&ispresizer_mutex);
        if (ispres_obj.h_resz <= MID_RESIZE_VALUE) {
                j = 0;
                for (i = 0; i < 16; i++) {
@@ -680,6 +688,7 @@ EXPORT_SYMBOL(ispresizer_config_startphase);
  **/
 void ispresizer_config_ycpos(u8 yc)
 {
+       down(&ispresizer_mutex);
        DPRINTK_ISPRESZ("ispresizer_config_ycpos()+\n");
        if (yc)
                omap_writel((omap_readl(ISPRSZ_CNT)) |
@@ -688,6 +697,7 @@ void ispresizer_config_ycpos(u8 yc)
                omap_writel((omap_readl(ISPRSZ_CNT)) &
                        (~ISPRSZ_CNT_YCPOS), ISPRSZ_CNT);
        DPRINTK_ISPRESZ("ispresizer_config_ycpos()-\n");
+       up(&ispresizer_mutex);
 }
 EXPORT_SYMBOL(ispresizer_config_ycpos);

@@ -698,6 +708,7 @@ EXPORT_SYMBOL(ispresizer_config_ycpos);
  **/
 void ispresizer_enable_cbilin(u8 enable)
 {
+       down(&ispresizer_mutex);
        DPRINTK_ISPRESZ("ispresizer_enable_cbilin()+\n");
        if (enable) {
                omap_writel(omap_readl(ISPRSZ_CNT) | ISPRSZ_CNT_CBILIN,
@@ -707,6 +718,7 @@ void ispresizer_enable_cbilin(u8 enable)
                                                                ISPRSZ_CNT);
        }
        DPRINTK_ISPRESZ("ispresizer_enable_cbilin()-\n");
+       up(&ispresizer_mutex);
 }
 EXPORT_SYMBOL(ispresizer_enable_cbilin);

diff --git a/drivers/media/video/isp/omap_resizer.c b/drivers/media/video/isp/omap_resizer.c
old mode 100644
new mode 100755
index 10bca42..b3258df
--- a/drivers/media/video/isp/omap_resizer.c
+++ b/drivers/media/video/isp/omap_resizer.c
@@ -76,6 +76,8 @@
 #define MAX_COEF_COUNTER       16
 #define COEFF_ADDRESS_OFFSET   0x04

+static DECLARE_MUTEX(resz_wrapper_mutex);
+
 /* Global structure which contains information about number of channels
    and protection variables */
 struct device_params {
@@ -238,6 +240,7 @@ static void rsz_hardware_setup(struct channel_config *rsz_conf_chan)
        int coeffcounter;
        int coeffoffset = 0;

+       down(&resz_wrapper_mutex);
        omap_writel(rsz_conf_chan->register_config.rsz_cnt, ISPRSZ_CNT);

        omap_writel(rsz_conf_chan->register_config.rsz_in_start,
@@ -268,6 +271,7 @@ static void rsz_hardware_setup(struct channel_config *rsz_conf_chan)
                                                ISPRSZ_VFILT10 + coeffoffset);
                coeffoffset = coeffoffset + COEFF_ADDRESS_OFFSET;
        }
+       up(&resz_wrapper_mutex);
 }

 /**
--
1.5.6.5

