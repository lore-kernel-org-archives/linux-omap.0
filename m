From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 07/12] System Control Module context save/restore
Date: Wed, 10 Sep 2008 17:47:43 +0300
Message-ID: <87sks8f46o.fsf@deeprootsystems.com>
References: <61481.192.168.10.89.1220276457.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36522 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbYIJOrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 10:47:52 -0400
Received: by gxk9 with SMTP id 9so13793663gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 10 Sep 2008 07:47:51 -0700 (PDT)
In-Reply-To: <61481.192.168.10.89.1220276457.squirrel@dbdmail.itg.ti.com> (Rajendra Nayak's message of "Mon\, 1 Sep 2008 19\:10\:57 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch adds the System control module context save/restore
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/control.c             |  105 ++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/control.h |   61 +++++++++++++++++
>  2 files changed, 165 insertions(+), 1 deletion(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/control.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/control.c	2008-09-01
> 18:11:34.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/control.c	2008-09-01 18:11:54.000000000
> +0530
> @@ -73,6 +73,8 @@ void omap_ctrl_writel(u32 val, u16 offse
>
>  #define OMAP3430_PRM_RSTST \
>  		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTST)
> +static struct omap3_control_module_regs control_ctx;
> +

I'm not sure what this patch was generated against, but it doesn't
apply against linux-omap.  The PRM_RSTST definition above is not in
linux-omap code.

Kevin

>  /* Clears the scratchpad contents in case of cold boot-
>   called during bootup*/
>  void omap3_clear_scratchpad_contents(void)
> @@ -190,4 +192,107 @@ void omap3_save_scratchpad_contents(void
>  		 &sdrc_block_contents, sizeof(sdrc_block_contents));
>  }
>
> +void omap3_save_control_ctx(void)
> +{
> +	control_ctx.sysconfig = omap_ctrl_readl(OMAP2_CONTROL_SYSCONFIG);
> +	control_ctx.devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> +	control_ctx.mem_dftrw0 = omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW0);
> +	control_ctx.mem_dftrw1 = omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW1);
> +	control_ctx.msuspendmux_0 =
> +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_0);
> +	control_ctx.msuspendmux_1 =
> +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_1);
> +	control_ctx.msuspendmux_2 =
> +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_2);
> +	control_ctx.msuspendmux_3 =
> +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_3);
> +	control_ctx.msuspendmux_4 =
> +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_4);
> +	control_ctx.msuspendmux_5 =
> +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_5);
> +	control_ctx.sec_ctrl = omap_ctrl_readl(OMAP2_CONTROL_SEC_CTRL);
> +	control_ctx.devconf1 = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
> +	control_ctx.csirxfe = omap_ctrl_readl(OMAP343X_CONTROL_CSIRXFE);
> +	control_ctx.iva2_bootaddr =
> +		       omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTADDR);
> +	control_ctx.iva2_bootmod =
> +		       omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTMOD);
> +	control_ctx.debobs_0 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_0);
> +	control_ctx.debobs_1 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_1);
> +	control_ctx.debobs_2 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_2);
> +	control_ctx.debobs_3 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_3);
> +	control_ctx.debobs_4 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_4);
> +	control_ctx.debobs_5 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_5);
> +	control_ctx.debobs_6 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_6);
> +	control_ctx.debobs_7 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_7);
> +	control_ctx.debobs_8 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_8);
> +	control_ctx.prog_io0 = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO0);
> +	control_ctx.prog_io1 = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> +	control_ctx.dss_dpll_spreading =
> +	       omap_ctrl_readl(OMAP343X_CONTROL_DSS_DPLL_SPREADING);
> +	control_ctx.core_dpll_spreading =
> +	       omap_ctrl_readl(OMAP343X_CONTROL_CORE_DPLL_SPREADING);
> +	control_ctx.per_dpll_spreading =
> +	       omap_ctrl_readl(OMAP343X_CONTROL_PER_DPLL_SPREADING);
> +	control_ctx.usbhost_dpll_spreading =
> +	       omap_ctrl_readl(OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
> +	control_ctx.pbias_lite = omap_ctrl_readl(OMAP343X_CONTROL_PBIAS_LITE);
> +	control_ctx.temp_sensor = omap_ctrl_readl(OMAP343X_CONTROL_TEMP_SENSOR);
> +	control_ctx.sramldo4 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO4);
> +	control_ctx.sramldo5 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO5);
> +	control_ctx.csi = omap_ctrl_readl(OMAP343X_CONTROL_CSI);
> +	return;
> +}
> +
> +void omap3_restore_control_ctx(void)
> +{
> +	omap_ctrl_writel(control_ctx.sysconfig, OMAP2_CONTROL_SYSCONFIG);
> +	omap_ctrl_writel(control_ctx.devconf0, OMAP2_CONTROL_DEVCONF0);
> +	omap_ctrl_writel(control_ctx.mem_dftrw0, OMAP343X_CONTROL_MEM_DFTRW0);
> +	omap_ctrl_writel(control_ctx.mem_dftrw1, OMAP343X_CONTROL_MEM_DFTRW1);
> +	omap_ctrl_writel(control_ctx.msuspendmux_0,
> +					       OMAP2_CONTROL_MSUSPENDMUX_0);
> +	omap_ctrl_writel(control_ctx.msuspendmux_1,
> +					       OMAP2_CONTROL_MSUSPENDMUX_1);
> +	omap_ctrl_writel(control_ctx.msuspendmux_2,
> +					       OMAP2_CONTROL_MSUSPENDMUX_2);
> +	omap_ctrl_writel(control_ctx.msuspendmux_3,
> +					       OMAP2_CONTROL_MSUSPENDMUX_3);
> +	omap_ctrl_writel(control_ctx.msuspendmux_4,
> +					       OMAP2_CONTROL_MSUSPENDMUX_4);
> +	omap_ctrl_writel(control_ctx.msuspendmux_5,
> +					       OMAP2_CONTROL_MSUSPENDMUX_5);
> +	omap_ctrl_writel(control_ctx.sec_ctrl, OMAP2_CONTROL_SEC_CTRL);
> +	omap_ctrl_writel(control_ctx.devconf1, OMAP343X_CONTROL_DEVCONF1);
> +	omap_ctrl_writel(control_ctx.csirxfe, OMAP343X_CONTROL_CSIRXFE);
> +	omap_ctrl_writel(control_ctx.iva2_bootaddr,
> +					       OMAP343X_CONTROL_IVA2_BOOTADDR);
> +	omap_ctrl_writel(control_ctx.iva2_bootmod,
> +					       OMAP343X_CONTROL_IVA2_BOOTMOD);
> +	omap_ctrl_writel(control_ctx.debobs_0, OMAP343X_CONTROL_DEBOBS_0);
> +	omap_ctrl_writel(control_ctx.debobs_1, OMAP343X_CONTROL_DEBOBS_1);
> +	omap_ctrl_writel(control_ctx.debobs_2, OMAP343X_CONTROL_DEBOBS_2);
> +	omap_ctrl_writel(control_ctx.debobs_3, OMAP343X_CONTROL_DEBOBS_3);
> +	omap_ctrl_writel(control_ctx.debobs_4, OMAP343X_CONTROL_DEBOBS_4);
> +	omap_ctrl_writel(control_ctx.debobs_5, OMAP343X_CONTROL_DEBOBS_5);
> +	omap_ctrl_writel(control_ctx.debobs_6, OMAP343X_CONTROL_DEBOBS_6);
> +	omap_ctrl_writel(control_ctx.debobs_7, OMAP343X_CONTROL_DEBOBS_7);
> +	omap_ctrl_writel(control_ctx.debobs_8, OMAP343X_CONTROL_DEBOBS_8);
> +	omap_ctrl_writel(control_ctx.prog_io0, OMAP343X_CONTROL_PROG_IO0);
> +	omap_ctrl_writel(control_ctx.prog_io1, OMAP343X_CONTROL_PROG_IO1);
> +	omap_ctrl_writel(control_ctx.dss_dpll_spreading,
> +			       OMAP343X_CONTROL_DSS_DPLL_SPREADING);
> +	omap_ctrl_writel(control_ctx.core_dpll_spreading,
> +			       OMAP343X_CONTROL_CORE_DPLL_SPREADING);
> +	omap_ctrl_writel(control_ctx.per_dpll_spreading,
> +			       OMAP343X_CONTROL_PER_DPLL_SPREADING);
> +	omap_ctrl_writel(control_ctx.usbhost_dpll_spreading,
> +			       OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
> +	omap_ctrl_writel(control_ctx.pbias_lite, OMAP343X_CONTROL_PBIAS_LITE);
> +	omap_ctrl_writel(control_ctx.temp_sensor, OMAP343X_CONTROL_TEMP_SENSOR);
> +	omap_ctrl_writel(control_ctx.sramldo4, OMAP343X_CONTROL_SRAMLDO4);
> +	omap_ctrl_writel(control_ctx.sramldo5, OMAP343X_CONTROL_SRAMLDO5);
> +	omap_ctrl_writel(control_ctx.csi, OMAP343X_CONTROL_CSI);
> +	return;
> +}
>  #endif /* CONFIG_ARCH_OMAP3 */
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/control.h	2008-09-01
> 18:11:53.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h	2008-09-01
> 18:11:54.000000000 +0530
> @@ -151,7 +151,26 @@
>  #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
>  #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
>  #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
> -#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
> +#define OMAP343X_CONTROL_DEBOBS_0      (OMAP2_CONTROL_GENERAL + 0x01B0)
> +#define OMAP343X_CONTROL_DEBOBS_1      (OMAP2_CONTROL_GENERAL + 0x01B4)
> +#define OMAP343X_CONTROL_DEBOBS_2      (OMAP2_CONTROL_GENERAL + 0x01B8)
> +#define OMAP343X_CONTROL_DEBOBS_3      (OMAP2_CONTROL_GENERAL + 0x01BC)
> +#define OMAP343X_CONTROL_DEBOBS_4      (OMAP2_CONTROL_GENERAL + 0x01C0)
> +#define OMAP343X_CONTROL_DEBOBS_5      (OMAP2_CONTROL_GENERAL + 0x01C4)
> +#define OMAP343X_CONTROL_DEBOBS_6      (OMAP2_CONTROL_GENERAL + 0x01C8)
> +#define OMAP343X_CONTROL_DEBOBS_7      (OMAP2_CONTROL_GENERAL + 0x01CC)
> +#define OMAP343X_CONTROL_DEBOBS_8      (OMAP2_CONTROL_GENERAL + 0x01D0)
> +#define OMAP343X_CONTROL_PROG_IO0      (OMAP2_CONTROL_GENERAL + 0x01D4)
> +#define OMAP343X_CONTROL_PROG_IO1      (OMAP2_CONTROL_GENERAL + 0x01D8)
> +#define OMAP343X_CONTROL_DSS_DPLL_SPREADING    (OMAP2_CONTROL_GENERAL + 0x01E0)
> +#define OMAP343X_CONTROL_CORE_DPLL_SPREADING   (OMAP2_CONTROL_GENERAL + 0x01E4)
> +#define OMAP343X_CONTROL_PER_DPLL_SPREADING    (OMAP2_CONTROL_GENERAL + 0x01E8)
> +#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING (OMAP2_CONTROL_GENERAL + 0x01EC)
> +#define OMAP343X_CONTROL_PBIAS_LITE    (OMAP2_CONTROL_GENERAL + 0x02B0)
> +#define OMAP343X_CONTROL_TEMP_SENSOR   (OMAP2_CONTROL_GENERAL + 0x02B4)
> +#define OMAP343X_CONTROL_SRAMLDO4      (OMAP2_CONTROL_GENERAL + 0x02B8)
> +#define OMAP343X_CONTROL_SRAMLDO5      (OMAP2_CONTROL_GENERAL + 0x02C0)
> +#define OMAP343X_CONTROL_CSI           (OMAP2_CONTROL_GENERAL + 0x02C4)
>
>  /*
>   * REVISIT: This list of registers is not comprehensive - there are more
> @@ -211,6 +230,8 @@ extern void omap3_save_scratchpad_conten
>  extern void omap3_clear_scratchpad_contents(void);
>  extern u32 *get_restore_pointer(void);
>  extern u32 context_mem[128];
> +extern void omap3_save_control_ctx(void);
> +extern void omap3_restore_control_ctx(void);
>
>  struct omap3_scratchpad {
>  	u32 boot_config_ptr;
> @@ -271,6 +292,44 @@ struct omap3_scratchpad_sdrc_block {
>  	u32 sdrc_context_addr;
>  };
>
> +struct omap3_control_module_regs {
> +	u32 sysconfig;
> +	u32 devconf0;
> +	u32 mem_dftrw0;
> +	u32 mem_dftrw1;
> +	u32 msuspendmux_0;
> +	u32 msuspendmux_1;
> +	u32 msuspendmux_2;
> +	u32 msuspendmux_3;
> +	u32 msuspendmux_4;
> +	u32 msuspendmux_5;
> +	u32 sec_ctrl;
> +	u32 devconf1;
> +	u32 csirxfe;
> +	u32 iva2_bootaddr;
> +	u32 iva2_bootmod;
> +	u32 debobs_0;
> +	u32 debobs_1;
> +	u32 debobs_2;
> +	u32 debobs_3;
> +	u32 debobs_4;
> +	u32 debobs_5;
> +	u32 debobs_6;
> +	u32 debobs_7;
> +	u32 debobs_8;
> +	u32 prog_io0;
> +	u32 prog_io1;
> +	u32 dss_dpll_spreading;
> +	u32 core_dpll_spreading;
> +	u32 per_dpll_spreading;
> +	u32 usbhost_dpll_spreading;
> +	u32 pbias_lite;
> +	u32 temp_sensor;
> +	u32 sramldo4;
> +	u32 sramldo5;
> +	u32 csi;
> +};
> +
>  #else
>  #define omap_ctrl_base_get()		0
>  #define omap_ctrl_readb(x)		0
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
