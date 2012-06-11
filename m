From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
Date: Mon, 11 Jun 2012 16:43:02 -0500
Message-ID: <4FD66666.8060002@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45794 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab2FKVnH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 17:43:07 -0400
In-Reply-To: <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 06/11/2012 09:26 AM, Afzal Mohammed wrote:
> Helper for configuring given CS based on flags.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |   33 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/gpmc.h |    5 +++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 652b245..4e19010 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -927,6 +927,39 @@ static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
>  	return 1;
>  }
>  
> +static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
> +{
> +	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);

Why is it necessary to read the register first? I thought you wanted to
get away from relying on bootloader settings?

> +	l &= ~(GPMC_CONFIG1_MUXADDDATA |
> +		GPMC_CONFIG1_WRITETYPE_SYNC |
> +		GPMC_CONFIG1_WRITEMULTIPLE_SUPP |
> +		GPMC_CONFIG1_READTYPE_SYNC |
> +		GPMC_CONFIG1_READMULTIPLE_SUPP |
> +		GPMC_CONFIG1_WRAPBURST_SUPP |
> +		GPMC_CONFIG1_DEVICETYPE(~0) |
> +		GPMC_CONFIG1_DEVICESIZE(~0) |
> +		GPMC_CONFIG1_PAGE_LEN(~0));
> +
> +	l |= conf & GPMC_CONFIG1_DEVICETYPE_NAND;
> +	l |= conf & GPMC_CONFIG1_DEVICESIZE_16;

I can see that it works to use the above definitions as masks because of
the possible values that can be programmed into these fields. However,
from a read-ability standpoint this is unclear and requires people to
review the documentation to understand what you are doing here.
Furthermore, if any new device-types or sizes were added in the future
this could lead to bugs. Hence, it would be better to define a mask for
these fields.

Now you may say what happens if someone pass a bad device-type or
device-size that would equate to a reserved value being programmed. Well
if someone passes a bad value we don't know what they intended to
program and that raises the question should we be checking the conf
value of bad device types, size, and page lengths here?

Jon
