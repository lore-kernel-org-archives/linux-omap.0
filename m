From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 3/3] OMAP: UART: use atomic idle notifiers
Date: Fri, 22 Oct 2010 18:24:29 +0530
Message-ID: <AANLkTinYhNAYpehKEshPz89uqcKy9K9hB2Q+a7N+EveJ@mail.gmail.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
	<1287617483-24170-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61465 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328Ab0JVMyb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 08:54:31 -0400
Received: by ewy7 with SMTP id 7so1003952ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 05:54:29 -0700 (PDT)
In-Reply-To: <1287617483-24170-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Thanks Kevin,

works fine tested on 3630sdp/zoom3 board.

Tested-by: Govindraj.R <govindraj.raja@ti.com>

Regards,
Govindraj.R

On Thu, Oct 21, 2010 at 5:01 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Convert UART idle management routines from custom hooks in the core
> idle path to use new idle notifiers.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +-=
--
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 --=
-
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 71 ++++=
+++++++++++++++----------
> =A0arch/arm/plat-omap/include/plat/serial.h | =A0 =A02 -
> =A04 files changed, 47 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24x=
x.c
> index cb1b333..47644d2 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -40,6 +40,7 @@
> =A0#include <plat/sram.h>
> =A0#include <plat/dma.h>
> =A0#include <plat/board.h>
> +#include <plat/common.h>
>
> =A0#include "prm.h"
> =A0#include "prm-regbits-24xx.h"
> @@ -120,19 +121,11 @@ static void omap2_enter_full_retention(void)
> =A0 =A0 =A0 =A0if (omap_irq_pending())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto no_sleep;
>
> - =A0 =A0 =A0 omap_uart_prepare_idle(0);
> - =A0 =A0 =A0 omap_uart_prepare_idle(1);
> - =A0 =A0 =A0 omap_uart_prepare_idle(2);
> -
> =A0 =A0 =A0 =A0/* Jump to SRAM suspend code */
> =A0 =A0 =A0 =A0omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_SDRC_REGADDR=
(SDRC_DLLA_CTRL),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_SDRC_REGADDR=
(SDRC_POWER));
>
> - =A0 =A0 =A0 omap_uart_resume_idle(2);
> - =A0 =A0 =A0 omap_uart_resume_idle(1);
> - =A0 =A0 =A0 omap_uart_resume_idle(0);
> -
> =A0no_sleep:
> =A0 =A0 =A0 =A0if (omap2_pm_debug) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long long tmp;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 4674748..eaed95d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -390,8 +390,6 @@ void omap_sram_idle(void)
>
> =A0 =A0 =A0 =A0/* PER */
> =A0 =A0 =A0 =A0if (per_next_state < PWRDM_POWER_ON) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_gpio_prepare_for_idle(per_next_s=
tate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (per_next_state =3D=3D PWRDM_POWER_=
OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_=
per_save_context();
> @@ -399,8 +397,6 @@ void omap_sram_idle(void)
>
> =A0 =A0 =A0 =A0/* CORE */
> =A0 =A0 =A0 =A0if (core_next_state < PWRDM_POWER_ON) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (core_next_state =3D=3D PWRDM_POWER=
_OFF) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_core_save_contex=
t();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_prcm_save_contex=
t();
> @@ -445,8 +441,6 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_sram_restore_con=
text();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_sms_restore_cont=
ext();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (core_next_state =3D=3D PWRDM_POWER=
_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prm_clear_mod_reg_bits=
(OMAP3430_AUTO_OFF_MASK,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD,
> @@ -459,8 +453,6 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_gpio_resume_after_idle();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (per_prev_state =3D=3D PWRDM_POWER_=
OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_per_restore_cont=
ext();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(3);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Disable IO-PAD and IO-CHAIN wakeup */
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index becf0e3..8a619ff 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -73,6 +73,7 @@ struct omap_uart_state {
> =A0 =A0 =A0 =A0u32 padconf;
> =A0 =A0 =A0 =A0u32 dma_enabled;
>
> + =A0 =A0 =A0 struct powerdomain *pwrdm;
> =A0 =A0 =A0 =A0struct clk *ick;
> =A0 =A0 =A0 =A0struct clk *fck;
> =A0 =A0 =A0 =A0int clocked;
> @@ -389,39 +390,31 @@ static void omap_uart_idle_timer(unsigned long =
data)
> =A0 =A0 =A0 =A0omap_uart_allow_sleep(uart);
> =A0}
>
> -void omap_uart_prepare_idle(int num)
> +static void omap_uart_prepare_idle(struct omap_uart_state *uart)
> =A0{
> - =A0 =A0 =A0 struct omap_uart_state *uart;
> -
> - =A0 =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (num =3D=3D uart->num && uart->can_s=
leep) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_disable_clock=
s(uart);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (uart->can_sleep &&
> + =A0 =A0 =A0 =A0 =A0 pwrdm_read_next_pwrst(uart->pwrdm) < PWRDM_POWE=
R_ON)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_disable_clocks(uart);
> =A0}
>
> -void omap_uart_resume_idle(int num)
> +static void omap_uart_resume_idle(struct omap_uart_state *uart)
> =A0{
> - =A0 =A0 =A0 struct omap_uart_state *uart;
> + =A0 =A0 =A0 if (uart->can_sleep &&
> + =A0 =A0 =A0 =A0 =A0 pwrdm_read_next_pwrst(uart->pwrdm) < PWRDM_POWE=
R_ON) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_enable_clocks(uart);
>
> - =A0 =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (num =3D=3D uart->num) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_enable_clocks=
(uart);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for IO pad wak=
eup */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx() &=
& uart->padconf) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 p =3D=
 omap_ctrl_readw(uart->padconf);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p &=
 OMAP3_PADCONF_WAKEUPEVENT0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap_uart_block_sleep(uart);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for IO pad wakeup */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx() && uart->padconf)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 p =3D omap_ctrl_rea=
dw(uart->padconf);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for normal UAR=
T wakeup */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__raw_readl(uart->w=
k_st) & uart->wk_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p & OMAP3_PADCONF_W=
AKEUPEVENT0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_u=
art_block_sleep(uart);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for normal UART wakeup */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__raw_readl(uart->wk_st) & uart->wk=
_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_block_sleep(u=
art);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -474,6 +467,27 @@ static irqreturn_t omap_uart_interrupt(int irq, =
void *dev_id)
> =A0 =A0 =A0 =A0return IRQ_NONE;
> =A0}
>
> +static int omap_uart_idle_notifier(struct notifier_block *n,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned long val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
void *p)
> +{
> + =A0 =A0 =A0 struct omap_uart_state *uart;
> +
> + =A0 =A0 =A0 if (val =3D=3D OMAP_IDLE_START)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(uart, &uart_list, n=
ode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(=
uart);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(uart, &uart_list, n=
ode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(u=
art);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static bool omap_uart_notifier_enabled;
> +static struct notifier_block omap_uart_notifier =3D {
> + =A0 =A0 =A0 .notifier_call =3D omap_uart_idle_notifier,
> +};
> +
> =A0static void omap_uart_idle_init(struct omap_uart_state *uart)
> =A0{
> =A0 =A0 =A0 =A0int ret;
> @@ -549,6 +563,11 @@ static void omap_uart_idle_init(struct omap_uart=
_state *uart)
> =A0 =A0 =A0 =A0ret =3D request_threaded_irq(uart->irq, NULL, omap_uar=
t_interrupt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I=
RQF_SHARED, "serial idle", (void *)uart);
> =A0 =A0 =A0 =A0WARN_ON(ret);
> +
> + =A0 =A0 =A0 if (!omap_uart_notifier_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_idle_notifier_register(&omap_uart_=
notifier);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_notifier_enabled =3D true;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0void omap_uart_enable_irqs(int enable)
> @@ -731,6 +750,8 @@ void __init omap_serial_init_port(int port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0oh =3D uart->oh;
> + =A0 =A0 =A0 uart->pwrdm =3D omap_hwmod_get_pwrdm(oh);
> + =A0 =A0 =A0 WARN_ON(!uart->pwrdm);
> =A0 =A0 =A0 =A0uart->dma_enabled =3D 0;
> =A0#ifndef CONFIG_SERIAL_OMAP
> =A0 =A0 =A0 =A0name =3D "serial8250";
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat=
-omap/include/plat/serial.h
> index 19145f5..d3ee47b 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -99,8 +99,6 @@ extern void omap_serial_init_port(int port);
> =A0extern int omap_uart_can_sleep(void);
> =A0extern void omap_uart_check_wakeup(void);
> =A0extern void omap_uart_prepare_suspend(void);
> -extern void omap_uart_prepare_idle(int num);
> -extern void omap_uart_resume_idle(int num);
> =A0extern void omap_uart_enable_irqs(int enable);
> =A0#endif
>
> --
> 1.7.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
