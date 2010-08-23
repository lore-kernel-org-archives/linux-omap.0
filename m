From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 05/10] [PM-WIP-MMC] OMAP4 hwmod: Updating hwmod data for
      MMC controllers
Date: Mon, 23 Aug 2010 10:00:42 +0200
Message-ID: <4C722AAA.9040905@ti.com>
References: <16128.10.24.255.18.1282335050.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0HWIAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 04:00:48 -0400
In-Reply-To: <16128.10.24.255.18.1282335050.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

Hi Kishore,

On 8/20/2010 10:10 PM, Kadiyala, Kishore wrote:
> Update register offsets and dev attributes for MMC controllers on
> OMAP4
>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   17 +++++++++++++++--
>   1 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index b7268f6..db62b84 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -22,6 +22,7 @@
>
>   #include<plat/omap_hwmod.h>
>   #include<plat/cpu.h>
> +#include<plat/mmc.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -408,8 +409,8 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
>    */
>
>   static struct omap_hwmod_class_sysconfig omap44xx_mmc_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> +	.rev_offs	= 0x02FC,
> +	.sysc_offs	= 0x0110,

You should not use these registers. MMC is one of the few IP that 
contains both legacy and highlander version of the registers, hence the 
_HL prefix for the MMCHS_HL_REV and MMCHS_HL_SYSCONFIG.

I don't know why the legacy registers are still there, but you should 
use the highlander version.

Regards,
Benoit

>   	.syss_offs	= 0x0114,
>   	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
>   			   SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE),
> @@ -424,6 +425,11 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
>   };
>
>   /* mmc1 */
> +
> +static struct mmc_dev_attr mmc1_dev_attr = {
> +	.flags = MMC_INTERNAL_XCVR,
> +};
> +
>   static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
>   	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -478,10 +484,16 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
>   	.masters	= omap44xx_mmc1_masters,
>   	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc1_masters),
> +	.dev_attr	=&mmc1_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* mmc2 */
> +
> +static struct mmc_dev_attr mmc2_dev_attr = {
> +	.flags = MMC_SUPPORTS_EXTERNAL_XCVR,
> +};
> +
>   static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
>   	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -536,6 +548,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc2_slaves),
>   	.masters	= omap44xx_mmc2_masters,
>   	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc2_masters),
> +	.dev_attr	=&mmc2_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>

