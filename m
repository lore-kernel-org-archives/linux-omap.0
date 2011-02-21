From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod
 database.
Date: Mon, 21 Feb 2011 15:39:51 +0100
Message-ID: <4D627937.8030309@ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com> <1298295990-1070-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab1BUOjx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 09:39:53 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LEdrXN024515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 08:39:53 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1LEdqam001726
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 08:39:52 -0600 (CST)
In-Reply-To: <1298295990-1070-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "R, Sricharan" <r.sricharan@ti.com>

Hi Sricharan,

On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
> From: sricharan<r.sricharan@ti.com>
>
> Add the error log registers, irqs of the l3 interconnect to the
> hwmod data. The hwmod change is aligned with Benoit Cousson.

The change is almost aligned with Benoit Cousson :-)

The subject should be something like: omap4: hwmod data: Add address 
space and irq in L3 hwmod

There is no errolog data in that patch. The changelog should be updated too.

> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Signed-off-by: sricharan<r.sricharan@ti.com>
> Tested-by: sricharan<r.sricharan@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++++++++++++++++
>   1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index c2806bd..95001d4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -229,11 +229,37 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_1 = {
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> +/* L3 target configuration and error log registers */
> +static struct omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
> +	{ .irq = 9  + OMAP44XX_IRQ_GIC_START },
> +	{ .irq = 10 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_l3_targ_addrs[] = {
> +	{
> +		.pa_start	= 0x44000000,
> +		.pa_end		= 0x44100000,
> +		.flags		= ADDR_TYPE_RT,
> +	},
> +	{
> +		.pa_start	= 0x44800000,
> +		.pa_end		= 0x44900000,
> +		.flags		= ADDR_TYPE_RT,
> +	},
> +	{
> +		.pa_start	= 0x45000000,
> +		.pa_end		= 0x45100000,
> +		.flags		= ADDR_TYPE_RT,

IIRC, we do have one address space per l3_main instance, and we do have 
3 instances and thus 3 hwmods.
So you should potentially duplicate the code below at hwmod structure 
level and not only at address space level.

In that case, you will re-group the 3 instances in only one omap_device.
For the IRQ, in theory we should duplicate the same entry 3 times just 
in case someone want to use only the second instance. But, I'm still not 
convinced this is the right thing to do... so let's keep it only for 
l3_main_1 for the moment.

Regards,
Benoit
