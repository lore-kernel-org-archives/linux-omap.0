From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for 3630
Date: Fri, 04 Jun 2010 08:35:31 -0700
Message-ID: <871vcmq08s.fsf@deeprootsystems.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:40674 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0FDPfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 11:35:34 -0400
Received: by pxi8 with SMTP id 8so327955pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Jun 2010 08:35:34 -0700 (PDT)
In-Reply-To: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Fri\, 4 Jun 2010 19\:13\:43 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> This patch makes the following:
>  - Adds missing wakeup padding register handling.
>  - Fixes a hardcode to use PER module ONLY on UART3.
>  - Muxmode usage needed for uart4 for 3630 for padconf
>    wakeup on rx line.

The need for this muxmode needs to be better described.

The usage of the new set muxmode function is not terribly clear.
You're calling it in both _enable_wakeup() and _disable_wakeup() and
in _resume_idle(), but it's not terribly clear (to me, or the casual
changelog reader) why this is being done.

> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   30 +++++++++++++++++++++++++++++-
>  1 files changed, 29 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index da9fee6..70a9089 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -42,6 +42,7 @@
>  #include "prm.h"
>  #include "pm.h"
>  #include "cm.h"
> +#include "mux.h"
>  #include "prm-regbits-34xx.h"
>
>  #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
> @@ -68,6 +69,7 @@ struct omap_uart_state {
>  	u32 wk_mask;
>  	u32 padconf;
>  	u32 dma_enabled;
> +	u16 muxmode;
>
>  	struct clk *ick;
>  	struct clk *fck;
> @@ -229,8 +231,20 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
>  	omap_device_idle(uart->pdev);
>  }
>
> +static inline void omap_uart_setmux_mode(struct omap_uart_state *uart)

How about _set_muxmode()

> +{
> +	u16 w = omap_ctrl_readw(uart->padconf);

insert blank line

> +	w &= ~0x7;
> +	w |= OMAP_MUX_MODE2;
> +	omap_ctrl_writew(w, uart->padconf);
> +}
> +
>  static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
>  {
> +	/* Set appropriate muxmode */

you can drop these comments, as it doesn't add anything that the code
doesn't already say.

> +	if (uart->muxmode && uart->padconf)
> +		omap_uart_setmux_mode(uart);
> +
>  	/* Set wake-enable bit */
>  	if (uart->wk_en && uart->wk_mask) {
>  		u32 v = __raw_readl(uart->wk_en);
> @@ -248,6 +262,10 @@ static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
>
>  static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
>  {
> +	/* Set appropriate muxmode */
> +	if (uart->muxmode && uart->padconf)
> +		omap_uart_setmux_mode(uart);
> +
>  	/* Clear wake-enable bit */
>  	if (uart->wk_en && uart->wk_mask) {
>  		u32 v = __raw_readl(uart->wk_en);
> @@ -338,6 +356,9 @@ void omap_uart_resume_idle(int num)
>  		if (num == uart->num) {
>  			omap_uart_enable_clocks(uart);
>
> +			if (uart->muxmode && uart->padconf)
> +				omap_uart_setmux_mode(uart);
> +
>  			/* Check for IO pad wakeup */
>  			if (cpu_is_omap34xx() && uart->padconf) {
>  				u16 p = omap_ctrl_readw(uart->padconf);
> @@ -416,9 +437,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	omap_uart_smart_idle_enable(uart, 0);
>
>  	if (cpu_is_omap34xx()) {
> -		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
> +		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
>  		u32 wk_mask = 0;
>  		u32 padconf = 0;
> +		u16 muxmode = 0;
>
>  		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
>  		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
> @@ -435,9 +457,15 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  			wk_mask = OMAP3430_ST_UART3_MASK;
>  			padconf = 0x19e;
>  			break;
> +		case 3:
> +			wk_mask = OMAP3630_ST_UART4_MASK;
> +			padconf = 0x0d2;
> +			muxmode = OMAP_MUX_MODE2;
> +			break;
>  		}
>  		uart->wk_mask = wk_mask;
>  		uart->padconf = padconf;
> +		uart->muxmode = muxmode;
>  	} else if (cpu_is_omap24xx()) {
>  		u32 wk_mask = 0;

Kevin
