From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Mon, 2 Oct 2017 10:34:18 -0500
Message-ID: <0bbba52e-c7d8-647e-9b58-55cbbe236d4a@ti.com>
References: <20170927000355.30597-1-d-gerlach@ti.com>
 <20170927000355.30597-3-d-gerlach@ti.com>
 <20170928083827.GE23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170928083827.GE23750-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Russell,
On 09/28/2017 03:38 AM, Russell King - ARM Linux wrote:
> On Tue, Sep 26, 2017 at 07:03:55PM -0500, Dave Gerlach wrote:
>> diff --git a/drivers/memory/emif-asm-offsets.c b/drivers/memory/emif-asm-offsets.c
>> new file mode 100644
>> index 000000000000..bdb153c9e948
>> --- /dev/null
>> +++ b/drivers/memory/emif-asm-offsets.c
>> @@ -0,0 +1,22 @@
>> +/*
>> + * TI AM33XX EMIF PM Assembly Offsets
>> + *
>> + * Copyright (C) 2016-2017 Texas Instruments Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include <linux/ti-emif-sram.h>
>> +
>> +int main(void)
>> +{
>> +	ti_emif_offsets();
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
>> +static inline void ti_emif_offsets(void)
>> +{
>> +	DEFINE(EMIF_SDCFG_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_sdcfg_val));
>> +	DEFINE(EMIF_TIMING1_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_timing1_val));
>> +	DEFINE(EMIF_TIMING2_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_timing2_val));
>> +	DEFINE(EMIF_TIMING3_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_timing3_val));
>> +	DEFINE(EMIF_REF_CTRL_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_ref_ctrl_val));
>> +	DEFINE(EMIF_ZQCFG_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_zqcfg_val));
>> +	DEFINE(EMIF_PMCR_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_pmcr_val));
>> +	DEFINE(EMIF_PMCR_SHDW_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_pmcr_shdw_val));
>> +	DEFINE(EMIF_RD_WR_LEVEL_RAMP_CTRL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_rd_wr_level_ramp_ctrl));
>> +	DEFINE(EMIF_RD_WR_EXEC_THRESH_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_rd_wr_exec_thresh));
>> +	DEFINE(EMIF_COS_CONFIG_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_cos_config));
>> +	DEFINE(EMIF_PRIORITY_TO_COS_MAPPING_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_priority_to_cos_mapping));
>> +	DEFINE(EMIF_CONNECT_ID_SERV_1_MAP_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_connect_id_serv_1_map));
>> +	DEFINE(EMIF_CONNECT_ID_SERV_2_MAP_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_connect_id_serv_2_map));
>> +	DEFINE(EMIF_OCP_CONFIG_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_ocp_config_val));
>> +	DEFINE(EMIF_LPDDR2_NVM_TIM_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_lpddr2_nvm_tim));
>> +	DEFINE(EMIF_LPDDR2_NVM_TIM_SHDW_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_lpddr2_nvm_tim_shdw));
>> +	DEFINE(EMIF_DLL_CALIB_CTRL_VAL_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_dll_calib_ctrl_val));
>> +	DEFINE(EMIF_DLL_CALIB_CTRL_VAL_SHDW_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_dll_calib_ctrl_val_shdw));
>> +	DEFINE(EMIF_DDR_PHY_CTLR_1_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_ddr_phy_ctlr_1));
>> +	DEFINE(EMIF_EXT_PHY_CTRL_VALS_OFFSET,
>> +	       offsetof(struct emif_regs_amx3, emif_ext_phy_ctrl_vals));
>> +	DEFINE(EMIF_REGS_AMX3_SIZE, sizeof(struct emif_regs_amx3));
>> +
>> +	BLANK();
>> +
>> +	DEFINE(EMIF_PM_BASE_ADDR_VIRT_OFFSET,
>> +	       offsetof(struct ti_emif_pm_data, ti_emif_base_addr_virt));
>> +	DEFINE(EMIF_PM_BASE_ADDR_PHYS_OFFSET,
>> +	       offsetof(struct ti_emif_pm_data, ti_emif_base_addr_phys));
>> +	DEFINE(EMIF_PM_CONFIG_OFFSET,
>> +	       offsetof(struct ti_emif_pm_data, ti_emif_sram_config));
>> +	DEFINE(EMIF_PM_REGS_VIRT_OFFSET,
>> +	       offsetof(struct ti_emif_pm_data, regs_virt));
>> +	DEFINE(EMIF_PM_REGS_PHYS_OFFSET,
>> +	       offsetof(struct ti_emif_pm_data, regs_phys));
>> +	DEFINE(EMIF_PM_DATA_SIZE, sizeof(struct ti_emif_pm_data));
>> +
>> +	BLANK();
>> +
>> +	DEFINE(EMIF_PM_SAVE_CONTEXT_OFFSET,
>> +	       offsetof(struct ti_emif_pm_functions, save_context));
>> +	DEFINE(EMIF_PM_RESTORE_CONTEXT_OFFSET,
>> +	       offsetof(struct ti_emif_pm_functions, restore_context));
>> +	DEFINE(EMIF_PM_ENTER_SR_OFFSET,
>> +	       offsetof(struct ti_emif_pm_functions, enter_sr));
>> +	DEFINE(EMIF_PM_EXIT_SR_OFFSET,
>> +	       offsetof(struct ti_emif_pm_functions, exit_sr));
>> +	DEFINE(EMIF_PM_ABORT_SR_OFFSET,
>> +	       offsetof(struct ti_emif_pm_functions, abort_sr));
>> +	DEFINE(EMIF_PM_FUNCTIONS_SIZE, sizeof(struct ti_emif_pm_functions));
>> +}
>> +#else
>> +static inline void ti_emif_offsets(void) {}
>> +#endif
> 
> Any reason the above can't be part of emif-asm-offsets.c ?
> 

Yes that's a good point. I was focused on moving the macros and didn't think
about why I hid everything away in the header in the first place, to avoid
cluttering the global asm-offsets.c. Now that we have our own file there's no
reason for this, I will fix this and the kbuild robot issue and send v5. I can
simplify the makefile more which will avoid that build error.

Regards,
Dave
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
