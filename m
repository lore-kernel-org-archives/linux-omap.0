From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH] gpio/omap: fix wakeups on level-triggered GPIOs
Date: Wed, 22 Feb 2012 22:47:35 +0530
Message-ID: <CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
References: <1329850878-22189-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60982 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120Ab2BVRRg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 12:17:36 -0500
Received: by mail-qw0-f48.google.com with SMTP id h8so511116qau.0
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 09:17:35 -0800 (PST)
In-Reply-To: <1329850878-22189-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 22, 2012 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrote:
> While both level- and edge-triggered GPIOs are capable of generating
> interrupts, only edge-triggered GPIOs are capable of generating a
> module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2.)
>
> In order to ensure that devices using level-triggered GPIOs as
> interrupts can also cause wakeups (e.g. from idle), this patch enable=
s
> edge-triggering for wakeup-enabled, level-triggered GPIOs when a GPIO
> bank is runtime-suspended (which also happens during idle.)
>
> This fixes a problem found in GPMC-connected network cards with GPIO
> interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network booting
> with NFSroot was very slow since the GPIO IRQs used by the NIC were
> not generating PRCM wakeups, and thus not waking the system from idle=
=2E
> NOTE: until v3.3, this boot-time problem was somewhat masked because
> the UART init prevented WFI during boot until the full serial driver
> was available. =A0Preventing WFI allowed regular GPIO interrupts to f=
ire
> and this problem was not seen. =A0After the UART runtime PM cleanups,=
 we
> no longer avoid WFI during boot, so GPIO IRQs that were not causing
> wakeups resulted in very slow IRQ response times.
>
> Tested on platforms using level-triggered GPIOs for network IRQs usin=
g
> the SMSC911x NIC: 3530/Overo and 3630/Zoom3.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

I have tested on OMAP3430 by making modification to touchscreen GPIO.
(I had similar change in my next planned cleanup/fix series.)
If needed you can add my Tested-by:
--
Tarun

> ---
> This applies on top of the GPIO cleanup and runtime PM conversion ser=
ies
> which has been submitted for v3.4 and also available here:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.g=
it for_3.4/gpio/runtime-pm-cleanup
>
> =A0drivers/gpio/gpio-omap.c | =A0 34 ++++++++++++++++++++++++++++++++=
++
> =A01 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index f49bd6f..752ae9b 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1196,8 +1196,30 @@ static int omap_gpio_runtime_suspend(struct de=
vice *dev)
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D platform_get_drvdata(pdev);
> =A0 =A0 =A0 =A0u32 l1 =3D 0, l2 =3D 0;
> =A0 =A0 =A0 =A0unsigned long flags;
> + =A0 =A0 =A0 u32 wake_low, wake_hi;
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Only edges can generate a wakeup event to the PRCM=
=2E
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Therefore, ensure any wake-up capable GPIOs have
> + =A0 =A0 =A0 =A0* edge-detection enabled before going idle to ensure=
 a wakeup
> + =A0 =A0 =A0 =A0* to the PRCM is generated on a GPIO transition. (c.=
f. 34xx
> + =A0 =A0 =A0 =A0* NDA TRM 25.5.3.1)
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* The normal values will be restored upon ->runtime_=
resume()
> + =A0 =A0 =A0 =A0* by writing back the values saved in bank->context.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 wake_low =3D bank->context.leveldetect0 & bank->context=
=2Ewake_en;
> + =A0 =A0 =A0 if (wake_low)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(wake_low | bank->context.f=
allingdetect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base +=
 bank->regs->fallingdetect);
> + =A0 =A0 =A0 wake_hi =3D bank->context.leveldetect1 & bank->context.=
wake_en;
> + =A0 =A0 =A0 if (wake_hi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(wake_hi | bank->context.ri=
singdetect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base +=
 bank->regs->risingdetect);
> +
> =A0 =A0 =A0 =A0if (bank->power_mode !=3D OFF_MODE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->power_mode =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto update_gpio_context_count;
> @@ -1246,6 +1268,18 @@ static int omap_gpio_runtime_resume(struct dev=
ice *dev)
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> =A0 =A0 =A0 =A0_gpio_dbck_enable(bank);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In ->runtime_suspend(), level-triggered, wakeup-en=
abled
> + =A0 =A0 =A0 =A0* GPIOs were set to edge trigger also in order to be=
 able to
> + =A0 =A0 =A0 =A0* generate a PRCM wakeup. =A0Here we restore the
> + =A0 =A0 =A0 =A0* pre-runtime_suspend() values for edge triggering.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base + bank->regs->fal=
lingdetect);
> + =A0 =A0 =A0 __raw_writel(bank->context.risingdetect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base + bank->regs->ris=
ingdetect);
> +
> =A0 =A0 =A0 =A0if (!bank->enabled_non_wakeup_gpios || !bank->workarou=
nd_enabled) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&bank->lock, fl=
ags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
