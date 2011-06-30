From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv4 3/9] OMAP3: PM: remove serial resume / idle calls from
 idle path
Date: Thu, 30 Jun 2011 22:20:54 +0530
Message-ID: <BANLkTik3QGqpHY46cc8g-0uuaL9e67nBgQ@mail.gmail.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com> <1309338303-2086-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33670 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab1F3QvP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 12:51:15 -0400
Received: by bwd5 with SMTP id 5so1978478bwd.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 09:51:14 -0700 (PDT)
In-Reply-To: <1309338303-2086-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Jun 29, 2011 at 2:34 PM, Tero Kristo <t-kristo@ti.com> wrote:
> This is no longer needed as it will be handled within serial driver i=
tself.
>

Can be marked as tmp same is done with uart runtime

https://patchwork.kernel.org/patch/862332/

--
Thanks,
Govindraj.R

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 19 -------------------
> =A01 files changed, 0 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 89cf027..e626a3d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -335,18 +335,9 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_enable_io_chain();
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Block console output in case it is on one of the OMA=
P UARTs */
> - =A0 =A0 =A0 if (!is_suspending())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_O=
N)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!console_trylock())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto co=
nsole_still_active;
> -
> =A0 =A0 =A0 =A0/* PER */
> =A0 =A0 =A0 =A0if (per_next_state < PWRDM_POWER_ON) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0per_going_off =3D (per_next_state =3D=3D=
 PWRDM_POWER_OFF) ? 1 : 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_gpio_prepare_for_idle(per_going_=
off);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (per_next_state =3D=3D PWRDM_POWER_=
OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_=
per_save_context();
> @@ -354,8 +345,6 @@ void omap_sram_idle(void)
>
> =A0 =A0 =A0 =A0/* CORE */
> =A0 =A0 =A0 =A0if (core_next_state < PWRDM_POWER_ON) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_prepare_idle(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (core_next_state =3D=3D PWRDM_POWER=
_OFF) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_core_save_contex=
t();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_cm_save_context(=
);
> @@ -402,8 +391,6 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_sram_restore_con=
text();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_sms_restore_cont=
ext();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (core_next_state =3D=3D PWRDM_POWER=
_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_prm_clear_mod_re=
g_bits(OMAP3430_AUTO_OFF_MASK,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD,
> @@ -417,14 +404,8 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_gpio_resume_after_idle();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (per_prev_state =3D=3D PWRDM_POWER_=
OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_per_restore_cont=
ext();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uart_resume_idle(3);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!is_suspending())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_unlock();
> -
> -console_still_active:
> =A0 =A0 =A0 =A0/* Disable IO-PAD and IO-CHAIN wakeup */
> =A0 =A0 =A0 =A0if (omap3_has_io_wakeup() &&
> =A0 =A0 =A0 =A0 =A0 =A0(per_next_state < PWRDM_POWER_ON ||
> --
> 1.7.4.1
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
