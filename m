From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: omap_hwmod: Add interface to incorporate module level wakeup
Date: Tue, 17 Apr 2012 15:36:01 -0700
Message-ID: <87obqqrnou.fsf@ti.com>
References: <1334580053-17242-1-git-send-email-govindraj.raja@ti.com>
	<1334580053-17242-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:59038 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752307Ab2DQWgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 18:36:04 -0400
Received: by dajr28 with SMTP id r28so10245228daj.26
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 15:36:02 -0700 (PDT)
In-Reply-To: <1334580053-17242-2-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Mon, 16 Apr 2012 18:10:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
> PM_WKEN1_CORE/PM_WKEN_PER regs. The module level wakeups are enabled by
> default from bootloader, 

Which bootloader?  what board?

We cannot make any assumptions about what bootloader does (or doesn't
do).  

There is also some default init to these PM_WKEN values in prcm_setup_regs()
for OMAP3 as well, which could be removed (at least for the UARTs) when
this is handled by the UART init code.

Kevin


> however the wakeups can be enabled/disabled
> using sysfs entry example for uart:
> echo disabled > /sys/devices/platform/omap/omap_uart.X/power/wakeup
> [X=0,1,2,3]
>
> So expand omap2 prcm structure to incorporate the PM_WKEN reg offset
> and bit mask to control the module level wakeup. This info from hwmod
> data can be used hwmod framework omap_hwmod_enable/disable_wakeup.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    6 ++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 ++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    8 ++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 ++++
>  4 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index a5409ce..676274b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -791,6 +791,8 @@ static struct omap_hwmod omap2420_uart1_hwmod = {
>  			.module_bit = OMAP24XX_EN_UART1_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP24XX_ST_UART1_MASK,
>  		},
>  	},
>  	.slaves		= omap2420_uart1_slaves,
> @@ -816,6 +818,8 @@ static struct omap_hwmod omap2420_uart2_hwmod = {
>  			.module_bit = OMAP24XX_EN_UART2_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP24XX_ST_UART2_MASK,
>  		},
>  	},
>  	.slaves		= omap2420_uart2_slaves,
> @@ -841,6 +845,8 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
>  			.module_bit = OMAP24XX_EN_UART3_SHIFT,
>  			.idlest_reg_id = 2,
>  			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
> +			.module_wakeup_offs = OMAP24XX_PM_WKEN2,
> +			.module_wakeup_bit = OMAP24XX_ST_UART3_MASK,
>  		},
>  	},
>  	.slaves		= omap2420_uart3_slaves,
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index c4f56cb..94d4463 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -864,6 +864,8 @@ static struct omap_hwmod omap2430_uart1_hwmod = {
>  			.module_bit = OMAP24XX_EN_UART1_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP24XX_ST_UART1_MASK,
>  		},
>  	},
>  	.slaves		= omap2430_uart1_slaves,
> @@ -889,6 +891,8 @@ static struct omap_hwmod omap2430_uart2_hwmod = {
>  			.module_bit = OMAP24XX_EN_UART2_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP24XX_ST_UART2_MASK,
>  		},
>  	},
>  	.slaves		= omap2430_uart2_slaves,
> @@ -914,6 +918,8 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
>  			.module_bit = OMAP24XX_EN_UART3_SHIFT,
>  			.idlest_reg_id = 2,
>  			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
> +			.module_wakeup_offs = OMAP24XX_PM_WKEN2,
> +			.module_wakeup_bit = OMAP24XX_ST_UART3_MASK,
>  		},
>  	},
>  	.slaves		= omap2430_uart3_slaves,
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 34b9766d..9ed038d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1248,6 +1248,8 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
>  			.module_bit = OMAP3430_EN_UART1_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP3430_EN_UART1_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP3430_ST_UART1_MASK,
>  		},
>  	},
>  	.slaves		= omap3xxx_uart1_slaves,
> @@ -1273,6 +1275,8 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
>  			.module_bit = OMAP3430_EN_UART2_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP3430_EN_UART2_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP3430_ST_UART2_MASK,
>  		},
>  	},
>  	.slaves		= omap3xxx_uart2_slaves,
> @@ -1298,6 +1302,8 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
>  			.module_bit = OMAP3430_EN_UART3_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP3430_EN_UART3_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP3430_ST_UART3_MASK,
>  		},
>  	},
>  	.slaves		= omap3xxx_uart3_slaves,
> @@ -1334,6 +1340,8 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
>  			.module_bit = OMAP3630_EN_UART4_SHIFT,
>  			.idlest_reg_id = 1,
>  			.idlest_idle_bit = OMAP3630_EN_UART4_SHIFT,
> +			.module_wakeup_offs = PM_WKEN1,
> +			.module_wakeup_bit = OMAP3630_ST_UART4_MASK,
>  		},
>  	},
>  	.slaves		= omap3xxx_uart4_slaves,
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 8070145..5c7711b 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -343,6 +343,8 @@ struct omap_hwmod_class_sysconfig {
>   * @idlest_reg_id: IDLEST register ID (e.g., 3 for CM_IDLEST3)
>   * @idlest_idle_bit: register bit shift for CM_IDLEST slave idle bit
>   * @idlest_stdby_bit: register bit shift for CM_IDLEST master standby bit
> + * @module_wakeup_offs: PRCM register offset for PM_WKEN
> + * @module_wakeup_bit: regiter bit mask for PM_WKEN
>   *
>   * @prcm_reg_id and @module_bit are specific to the AUTOIDLE, WKST,
>   * WKEN, GRPSEL registers.  In an ideal world, no extra information
> @@ -357,6 +359,8 @@ struct omap_hwmod_omap2_prcm {
>  	u8 idlest_reg_id;
>  	u8 idlest_idle_bit;
>  	u8 idlest_stdby_bit;
> +	s16 module_wakeup_offs;
> +	u32 module_wakeup_bit;
>  };
