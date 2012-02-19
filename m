From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: remove some orphan function declarations.
Date: Sun, 19 Feb 2012 19:06:00 +0530
Message-ID: <4F40FAC0.3010306@ti.com>
References: <20120219022841.8254.86264.stgit@notabene.brown> <20120219022931.8254.29652.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120219022931.8254.29652.stgit@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, "Govindraj \".\" R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 19 February 2012 07:59 AM, NeilBrown wrote:
> commit 2fd149645eb removed omap_uart_can_sleep and omap3_can_sleep,
> but not their declarations.  So remove those now.
>
a small description with the commit id would have been good.


Looks good to me.
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>

thanks.
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>
>  arch/arm/mach-omap2/pm.h                 |    1 -
>  arch/arm/plat-omap/include/plat/serial.h |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index b737b11..6cd954d 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -18,7 +18,6 @@
>  extern void *omap3_secure_ram_storage;
>  extern void omap3_pm_off_mode_enable(int);
>  extern void omap_sram_idle(void);
> -extern int omap3_can_sleep(void);
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
>  extern int omap4_idle_init(void);
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
> index 198d1e6..b073e5f 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -110,7 +110,6 @@ struct omap_board_data;
>  struct omap_uart_port_info;
>  
>  extern void omap_serial_init(void);
> -extern int omap_uart_can_sleep(void);
>  extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
>  extern void omap_serial_init_port(struct omap_board_data *bdata,
>  		struct omap_uart_port_info *platform_data);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

