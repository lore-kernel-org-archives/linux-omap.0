From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM-20081106] OMAP3: UART: Make sure that uart clocks are enabled when needed
Date: Wed, 12 Nov 2008 12:55:59 -0800
Message-ID: <87myg4ll40.fsf@deeprootsystems.com>
References: <87od0ldw9c.fsf@trdhcp146196.ntc.nokia.com>
	<1226489259-1018-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:44463 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbYKLU4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 15:56:08 -0500
Received: by nf-out-0910.google.com with SMTP id d3so309684nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 12:56:05 -0800 (PST)
In-Reply-To: <1226489259-1018-1-git-send-email-jouni.hogander@nokia.com> (Jouni Hogander's message of "Wed\, 12 Nov 2008 13\:27\:39 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Jouni Hogander <jouni.hogander@nokia.com> writes:

> Current implementation makes it possible that printouts are
> written into UART while its clocks are disabled. This causes freeze.
>
> This patch contains possible fix for this.

Thanks, pulling into PM branch until final solution can be found.

Kevin

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c             |    6 ++++++
>  arch/arm/mach-omap2/serial.c             |   30 ++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/serial.h |    2 ++
>  3 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index d480c39..3838a19 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -320,6 +320,7 @@ void omap_sram_idle(void)
>  	/* PER */
>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>  	if (per_next_state < PWRDM_POWER_ON) {
> +		omap_uart_prepare_idle(2);
>  		omap2_gpio_prepare_for_retention();
>  		if (per_next_state == PWRDM_POWER_OFF)
>  			omap3_per_save_context();
> @@ -328,6 +329,8 @@ void omap_sram_idle(void)
>  	/* CORE */
>  	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>  	if (core_next_state < PWRDM_POWER_ON) {
> +		omap_uart_prepare_idle(0);
> +		omap_uart_prepare_idle(1);
>  		if (core_next_state == PWRDM_POWER_OFF) {
>  			prm_set_mod_reg_bits(OMAP3430_AUTO_OFF,
>  					     OMAP3430_GR_MOD,
> @@ -386,6 +389,8 @@ void omap_sram_idle(void)
>  			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>  					       OMAP3430_GR_MOD,
>  					       OMAP3_PRM_VOLTCTRL_OFFSET);
> +		omap_uart_resume_idle(0);
> +		omap_uart_resume_idle(1);
>  	}
>  
>  	/* PER */
> @@ -394,6 +399,7 @@ void omap_sram_idle(void)
>  		if (per_prev_state == PWRDM_POWER_OFF)
>  			omap3_per_restore_context();
>  		omap2_gpio_resume_after_retention();
> +		omap_uart_resume_idle(2);
>  	}
>  
>  	/* Enable smartreflex after WFI */
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 65cce87..ef30d8d 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -249,6 +249,36 @@ static void omap_uart_idle_timer(unsigned long data)
>  	omap_uart_allow_sleep(uart);
>  }
>  
> +void omap_uart_prepare_idle(int num)
> +{
> +	struct omap_uart_state *uart;
> +
> +	if (!clocks_off_while_idle)
> +		return;
> +
> +	list_for_each_entry(uart, &uart_list, node) {
> +		if (num == uart->num && uart->can_sleep) {
> +			omap_uart_disable_clocks(uart);
> +			return;
> +		}
> +	}
> +}
> +
> +void omap_uart_resume_idle(int num)
> +{
> +	struct omap_uart_state *uart;
> +
> +	if (!clocks_off_while_idle)
> +		return;
> +
> +	list_for_each_entry(uart, &uart_list, node) {
> +		if (num == uart->num) {
> +			omap_uart_enable_clocks(uart);
> +			return;
> +		}
> +	}
> +}
> +
>  void omap_uart_check_wakeup(void)
>  {
>  	struct omap_uart_state *uart;
> diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
> index 11ff540..254a775 100644
> --- a/arch/arm/plat-omap/include/mach/serial.h
> +++ b/arch/arm/plat-omap/include/mach/serial.h
> @@ -44,6 +44,8 @@
>  extern void omap_serial_init(void);
>  extern int omap_uart_can_sleep(void);
>  extern void omap_uart_check_wakeup(void);
> +extern void omap_uart_prepare_idle(int num);
> +extern void omap_uart_resume_idle(int num);
>  #endif
>  
>  #endif
> -- 
> 1.6.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
