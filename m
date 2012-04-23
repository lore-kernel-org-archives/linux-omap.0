From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: Update AESS data with memory
 bank area
Date: Mon, 23 Apr 2012 22:34:29 +0200
Message-ID: <4F95BCD5.3060501@ti.com>
References: <1335212747-8006-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46709 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab2DWUei (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 16:34:38 -0400
In-Reply-To: <1335212747-8006-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

+ lakml and Paul

On 4/23/2012 10:25 PM, Sebastien Guiriec wrote:
> Add AESS memory bank data in hwmod in order to provide memory
> address information to the driver. AESS is divided inside 5
> memory banks than can be accessed directly by MPU or by L3.
> - PMEM: Program memory bank.
> - SMEM: Sample memory bank.
> - CMEM: Coefficients memory bank
> - DMEM: Data memory bank.
> - MPU/DMA: Register of AESS IP.
>
> Signed-off-by: Sebastien Guiriec<s-guiriec@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks Seb, I'll take it for my WIP cleanup branch.

Regards,
Benoit

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   42 ++++++++++++++++++++++++++++
>   1 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 4906129..b0d333a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3999,6 +3999,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
>
>   static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
>   	{
> +		.name		= "dmem",
> +		.pa_start	= 0x40180000,
> +		.pa_end		= 0x4018ffff
> +	},
> +	{
> +		.name		= "cmem",
> +		.pa_start	= 0x401a0000,
> +		.pa_end		= 0x401a1fff
> +	},
> +	{
> +		.name		= "smem",
> +		.pa_start	= 0x401c0000,
> +		.pa_end		= 0x401c5fff
> +	},
> +	{
> +		.name		= "pmem",
> +		.pa_start	= 0x401e0000,
> +		.pa_end		= 0x401e1fff
> +	},
> +	{
> +		.name		= "mpu",
>   		.pa_start	= 0x401f1000,
>   		.pa_end		= 0x401f13ff,
>   		.flags		= ADDR_TYPE_RT
> @@ -4017,6 +4038,27 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess = {
>
>   static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
>   	{
> +		.name		= "dmem_dma",
> +		.pa_start	= 0x49080000,
> +		.pa_end		= 0x4908ffff
> +	},
> +	{
> +		.name		= "cmem_dma",
> +		.pa_start	= 0x490a0000,
> +		.pa_end		= 0x490a1fff
> +	},
> +	{
> +		.name		= "smem_dma",
> +		.pa_start	= 0x490c0000,
> +		.pa_end		= 0x490c5fff
> +	},
> +	{
> +		.name		= "pmem_dma",
> +		.pa_start	= 0x490e0000,
> +		.pa_end		= 0x490e1fff
> +	},
> +	{
> +		.name		= "dma",
>   		.pa_start	= 0x490f1000,
>   		.pa_end		= 0x490f13ff,
>   		.flags		= ADDR_TYPE_RT

