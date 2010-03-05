From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Implement WDT3 to notify DSP hangs
Date: Fri, 5 Mar 2010 04:11:14 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA9E405E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014Ab0CEKLV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 05:11:21 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Uribe de Leon, Armando" <x0095078@ti.com>

>From 43f9da61f092f68a4acf7e567e82a2ae3df1e71d Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 5 Mar 2010 02:34:08 -0600
Subject: [PATCH 1/2] DSPBRIDGE: Implement WDT3 to notify DSP hangs

This patch implements wdt3 feature to notify wdt3 overflow.
This new feature can be chosen by doing make menuconfig,
default is disabled.

WDT3 is upcount Timer incrementing every functional clock tick
till it reaches programmed timeout value. On reaching timeout
value, if INTerrupt bit for WDT3 is enabled, then an interrupt
is generated to MPU.

After receiving this Interrupt, any client can register within
bridge driver to be notified of this event and prepare for
DSP recovery.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Armando Uribe <x0095078@ti.com>
Signed-off-by: Somashekar Chandrappa <somashekar.c@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    7 ++
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    3 +
 arch/arm/plat-omap/include/dspbridge/drv.h      |    3 +
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |   13 +++
 drivers/dsp/bridge/Kconfig                      |   17 ++++
 drivers/dsp/bridge/rmgr/drv.c                   |    3 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    5 +-
 drivers/dsp/bridge/services/clk.c               |    4 +-
 drivers/dsp/bridge/wmd/_tiomap.h                |    6 +
 drivers/dsp/bridge/wmd/io_sm.c                  |  117 +++++++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430.c             |   13 +++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |   17 ++++
 drivers/dsp/bridge/wmd/tiomap_sm.c              |    5 +
 drivers/dsp/bridge/wmd/ue_deh.c                 |   16 +++
 14 files changed, 224 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 620d4af..384a7cc 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -99,7 +99,14 @@ struct shm {
        struct opp_rqst_struct opp_request;
        /* load monitor information structure */
        struct load_mon_struct load_mon_info;
+#ifdef CONFIG_BRIDGE_WDT3
+       /* Flag for WDT enable/disable F/I clocks */
+       u32 wdt_setclocks;
+       u32 wdt_overflow;       /* WDT overflow time */
+       char dummy[176];        /* padding to 256 byte boundary */
+#else
        char dummy[184];        /* padding to 256 byte boundary */
+#endif
        u32 shm_dbg_var[64];    /* shared memory debug variables */
 };

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 0a85e12..3f76787 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -53,6 +53,7 @@
 #define DSP_SYSERROR                0x00000020
 #define DSP_EXCEPTIONABORT          0x00000300
 #define DSP_PWRERROR                0x00000080
+#define DSP_WDTOVERFLOW        0x00000040

 /* IVA exception events (IVA MMU fault) */
 #define IVA_MMUFAULT                0x00000040
@@ -119,6 +120,7 @@
                                    DSP_STREAMIOCOMPLETION | \
                                    DSP_MMUFAULT | \
                                    DSP_SYSERROR | \
+                                   DSP_WDTOVERFLOW | \
                                    DSP_PWRERROR)) && \
                                !((x) & ~(DSP_PROCESSORSTATECHANGE | \
                                    DSP_PROCESSORATTACH | \
@@ -129,6 +131,7 @@
                                    DSP_STREAMIOCOMPLETION | \
                                    DSP_MMUFAULT | \
                                    DSP_SYSERROR | \
+                                   DSP_WDTOVERFLOW | \
                                    DSP_PWRERROR))))

 #define IS_VALID_NODE_EVENT(x)    (((x) == 0) || (((x) & (DSP_NODESTATECHANGE | \
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 3cc0e2d..2191a87 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -73,6 +73,9 @@
 #define OMAP_DMMU_BASE 0x5D000000
 #define OMAP_DMMU_SIZE 0x1000

+#define OMAP_WDT3_BASE 0x49030000
+#define OMAP_WDT3_SIZE 0x1000
+
 #define OMAP_PRCM_VDD1_DOMAIN 1
 #define OMAP_PRCM_VDD2_DOMAIN 2

diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index ea39efb..b6af751 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -98,6 +98,19 @@ extern void io_dpc(unsigned long pRefData);
  *  Ensures:
  */
 irqreturn_t io_isr(int irq, void *pRefData);
+
+#ifdef CONFIG_BRIDGE_WDT3
+/*
+ *  ========  io_isr_wdt3 ========
+ *  Purpose:
+ *         Main interrupt handler for the WDT overflow.
+ */
+       irqreturn_t io_isr_wdt3(int irq, void *data);
+
+       void dsp_wdt_enable(bool);
+       void dsp_wdt_set_timeout(unsigned);
+#endif
+
 /*
  *  ======== io_request_chnl ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index e494f02..8d33142 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -35,6 +35,23 @@ config BRIDGE_DEBUG
        help
          Say Y to enable Bridge debugging capabilities

+config BRIDGE_WDT3
+       bool "Enable WDT3 interruptions"
+       depends on MPU_BRIDGE
+       default n
+       help
+         WTD3 is managed by DSP and once it is enabled, DSP side bridge is in
+         charge of refreshing the timer before overflow, if the DSP hangs MPU
+         will caught the interrupt and try to recover DSP.
+
+config WDT_TIMEOUT
+       int "DSP watchdog timer timeout (in secs)"
+       depends on BRIDGE_WDT3
+       default 5
+       help
+          Watchdog timer timeout value, after that time if the watchdog timer
+          counter is not reset the wdt overflow interrupt will be triggered
+
 comment "Bridge Notifications"
        depends on MPU_BRIDGE

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 7ac9aac..fd3d3a5 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1048,7 +1048,8 @@ static u32 request_bridge_resources_dsp(u32 dw_context, s32 bRequest)
                    (u32) ioremap(OMAP_CORE_PRM_BASE, OMAP_CORE_PRM_SIZE);
                host_res->dw_dmmu_base =
                    ioremap(OMAP_DMMU_BASE, OMAP_DMMU_SIZE);
-               host_res->dw_wd_timer_dsp_base = NULL;
+               host_res->dw_wd_timer_dsp_base =
+                   ioremap(OMAP_WDT3_BASE, OMAP_WDT3_BASE);

                dev_dbg(bridge, "dw_mem_base[0] 0x%x\n",
                        host_res->dw_mem_base[0]);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index e51e358..5bc7ec7 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1147,7 +1147,7 @@ u32 proc_register_notify(void *hprocessor, u32 event_mask, u32 notify_type,
        if (event_mask &
            ~(DSP_PROCESSORSTATECHANGE | DSP_PROCESSORATTACH |
              DSP_PROCESSORDETACH | DSP_PROCESSORRESTART | DSP_MMUFAULT |
-             DSP_SYSERROR | DSP_PWRERROR))
+             DSP_SYSERROR | DSP_PWRERROR | DSP_WDTOVERFLOW))
                status = DSP_EVALUE;

        /* Check if notify type is valid */
@@ -1158,7 +1158,8 @@ u32 proc_register_notify(void *hprocessor, u32 event_mask, u32 notify_type,
                /* If event mask is not DSP_SYSERROR, DSP_MMUFAULT,
                 * or DSP_PWRERROR then register event immediately. */
                if (event_mask &
-                   ~(DSP_SYSERROR | DSP_MMUFAULT | DSP_PWRERROR)) {
+                   ~(DSP_SYSERROR | DSP_MMUFAULT | DSP_PWRERROR |
+                               DSP_WDTOVERFLOW)) {
                        status =
                            ntfy_register(pProcObject->ntfy_obj, hnotification,
                                          event_mask, notify_type);
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index bf6c49a..696cab5 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -65,8 +65,8 @@ static struct services_clk_t services_clks[] = {
        {NULL, "gpt7_ick", -1},
        {NULL, "gpt8_fck", -1},
        {NULL, "gpt8_ick", -1},
-       {NULL, "wdt_fck", 3},
-       {NULL, "wdt_ick", 3},
+       {NULL, "wdt3_fck", 3},
+       {NULL, "wdt3_ick", 3},
        {NULL, "mcbsp_fck", 1},
        {NULL, "mcbsp_ick", 1},
        {NULL, "mcbsp_fck", 2},
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 7bd6954..6464f19 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -286,6 +286,11 @@ static const struct bpwr_clk_t bpwr_clks[] = {
 #define MBOX_ARM HW_MBOX_U0_ARM
 #define MBOX_DSP HW_MBOX_U1_DSP1

+/* WDT defines */
+#define WDT_SYSCONFIG_OFFSET   0x10
+#define WDT_ISR_OFFSET         0x18
+#define WDT_IER_OFFSET         0x1C
+
 #define ENABLE                          true
 #define DISABLE                         false

@@ -317,6 +322,7 @@ struct wmd_dev_context {
        u32 dw_dsp_ext_base_addr;       /* See the comment above */
        u32 dw_api_reg_base;    /* API mem map'd registers */
        void __iomem *dw_dsp_mmu_base;  /* DSP MMU Mapped registers */
+       void __iomem *wdt3_base;                /* WDT3 mapped registers */
        u32 dw_mail_box_base;   /* Mail box mapped registers */
        u32 dw_api_clk_base;    /* CLK Registers */
        u32 dw_dsp_clk_m2_base; /* DSP Clock Module m2 */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 6991e01..ce374d0 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -124,6 +124,9 @@ struct io_mgr {
        u32 dpc_req;            /* Number of requested DPC's. */
        u32 dpc_sched;          /* Number of executed DPC's. */
        struct tasklet_struct dpc_tasklet;
+#ifdef CONFIG_BRIDGE_WDT3
+       struct tasklet_struct wdt3_tasklet;
+#endif
        spinlock_t dpc_lock;

 };
@@ -152,6 +155,10 @@ static struct workqueue_struct *bridge_workqueue;
 void print_dsp_debug_trace(struct io_mgr *hio_mgr);
 #endif

+#ifdef CONFIG_BRIDGE_WDT3
+static void io_wdt3_ovf(unsigned long);
+#endif
+
 /* Bus Addr (cached kernel) */
 static u32 register_shm_segs(struct io_mgr *hio_mgr,
                             struct cod_manager *cod_man, u32 dw_gpp_base_pa);
@@ -244,6 +251,11 @@ u32 bridge_io_create(struct io_mgr **phIOMgr, struct dev_object *hdev_obj,
                /* Create an IO DPC */
                tasklet_init(&pio_mgr->dpc_tasklet, io_dpc, (u32) pio_mgr);

+#ifdef CONFIG_BRIDGE_WDT3
+               tasklet_init(&pio_mgr->wdt3_tasklet, io_wdt3_ovf,
+                                                       (u32)pio_mgr);
+#endif
+
                /* Initialize DPC counters */
                pio_mgr->dpc_req = 0;
                pio_mgr->dpc_sched = 0;
@@ -276,6 +288,19 @@ u32 bridge_io_create(struct io_mgr **phIOMgr, struct dev_object *hdev_obj,
        } else {
                status = CHNL_E_ISR;
        }
+#ifdef CONFIG_BRIDGE_WDT3
+       if (DSP_SUCCEEDED(status)) {
+               if ((request_irq(INT_34XX_WDT3_IRQ, io_isr_wdt3, 0,
+                         "dsp_wdt", (void *)pio_mgr)) != 0)
+                       status = DSP_EFAIL;
+               else
+                       /*
+                        * Disable at this moment, it will be enabled
+                        * when DSP starts
+                        */
+                       disable_irq(INT_34XX_WDT3_IRQ);
+       }
+#endif
 func_end:
        if (DSP_FAILED(status)) {
                /* Cleanup */
@@ -312,6 +337,11 @@ u32 bridge_io_destroy(struct io_mgr *hio_mgr)
                /* Free IO DPC object */
                tasklet_kill(&hio_mgr->dpc_tasklet);

+#ifdef CONFIG_BRIDGE_WDT3
+               free_irq(INT_34XX_WDT3_IRQ, (void *)hio_mgr);
+               tasklet_kill(&hio_mgr->wdt3_tasklet);
+#endif
+
 #ifndef DSP_TRACEBUF_DISABLED
                kfree(hio_mgr->pmsg);
 #endif
@@ -2122,3 +2152,90 @@ void io_sm_init(void)
 {
        /* Do nothing */
 }
+
+#ifdef CONFIG_BRIDGE_WDT3
+/*
+ *  ======== io_wdt3_ovf ========
+ *      Deferred procedure call WDT overflow ISR.  Carries
+ *      out the dispatch of I/O as a non-preemptible event.It can only be
+ *      pre-empted  by an ISR.
+ */
+void io_wdt3_ovf(unsigned long data)
+{
+       struct deh_mgr *deh_mgr;
+       struct io_mgr *io_mgr = (struct io_mgr *)data;
+       dev_get_deh_mgr(io_mgr->hdev_obj, &deh_mgr);
+       if (deh_mgr)
+               bridge_deh_notify(deh_mgr, DSP_WDTOVERFLOW, (u32)io_mgr);
+}
+
+/*
+ *  ======== io_isr_wdt3 ========
+
+ */
+irqreturn_t io_isr_wdt3(int irq, void *data)
+{
+       u32 value;
+       struct io_mgr *io_mgr = (struct io_mgr *)data;
+       pr_err("Enter wtd isr\n");
+       /* The pending interrupt event is cleared when the set status bit is
+        * overwritten by a value of 1 by a write command in the WTDi.WISR
+        * register. Reading the WTDi.WISR register and writing the value
+        * back allows a fast acknowledge interrupt process. */
+       if (clk_get_use_cnt(SERVICESCLK_WDT3_FCK)) {
+               value = __raw_readl(io_mgr->hwmd_context->wdt3_base
+                                                       + WDT_ISR_OFFSET);
+               __raw_writel(value, io_mgr->hwmd_context->wdt3_base
+                                                       + WDT_ISR_OFFSET);
+       }
+       tasklet_schedule(&io_mgr->wdt3_tasklet);
+       return IRQ_HANDLED;
+}
+#endif
+
+#ifdef CONFIG_BRIDGE_WDT3
+/*
+ *  ======== dsp_wdt_config ========
+ *      Enables/disables WDT.
+ */
+void dsp_wdt_enable(bool enable)
+{
+       u32 tmp;
+       static bool wdt_enable;
+       struct wmd_dev_context *dev_ctxt;
+       struct io_mgr *io_mgr;
+
+       if (wdt_enable == enable)
+               return;
+       dev_get_wmd_context(dev_get_first(), &dev_ctxt);
+       dev_get_io_mgr(dev_get_first(), &io_mgr);
+       if (!dev_ctxt || !io_mgr)
+               return;
+       wdt_enable = enable;
+
+       if (enable) {
+               services_clk_enable(SERVICESCLK_WDT3_FCK);
+               services_clk_enable(SERVICESCLK_WDT3_ICK);
+               io_mgr->shared_mem->wdt_setclocks = 1;
+               tmp = __raw_readl(dev_ctxt->wdt3_base + WDT_ISR_OFFSET);
+               __raw_writel(tmp, dev_ctxt->wdt3_base + WDT_ISR_OFFSET);
+               enable_irq(INT_34XX_WDT3_IRQ);
+       } else {
+               disable_irq(INT_34XX_WDT3_IRQ);
+               io_mgr->shared_mem->wdt_setclocks = 0;
+               services_clk_disable(SERVICESCLK_WDT3_ICK);
+               services_clk_disable(SERVICESCLK_WDT3_FCK);
+       }
+}
+
+void dsp_wdt_set_timeout(unsigned timeout)
+{
+       struct io_mgr *io_mgr;
+       dev_get_io_mgr(dev_get_first(), &io_mgr);
+       if (io_mgr && io_mgr->shared_mem != (void *)-1)
+               io_mgr->shared_mem->wdt_overflow = timeout;
+       else
+               pr_err("%s: DSP image not loaded\n", __func__);
+}
+#endif
+
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index d7c3989..8953400 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -712,6 +712,12 @@ static u32 bridge_brd_start(struct wmd_dev_context *hDevContext, u32 dwDSPAddr)
                if (!wait_for_start(dev_context, dw_sync_addr))
                        status = WMD_E_TIMEOUT;

+#ifdef CONFIG_BRIDGE_WDT3
+               /* Setting default WDT timeout  */
+               dsp_wdt_set_timeout(CONFIG_WDT_TIMEOUT);
+               dsp_wdt_enable(true);
+#endif
+
                status = dev_get_io_mgr(dev_context->hdev_obj, &hio_mgr);
                if (DSP_SUCCEEDED(status)) {
                        io_sh_msetting(hio_mgr, SHM_OPPINFO, NULL);
@@ -790,6 +796,10 @@ static u32 bridge_brd_stop(struct wmd_dev_context *hDevContext)

        dev_context->dw_brd_state = BRD_STOPPED;        /* update board state */

+#ifdef CONFIG_BRIDGE_WDT3
+       dsp_wdt_enable(false);
+#endif
+
        /* This is a good place to clear the MMU page tables as well */
        if (dev_context->pt_attrs) {
                pt_attrs = dev_context->pt_attrs;
@@ -1061,6 +1071,9 @@ static u32 bridge_dev_create(struct wmd_dev_context **ppDevContext,
                /* 24xx-Linux MMU address is obtained from the host
                 * resources struct */
                dev_context->dw_dsp_mmu_base = resources.dw_dmmu_base;
+#ifdef CONFIG_BRIDGE_WDT3
+               dev_context->wdt3_base = resources.dw_wd_timer_dsp_base;
+#endif
        }
        if (DSP_SUCCEEDED(status)) {
                dev_context->hdev_obj = hdev_obj;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 68d095d..f81d070 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -125,6 +125,14 @@ u32 handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
                /* Turn off DSP Peripheral clocks and DSP Load monitor timer */
                status = dsp_peripheral_clocks_disable(dev_context, NULL);

+#ifdef CONFIG_BRIDGE_WDT3
+               /*
+                * Disable WDT clocks and ISR on DSP commanded
+                * hibernation.
+                */
+               dsp_wdt_enable(false);
+
+#endif
                if (DSP_SUCCEEDED(status)) {
                        /* Update the Bridger Driver state */
                        dev_context->dw_brd_state = BRD_DSP_HIBERNATION;
@@ -238,6 +246,15 @@ u32 sleep_dsp(struct wmd_dev_context *dev_context, u32 dw_cmd, void *pargs)
                else
                        dev_context->dw_brd_state = BRD_RETENTION;

+
+#ifdef CONFIG_BRIDGE_WDT3
+               /*
+                * Disable WDT clocks and ISR on BSP commanded
+                * hibernation.
+                */
+               dsp_wdt_enable(false);
+
+#endif
                /* Turn off DSP Peripheral clocks  */
                status = dsp_peripheral_clocks_disable(dev_context, NULL);
                if (DSP_FAILED(status)) {
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 16d6595..d3e7ff2 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -20,6 +20,7 @@
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
+#include <dspbridge/io_sm.h>

 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
@@ -114,6 +115,10 @@ u32 chnlsm_interrupt_dsp2(struct wmd_dev_context *dev_context, u16 mb_val)
                /* Restart the peripheral clocks */
                dsp_peripheral_clocks_enable(dev_context, NULL);

+#ifdef CONFIG_BRIDGE_WDT3
+               dsp_wdt_enable(true);
+#endif
+
                /*
                 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
                 *     in CM_AUTOIDLE_PLL_IVA2 register
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index bd00d17..5f1ea43 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -271,6 +271,15 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
                               "= 0x%x\n", dwErrInfo);
                        break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
+#ifdef CONFIG_BRIDGE_WDT3
+               case DSP_WDTOVERFLOW:
+                       deh_mgr_obj->err_info.dw_err_mask = DSP_WDTOVERFLOW;
+                       deh_mgr_obj->err_info.dw_val1 = 0L;
+                       deh_mgr_obj->err_info.dw_val2 = 0L;
+                       deh_mgr_obj->err_info.dw_val3 = 0L;
+                       pr_err("bridge_deh_notify: DSP_WDTOVERFLOW \n ");
+                       break;
+#endif
                default:
                        dev_dbg(bridge, "%s: Unknown Error, err_info = 0x%x\n",
                                __func__, dwErrInfo);
@@ -287,6 +296,13 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
                (void)dsp_peripheral_clocks_disable(dev_context, NULL);
                /* Call DSP Trace Buffer */
                print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
+#ifdef CONFIG_BRIDGE_WDT3
+               /*
+                * Avoid the subsequent WDT if it happens once,
+                * also If MMU fault occurs
+                */
+               dsp_wdt_enable(false);
+#endif

        }
 }
--
1.6.0.4

