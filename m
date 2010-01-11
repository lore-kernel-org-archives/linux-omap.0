From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 1/6] Regulator: Creating TWL4030 specific file having
 supplies & init data
Date: Mon, 11 Jan 2010 13:35:49 +0200
Message-ID: <4B4B0D15.3000402@compulab.co.il>
References: <1262973463-32492-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:33336 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab0AKLgC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:36:02 -0500
In-Reply-To: <1262973463-32492-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

Anuj Aggarwal wrote:
> A new file for TWL4030/TPS65950 is created which has common supplies
> and regulator init data structures. They will be referenced from the
> various board-evm files depending upon the EVM requirements.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c |  175 ++++++++++++++++++++++
>  1 files changed, 175 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c
> 
> diff --git a/arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c b/arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c
> new file mode 100644
> index 0000000..0b7cd74
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c

[ snip ]

> +/* Regulator initialization data */
> +/* VAUX1 */
> +struct regulator_init_data vaux1_data = {

The reulator_init_data structs are now global, so I think they should
have twl4030_ prefix

> +	.constraints = {
> +		.min_uV			= 2800000,
> +		.max_uV			= 2800000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +};
> +
> +/* VAUX2 */
> +struct regulator_init_data vaux2_data = {
> +	.constraints = {
> +		.min_uV			= 2800000,
> +		.max_uV			= 2800000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +};
> +
> +/* VAUX3 */
> +struct regulator_init_data vaux3_data = {
> +	.constraints = {
> +		.min_uV			= 2800000,
> +		.max_uV			= 2800000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +};
> +
> +/* VAUX4 */
> +struct regulator_init_data vaux4_data = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 1800000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +};
> +
> +/* VMMC1 */
> +struct regulator_init_data vmmc1_data = {
> +	.constraints = {
> +		.min_uV			= 1850000,
> +		.max_uV			= 3150000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &twl4030_vmmc1_supply,
> +};
> +
> +/* VMMC2 */
> +struct regulator_init_data vmmc2_data = {
> +	.constraints = {
> +		.min_uV			= 1850000,
> +		.max_uV			= 1850000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &twl4030_vmmc2_supply,
> +};
> +
> +/* VSIM */
> +struct regulator_init_data vsim_data = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 3000000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &twl4030_vsim_supply,
> +};
> +
> +/* VDAC */
> +struct regulator_init_data vdac_data = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 1800000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &twl4030_vdac_supply,
> +};
> +
> +/* VPLL2 */
> +struct regulator_init_data vpll2_data = {
> +	.constraints = {
> +		.name			= "VDVI",
> +		.min_uV			= 1800000,
> +		.max_uV			= 1800000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &twl4030_vpll2_supply,
> +};
> +


-- 
Sincerely yours,
Mike.
