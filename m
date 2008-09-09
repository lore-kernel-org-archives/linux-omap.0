From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 09/12] CORE OFF support in omap_sram_idle
Date: Tue, 09 Sep 2008 08:46:27 +0300
Message-ID: <87ej3tq3bg.fsf@trdhcp146196.ntc.nokia.com>
References: <62493.192.168.10.89.1220276508.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42148 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbYIIFpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 01:45:52 -0400
In-Reply-To: <62493.192.168.10.89.1220276508.squirrel@dbdmail.itg.ti.com> (ext
	Rajendra Nayak's message of "Mon, 1 Sep 2008 19:11:48 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra, one more comment from me...

"ext Rajendra Nayak" <rnayak@ti.com> writes:

>  struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-01
> 18:23:19.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-01 18:24:02.0=
00000000
> +0530
> @@ -27,10 +27,13 @@
>  #include <mach/gpio.h>
>  #include <mach/sram.h>
>  #include <mach/pm.h>
> +#include <mach/prcm.h>
>  #include <mach/clockdomain.h>
>  #include <mach/powerdomain.h>
>  #include <mach/common.h>
>  #include <mach/control.h>
> +#include <mach/serial.h>
> +#include <mach/gpio.h>
>  #include <asm/tlbflush.h>
>
>  #include "cm.h"
> @@ -58,6 +61,7 @@ static struct powerdomain *mpu_pwrdm, *n
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>
>  int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
> +void omap3_restore_sram_ctx(void);
>
>  u32 context_mem[128];
>
> @@ -91,6 +95,16 @@ static void gpio_fclk_mask(u32 *fclk)
>  	*fclk &=3D ~(0x1f << 13);
>  }
>
> +void omap3_save_per_ctx(void)
> +{
> +	omap3_gpio_save();
> +}
> +
> +void omap3_restore_per_ctx(void)
> +{
> +	omap3_gpio_restore();
> +}
> +
>  /* PRCM Interrupt Handler for wakeups */
>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  {
> @@ -225,6 +239,7 @@ void omap_sram_idle(void)
>  	int mpu_next_state =3D PWRDM_POWER_ON;
>  	int per_next_state =3D PWRDM_POWER_ON;
>  	int core_next_state =3D PWRDM_POWER_ON;
> +	int core_prev_state, per_prev_state;
>
>  	if (!_omap_sram_idle)
>  		return;
> @@ -261,15 +276,27 @@ void omap_sram_idle(void)
>  		/* PER changes only with core */
>  		per_next_state =3D pwrdm_read_next_pwrst(per_pwrdm);
>  		if (per_next_state < PWRDM_POWER_ON) {
> +			if (per_next_state =3D=3D PWRDM_POWER_OFF) {
> +				omap3_save_per_ctx();
> +				omap3_save_uart_ctx(2);
> +			}
>  			if (clocks_off_while_idle) {
>  				per_gpio_clk_disable();
>  				omap_serial_enable_clocks(0, 2);
>  			}
>  		}
> +		if (core_next_state =3D=3D PWRDM_POWER_OFF) {
> +			omap3_save_core_ctx();
> +			omap3_save_prcm_ctx();

Prcm is saved twice, once here...

> +			omap3_save_uart_ctx(0);
> +			omap3_save_uart_ctx(1);
> +		}
>  		if (clocks_off_while_idle) {
>  			omap_serial_enable_clocks(0, 0);
>  			omap_serial_enable_clocks(0, 1);
>  		}
> +		if (core_next_state =3D=3D PWRDM_POWER_OFF)
> +			omap3_save_prcm_ctx();

And then again here.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
