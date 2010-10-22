From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] OMAP: UART: use atomic idle notifiers
Date: Fri, 22 Oct 2010 09:11:45 -0700
Message-ID: <871v7idx6m.fsf@deeprootsystems.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
	<1287617483-24170-3-git-send-email-khilman@deeprootsystems.com>
	<AANLkTinYhNAYpehKEshPz89uqcKy9K9hB2Q+a7N+EveJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42057 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689Ab0JVQLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:11:49 -0400
Received: by pwj3 with SMTP id 3so309430pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:11:49 -0700 (PDT)
In-Reply-To: <AANLkTinYhNAYpehKEshPz89uqcKy9K9hB2Q+a7N+EveJ@mail.gmail.com>
	(Govindraj's message of "Fri, 22 Oct 2010 18:24:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> Thanks Kevin,
>
> works fine tested on 3630sdp/zoom3 board.
>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

Govindraj,  thanks for testing!

Kevin

>
> On Thu, Oct 21, 2010 at 5:01 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Convert UART idle management routines from custom hooks in the core
>> idle path to use new idle notifiers.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/pm24xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A09 +---
>> =C2=A0arch/arm/mach-omap2/pm34xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A08 ---
>> =C2=A0arch/arm/mach-omap2/serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 71 +++++++++++++++++++----------
>> =C2=A0arch/arm/plat-omap/include/plat/serial.h | =C2=A0 =C2=A02 -
>> =C2=A04 files changed, 47 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24=
xx.c
>> index cb1b333..47644d2 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -40,6 +40,7 @@
>> =C2=A0#include <plat/sram.h>
>> =C2=A0#include <plat/dma.h>
>> =C2=A0#include <plat/board.h>
>> +#include <plat/common.h>
>>
>> =C2=A0#include "prm.h"
>> =C2=A0#include "prm-regbits-24xx.h"
>> @@ -120,19 +121,11 @@ static void omap2_enter_full_retention(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (omap_irq_pending())
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto no_sleep=
;
>>
>> - =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare_idle(0);
>> - =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare_idle(1);
>> - =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare_idle(2);
>> -
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Jump to SRAM suspend code */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_sram_suspend(sdrc_read_reg(SDRC_DLL=
A_CTRL),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 OMAP_SDRC_REGADDR(SDRC_POWER));
>>
>> - =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_idle(2);
>> - =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_idle(1);
>> - =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_idle(0);
>> -
>> =C2=A0no_sleep:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (omap2_pm_debug) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=
 long tmp;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 4674748..eaed95d 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -390,8 +390,6 @@ void omap_sram_idle(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* PER */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (per_next_state < PWRDM_POWER_ON) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare=
_idle(2);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare=
_idle(3);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_pr=
epare_for_idle(per_next_state);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (per_next_=
state =3D=3D PWRDM_POWER_OFF)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_per_save_context();
>> @@ -399,8 +397,6 @@ void omap_sram_idle(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CORE */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (core_next_state < PWRDM_POWER_ON) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare=
_idle(0);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_prepare=
_idle(1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (core_next=
_state =3D=3D PWRDM_POWER_OFF) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_core_save_context();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_prcm_save_context();
>> @@ -445,8 +441,6 @@ void omap_sram_idle(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_sram_restore_context();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap2_sms_restore_context();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_=
idle(0);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_=
idle(1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (core_next=
_state =3D=3D PWRDM_POWER_OFF)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OMAP3430_GR_MOD,
>> @@ -459,8 +453,6 @@ void omap_sram_idle(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_re=
sume_after_idle();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (per_prev_=
state =3D=3D PWRDM_POWER_OFF)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap3_per_restore_context();
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_=
idle(2);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_resume_=
idle(3);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable IO-PAD and IO-CHAIN wakeup */
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index becf0e3..8a619ff 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -73,6 +73,7 @@ struct omap_uart_state {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 padconf;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dma_enabled;
>>
>> + =C2=A0 =C2=A0 =C2=A0 struct powerdomain *pwrdm;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk *ick;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk *fck;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int clocked;
>> @@ -389,39 +390,31 @@ static void omap_uart_idle_timer(unsigned long=
 data)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_allow_sleep(uart);
>> =C2=A0}
>>
>> -void omap_uart_prepare_idle(int num)
>> +static void omap_uart_prepare_idle(struct omap_uart_state *uart)
>> =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 struct omap_uart_state *uart;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(uart, &uart_list, node) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (num =3D=3D ua=
rt->num && uart->can_sleep) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_uart_disable_clocks(uart);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 if (uart->can_sleep &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwrdm_read_next_pwrst(uart->pwr=
dm) < PWRDM_POWER_ON)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_disable=
_clocks(uart);
>> =C2=A0}
>>
>> -void omap_uart_resume_idle(int num)
>> +static void omap_uart_resume_idle(struct omap_uart_state *uart)
>> =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 struct omap_uart_state *uart;
>> + =C2=A0 =C2=A0 =C2=A0 if (uart->can_sleep &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwrdm_read_next_pwrst(uart->pwr=
dm) < PWRDM_POWER_ON) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_enable_=
clocks(uart);
>>
>> - =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(uart, &uart_list, node) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (num =3D=3D ua=
rt->num) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_uart_enable_clocks(uart);
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Check for IO pad wakeup */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (cpu_is_omap34xx() && uart->padconf) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 p =3D omap_ctrl_readw(uart->=
padconf);
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p & OMAP3_PADCONF_WAKEUPEVEN=
T0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap=
_uart_block_sleep(uart);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check for IO p=
ad wakeup */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap34=
xx() && uart->padconf) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 u16 p =3D omap_ctrl_readw(uart->padconf);
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Check for normal UART wakeup */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (__raw_readl(uart->wk_st) & uart->wk_mask)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (p & OMAP3_PADCONF_WAKEUPEVENT0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_block_sleep(uart);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check for norm=
al UART wakeup */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (__raw_readl(u=
art->wk_st) & uart->wk_mask)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_uart_block_sleep(uart);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0}
>>
>> @@ -474,6 +467,27 @@ static irqreturn_t omap_uart_interrupt(int irq,=
 void *dev_id)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
>> =C2=A0}
>>
>> +static int omap_uart_idle_notifier(struct notifier_block *n,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long val,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *p)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct omap_uart_state *uart;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (val =3D=3D OMAP_IDLE_START)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_ent=
ry(uart, &uart_list, node)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_uart_prepare_idle(uart);
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_ent=
ry(uart, &uart_list, node)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_uart_resume_idle(uart);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static bool omap_uart_notifier_enabled;
>> +static struct notifier_block omap_uart_notifier =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .notifier_call =3D omap_uart_idle_notifier,
>> +};
>> +
>> =C2=A0static void omap_uart_idle_init(struct omap_uart_state *uart)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>> @@ -549,6 +563,11 @@ static void omap_uart_idle_init(struct omap_uar=
t_state *uart)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_threaded_irq(uart->irq, N=
ULL, omap_uart_interrupt,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_SHARED, "serial =
idle", (void *)uart);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(ret);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (!omap_uart_notifier_enabled) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_idle_notifie=
r_register(&omap_uart_notifier);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_uart_notifie=
r_enabled =3D true;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0}
>>
>> =C2=A0void omap_uart_enable_irqs(int enable)
>> @@ -731,6 +750,8 @@ void __init omap_serial_init_port(int port)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0oh =3D uart->oh;
>> + =C2=A0 =C2=A0 =C2=A0 uart->pwrdm =3D omap_hwmod_get_pwrdm(oh);
>> + =C2=A0 =C2=A0 =C2=A0 WARN_ON(!uart->pwrdm);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0uart->dma_enabled =3D 0;
>> =C2=A0#ifndef CONFIG_SERIAL_OMAP
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D "serial8250";
>> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/pla=
t-omap/include/plat/serial.h
>> index 19145f5..d3ee47b 100644
>> --- a/arch/arm/plat-omap/include/plat/serial.h
>> +++ b/arch/arm/plat-omap/include/plat/serial.h
>> @@ -99,8 +99,6 @@ extern void omap_serial_init_port(int port);
>> =C2=A0extern int omap_uart_can_sleep(void);
>> =C2=A0extern void omap_uart_check_wakeup(void);
>> =C2=A0extern void omap_uart_prepare_suspend(void);
>> -extern void omap_uart_prepare_idle(int num);
>> -extern void omap_uart_resume_idle(int num);
>> =C2=A0extern void omap_uart_enable_irqs(int enable);
>> =C2=A0#endif
>>
>> --
>> 1.7.2.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
