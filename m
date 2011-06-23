From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with
 PRCM chain handler
Date: Thu, 23 Jun 2011 16:00:31 +0530
Message-ID: <BANLkTinfYXxQp5Y+-LOh4qqf+=CAGXUbSQ@mail.gmail.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
 <1308760934-9757-6-git-send-email-t-kristo@ti.com> <1308762595.2388.16.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60145 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758872Ab1FWKaw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 06:30:52 -0400
Received: by bwz15 with SMTP id 15so1406078bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 03:30:51 -0700 (PDT)
In-Reply-To: <1308762595.2388.16.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org

On Wed, Jun 22, 2011 at 10:39 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Hi,
>
> There seems to be still one issue with this patch. It fails to protec=
t
> against pr_warning from omap_device.c in some cases, console_trylock(=
)
> console_unlock() hacks inside UART clock enable / disable are not eno=
ugh
> to protect against this. This bug can be prevented by removing the
> pr_warning() calls from omap_device.c.
>

This is handled with uart time patches in serial_omap_console_write
with console_lock which is the right place.

--
Thanks,
Govindraj.R

> -Tero
>
> On Wed, 2011-06-22 at 18:42 +0200, Kristo, Tero wrote:
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 19 -------------------
>> =A0arch/arm/mach-omap2/serial.c | =A0 40 +++++++++++++++++++++------=
-------------
>> =A02 files changed, 21 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index ff0811a..6fff894 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -340,18 +340,9 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_enable_io_chain();
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* Block console output in case it is on one of the OMAP U=
ARTs */
>> - =A0 =A0 if (!is_suspending())
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_ON)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!console_trylock())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto conso=
le_still_active;
>> -
>> =A0 =A0 =A0 /* PER */
>> =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_going_off =3D (per_next_state =3D=3D=
 PWRDM_POWER_OFF) ? 1 : 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(2);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(3);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_gpio_prepare_for_idle(per_going_of=
f);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_next_state =3D=3D PWRDM_POWER_OF=
=46)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_pe=
r_save_context();
>> @@ -359,8 +350,6 @@ void omap_sram_idle(void)
>>
>> =A0 =A0 =A0 /* CORE */
>> =A0 =A0 =A0 if (core_next_state < PWRDM_POWER_ON) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (core_next_state =3D=3D PWRDM_POWER_O=
=46F) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_core_save_context(=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_cm_save_context();
>> @@ -407,8 +396,6 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_sram_restore_conte=
xt();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_sms_restore_contex=
t();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (core_next_state =3D=3D PWRDM_POWER_O=
=46F)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_clear_mod_reg_=
bits(OMAP3430_AUTO_OFF_MASK,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0OMAP3430_GR_MOD,
>> @@ -422,14 +409,8 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_gpio_resume_after_idle();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_prev_state =3D=3D PWRDM_POWER_OF=
=46)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_per_restore_contex=
t();
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(2);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(3);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (!is_suspending())
>> - =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> -
>> -console_still_active:
>> =A0 =A0 =A0 /* Disable IO-PAD and IO-CHAIN wakeup */
>> =A0 =A0 =A0 if (omap3_has_io_wakeup() &&
>> =A0 =A0 =A0 =A0 =A0 (per_next_state < PWRDM_POWER_ON ||
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 1ac361b..e4a5a8c 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -39,6 +39,7 @@
>> =A0#include <plat/dma.h>
>> =A0#include <plat/omap_hwmod.h>
>> =A0#include <plat/omap_device.h>
>> +#include <plat/prcm.h>
>>
>> =A0#include "prm2xxx_3xxx.h"
>> =A0#include "pm.h"
>> @@ -280,24 +281,34 @@ static inline void omap_uart_restore_context(s=
truct omap_uart_state *uart) {}
>>
>> =A0static inline void omap_uart_enable_clocks(struct omap_uart_state=
 *uart)
>> =A0{
>> + =A0 =A0 int locked;
>> +
>> =A0 =A0 =A0 if (uart->clocked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 locked =3D console_trylock();
>> =A0 =A0 =A0 omap_device_enable(uart->pdev);
>> =A0 =A0 =A0 uart->clocked =3D 1;
>> =A0 =A0 =A0 omap_uart_restore_context(uart);
>> + =A0 =A0 if (locked)
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> =A0}
>>
>> =A0#ifdef CONFIG_PM
>>
>> =A0static inline void omap_uart_disable_clocks(struct omap_uart_stat=
e *uart)
>> =A0{
>> + =A0 =A0 int locked;
>> +
>> =A0 =A0 =A0 if (!uart->clocked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 locked =3D console_trylock();
>> =A0 =A0 =A0 omap_uart_save_context(uart);
>> =A0 =A0 =A0 uart->clocked =3D 0;
>> =A0 =A0 =A0 omap_device_idle(uart->pdev);
>> + =A0 =A0 if (locked)
>> + =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
>> =A0}
>>
>> =A0static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
>> @@ -380,6 +391,7 @@ static void omap_uart_allow_sleep(struct omap_ua=
rt_state *uart)
>> =A0 =A0 =A0 omap_uart_smart_idle_enable(uart, 1);
>> =A0 =A0 =A0 uart->can_sleep =3D 1;
>> =A0 =A0 =A0 del_timer(&uart->timer);
>> + =A0 =A0 omap_uart_disable_clocks(uart);
>> =A0}
>>
>> =A0static void omap_uart_idle_timer(unsigned long data)
>> @@ -391,35 +403,23 @@ static void omap_uart_idle_timer(unsigned long=
 data)
>>
>> =A0void omap_uart_prepare_idle(int num)
>> =A0{
>> - =A0 =A0 struct omap_uart_state *uart;
>> -
>> - =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (num =3D=3D uart->num && uart->can_slee=
p) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_disable_clocks(u=
art);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 }
>> =A0}
>>
>> =A0void omap_uart_resume_idle(int num)
>> =A0{
>> =A0 =A0 =A0 struct omap_uart_state *uart;
>> + =A0 =A0 u32 wkst;
>>
>> =A0 =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (num =3D=3D uart->num && uart->can_sl=
eep) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_enable_clocks(ua=
rt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_block_sleep(uart=
);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for IO pad wakeup=
 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx() && u=
art->padconf) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 p =3D =
omap_ctrl_readw(uart->padconf);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p & OM=
AP3_PADCONF_WAKEUPEVENT0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap_uart_block_sleep(uart);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for normal UART w=
akeup (and clear it) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart->wk_st && uart->w=
k_mask) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wkst =3D _=
_raw_readl(uart->wk_st) & uart->wk_mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wkst)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __raw_writel(wkst, uart->wk_st);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for normal UART w=
akeup */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__raw_readl(uart->wk_s=
t) & uart->wk_mask)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_=
block_sleep(uart);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> @@ -550,6 +550,8 @@ static void omap_uart_idle_init(struct omap_uart=
_state *uart)
>> =A0 =A0 =A0 ret =3D request_threaded_irq(uart->irq, NULL, omap_uart_=
interrupt,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I=
RQF_SHARED, "serial idle", (void *)uart);
>> =A0 =A0 =A0 WARN_ON(ret);
>> + =A0 =A0 ret =3D omap_prcm_register_pad_irq(uart->padconf, uart->ir=
q);
>> + =A0 =A0 WARN_ON(ret);
>> =A0}
>>
>> =A0void omap_uart_enable_irqs(int enable)
>
>
>
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040=
-6. Kotipaikka: Helsinki
>
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
