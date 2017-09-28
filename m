From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Thu, 28 Sep 2017 09:38:27 +0100
Message-ID: <20170928083827.GE23750@n2100.armlinux.org.uk>
References: <20170927000355.30597-1-d-gerlach@ti.com>
 <20170927000355.30597-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170927000355.30597-3-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 26, 2017 at 07:03:55PM -0500, Dave Gerlach wrote:
> diff --git a/drivers/memory/emif-asm-offsets.c b/drivers/memory/emif-asm-offsets.c
> new file mode 100644
> index 000000000000..bdb153c9e948
> --- /dev/null
> +++ b/drivers/memory/emif-asm-offsets.c
> @@ -0,0 +1,22 @@
> +/*
> + * TI AM33XX EMIF PM Assembly Offsets
> + *
> + * Copyright (C) 2016-2017 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/ti-emif-sram.h>
> +
> +int main(void)
> +{
> +	ti_emif_offsets();
> +
> +	return 0;
> +}

...

> +#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
> +static inline void ti_emif_offsets(void)
> +{
> +	DEFINE(EMIF_SDCFG_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_sdcfg_val));
> +	DEFINE(EMIF_TIMING1_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_timing1_val));
> +	DEFINE(EMIF_TIMING2_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_timing2_val));
> +	DEFINE(EMIF_TIMING3_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_timing3_val));
> +	DEFINE(EMIF_REF_CTRL_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_ref_ctrl_val));
> +	DEFINE(EMIF_ZQCFG_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_zqcfg_val));
> +	DEFINE(EMIF_PMCR_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_pmcr_val));
> +	DEFINE(EMIF_PMCR_SHDW_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_pmcr_shdw_val));
> +	DEFINE(EMIF_RD_WR_LEVEL_RAMP_CTRL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_rd_wr_level_ramp_ctrl));
> +	DEFINE(EMIF_RD_WR_EXEC_THRESH_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_rd_wr_exec_thresh));
> +	DEFINE(EMIF_COS_CONFIG_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_cos_config));
> +	DEFINE(EMIF_PRIORITY_TO_COS_MAPPING_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_priority_to_cos_mapping));
> +	DEFINE(EMIF_CONNECT_ID_SERV_1_MAP_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_connect_id_serv_1_map));
> +	DEFINE(EMIF_CONNECT_ID_SERV_2_MAP_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_connect_id_serv_2_map));
> +	DEFINE(EMIF_OCP_CONFIG_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_ocp_config_val));
> +	DEFINE(EMIF_LPDDR2_NVM_TIM_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_lpddr2_nvm_tim));
> +	DEFINE(EMIF_LPDDR2_NVM_TIM_SHDW_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_lpddr2_nvm_tim_shdw));
> +	DEFINE(EMIF_DLL_CALIB_CTRL_VAL_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_dll_calib_ctrl_val));
> +	DEFINE(EMIF_DLL_CALIB_CTRL_VAL_SHDW_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_dll_calib_ctrl_val_shdw));
> +	DEFINE(EMIF_DDR_PHY_CTLR_1_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_ddr_phy_ctlr_1));
> +	DEFINE(EMIF_EXT_PHY_CTRL_VALS_OFFSET,
> +	       offsetof(struct emif_regs_amx3, emif_ext_phy_ctrl_vals));
> +	DEFINE(EMIF_REGS_AMX3_SIZE, sizeof(struct emif_regs_amx3));
> +
> +	BLANK();
> +
> +	DEFINE(EMIF_PM_BASE_ADDR_VIRT_OFFSET,
> +	       offsetof(struct ti_emif_pm_data, ti_emif_base_addr_virt));
> +	DEFINE(EMIF_PM_BASE_ADDR_PHYS_OFFSET,
> +	       offsetof(struct ti_emif_pm_data, ti_emif_base_addr_phys));
> +	DEFINE(EMIF_PM_CONFIG_OFFSET,
> +	       offsetof(struct ti_emif_pm_data, ti_emif_sram_config));
> +	DEFINE(EMIF_PM_REGS_VIRT_OFFSET,
> +	       offsetof(struct ti_emif_pm_data, regs_virt));
> +	DEFINE(EMIF_PM_REGS_PHYS_OFFSET,
> +	       offsetof(struct ti_emif_pm_data, regs_phys));
> +	DEFINE(EMIF_PM_DATA_SIZE, sizeof(struct ti_emif_pm_data));
> +
> +	BLANK();
> +
> +	DEFINE(EMIF_PM_SAVE_CONTEXT_OFFSET,
> +	       offsetof(struct ti_emif_pm_functions, save_context));
> +	DEFINE(EMIF_PM_RESTORE_CONTEXT_OFFSET,
> +	       offsetof(struct ti_emif_pm_functions, restore_context));
> +	DEFINE(EMIF_PM_ENTER_SR_OFFSET,
> +	       offsetof(struct ti_emif_pm_functions, enter_sr));
> +	DEFINE(EMIF_PM_EXIT_SR_OFFSET,
> +	       offsetof(struct ti_emif_pm_functions, exit_sr));
> +	DEFINE(EMIF_PM_ABORT_SR_OFFSET,
> +	       offsetof(struct ti_emif_pm_functions, abort_sr));
> +	DEFINE(EMIF_PM_FUNCTIONS_SIZE, sizeof(struct ti_emif_pm_functions));
> +}
> +#else
> +static inline void ti_emif_offsets(void) {}
> +#endif

Any reason the above can't be part of emif-asm-offsets.c ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
