From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Added sleep support to UART
Date: Mon, 9 Jun 2008 22:11:05 -0700
Message-ID: <20080610051104.GD23796@atomide.com>
References: <1212490022-5866-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61042 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbYFJFLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 01:11:07 -0400
Content-Disposition: inline
In-Reply-To: <1212490022-5866-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

Sorry for the delay on looking at this, it's looking pretty good in
general. Few more mostly cosmetic comments below.

* Tero Kristo <tero.kristo@nokia.com> [080603 01:53]:
> UART usage (e.g. serial console) now denies sleep for 5 seconds. This
> makes it possible to use serial console when dynamic idle is enabled.
> 
> Also moved code from pm-debug.c to serial.c, and made pm24xx.c use this
> new implementation.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c     |  132 ------------------------------------
>  arch/arm/mach-omap2/pm.h           |    8 --
>  arch/arm/mach-omap2/pm24xx.c       |   53 ++++++++++-----
>  arch/arm/mach-omap2/pm34xx.c       |    5 ++
>  arch/arm/mach-omap2/serial.c       |  118 ++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/common.h |    3 +
>  6 files changed, 162 insertions(+), 157 deletions(-)
> 

<snip>

> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b0fa582..65571f9 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -23,8 +23,47 @@
>  #include <asm/arch/common.h>
>  #include <asm/arch/board.h>
>  
> +#include "prm.h"
> +#include "pm.h"
> +
> +#define SERIAL_AWAKE_TIME 5
> +
>  static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
>  static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
> +static s64 omap_serial_next_sleep;
> +
> +static const u32 omap2_uart_wk_st[OMAP_MAX_NR_PORTS] = {
> +	PM_WKST1, PM_WKST1, OMAP24XX_PM_WKST2
> +};
> +static const u32 omap2_uart_wk_en[OMAP_MAX_NR_PORTS] = {
> +	PM_WKEN1, PM_WKEN1, OMAP24XX_PM_WKEN2
> +};
> +const u32 omap2_uart_wk_bit[OMAP_MAX_NR_PORTS] = {
> +	OMAP24XX_ST_UART1, OMAP24XX_ST_UART2, OMAP24XX_ST_UART3
> +};
> +
> +#if defined(CONFIG_ARCH_OMAP2)
> +static const u32 omap_uart_fclk_mask[OMAP_MAX_NR_PORTS] = {
> +	OMAP24XX_EN_UART1, OMAP24XX_EN_UART2, OMAP24XX_EN_UART3
> +};
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP3)
> +static const u32 omap_uart_fclk_mask[OMAP_MAX_NR_PORTS] = {
> +	OMAP3430_EN_UART1, OMAP3430_EN_UART2, OMAP3430_EN_UART3
> +};

The above should be omap24xx_uart_fclk_mask and omap34xx_uart_fclk_mask.
Otherwise we cannot compile in both 24xx and 34xx into the same kernel.


> +/* UART padconfig registers, these may differ if non-default padconfig
> +   is used */
> +#define CONTROL_PADCONF_UART1_RX 0x48002182
> +#define CONTROL_PADCONF_UART2_RX 0x4800217A
> +#define CONTROL_PADCONF_UART3_RX 0x4800219E
> +#define PADCONF_WAKEUP_ST 0x8000
> +
> +static const u32 omap_uart_padconf[OMAP_MAX_NR_PORTS] = {
> +	CONTROL_PADCONF_UART1_RX, CONTROL_PADCONF_UART2_RX, CONTROL_PADCONF_UART3_RX
> +};
> +#endif

This should be omap34xx_uart_padconf is only used for 34xx. Also, it's
currently not defined for 24xx and breaks build.


>  static struct plat_serial8250_port serial_platform_data[] = {
>  	{
> @@ -83,6 +122,15 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
>  }
>  
> +static void omap_serial_kick(void)
> +{
> +	struct timespec t;
> +
> +	getnstimeofday(&t);
> +	omap_serial_next_sleep = timespec_to_ns(&t) +
> +		(s64)SERIAL_AWAKE_TIME * (s64)1000000000;
> +}
> +
>  void omap_serial_enable_clocks(int enable)
>  {
>  	int i;
> @@ -99,6 +147,71 @@ void omap_serial_enable_clocks(int enable)
>  	}
>  }
>  
> +void omap_serial_fclk_mask(u32 *f1, u32 *f2)
> +{
> +	if (uart_ick[0])
> +		*f1 &= ~omap_uart_fclk_mask[0];
> +	if (uart_ick[1])
> +		*f1 &= ~omap_uart_fclk_mask[1];
> +	if (uart_ick[2])
> +		*f2 &= ~omap_uart_fclk_mask[2];
> +}
> +
> +void omap_serial_check_wakeup(void)
> +{
> +	int i;
> +
> +	if (cpu_is_omap34xx())
> +		for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +			if (!uart_ick[i])
> +				continue;
> +			if (omap_readw(omap_uart_padconf[i]) & PADCONF_WAKEUP_ST)
> +				omap_serial_kick();
> +				return;
> +		}

The formatting for return above looks one tab too much to the right?


> +	if (cpu_is_omap24xx()) {
> +		u32 l;
> +
> +		for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +			if (!uart_ick[i])
> +				continue;
> +			l = prm_read_mod_reg(CORE_MOD, omap2_uart_wk_st[i]);
> +			if (l & omap2_uart_wk_bit[i])
> +				omap_serial_kick();
> +				return;
> +		}
> +	}
> +}

Here too.


> +int omap_serial_can_sleep(void)
> +{
> +	s64 cnt;
> +	int i;
> +	struct timespec t;
> +
> +	struct plat_serial8250_port *p = serial_platform_data;
> +
> +	getnstimeofday(&t);
> +	cnt = timespec_to_ns(&t);
> +
> +	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +		if (!uart_ick[i])
> +			continue;
> +		/* Check if we have data in the transmit buffer */
> +		if ((serial_read_reg(p + i, UART_LSR) & (UART_LSR_TEMT|UART_LSR_THRE))
> +			!= (UART_LSR_TEMT|UART_LSR_THRE)) {
> +				omap_serial_kick();
> +				return 0;
> +		}
> +	}
> +
> +	if (omap_serial_next_sleep - cnt >= 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
>  void __init omap_serial_init(void)
>  {
>  	int i;
> @@ -142,7 +255,12 @@ void __init omap_serial_init(void)
>  			clk_enable(uart_fck[i]);
>  
>  		omap_serial_reset(p);
> +
> +		if (cpu_is_omap24xx())
> +			prm_set_mod_reg_bits(omap2_uart_wk_bit[i], CORE_MOD, omap2_uart_wk_en[i]);
>  	}

How about run the patch through checkpatch.pl, this line looks too long?

Regards,

Tony
