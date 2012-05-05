From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Sun, 6 May 2012 00:55:09 +0300
Message-ID: <CANOLnOO3bSxoE-8TaXd_Tz=taPOZpfQY+z-=6c7Ovfpf+FCAuw@mail.gmail.com>
References: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37913 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2EEVzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 May 2012 17:55:09 -0400
Received: by obbtb18 with SMTP id tb18so5966714obb.19
        for <linux-omap@vger.kernel.org>; Sat, 05 May 2012 14:55:09 -0700 (PDT)
In-Reply-To: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

I've noticed that current mainline enables _all_ possible GPIO
interrupts, this patch fixes that problem.
Also Grant doesn't seem to be on CC so might not be able to pick this u=
p.

On Mon, Apr 30, 2012 at 10:20 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Initialization of irqenable, irqstatus registers is the common
> operation done in this function for all OMAP platforms, viz. OMAP1,
> OMAP2+. The latter _gpio_rmw()'s which supposedly got introduced
> wrongly to take care of OMAP2+ platforms were overwriting initially
> programmed OMAP1 value breaking functionality on OMAP1.
> Somehow incorrect assumption was made that each _gpio_rmw()'s were
> mutually exclusive. On close observation it is found that the first
> _gpio_rmw() which is supposedly done to take care of OMAP1 platform
> is generic enough and takes care of OMAP2+ platform as well.
> Therefore remove the latter _gpio_rmw() to irqenable as they are
> redundant now.
>
> Writing to ctrl and debounce_en registers for OMAP2+ platforms are
> modified to match the original(pre-cleanup) code where the registers
> are initialized with 0. In the cleanup series since we are using
> _gpio_rmw(reg, 0, 1), instead of __raw_writel(), we are just reading
> and writing the same values to ctrl and debounce_en. This is not an
> issue for debounce_en register because it has 0x0 as the default valu=
e.
> But in the case of ctrl register the default value is 0x2 (GATINGRATI=
O
> =A0=3D 0x1) so that we end up writing 0x2 instead of intended 0 value=
=2E
> Therefore changing back to __raw_writel() as this is sufficient for
> this case besides simpler to understand.
>
> Also, change irqstatus initalization logic that avoids comparison
> with bool, besides making it fit in a single line.
>
> Cc: stable@vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> v2:
> Avoid irqstatus initialization sequence change.
> Use __raw_writel() to update debounce_en and ctrl registers.
> Update changelog to elaborate how redundant _gpio_rmw() got added.
>
> =A0drivers/gpio/gpio-omap.c | =A0 =A09 +++------
> =A01 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 59a4af1..9b71f04 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -957,18 +957,15 @@ static void omap_gpio_mod_init(struct gpio_bank=
 *bank)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->=
irqenable_inv);
> - =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bank->regs->irqenable_inv =3D=3D false);
> - =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->d=
ebounce_en !=3D 0);
> - =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->c=
trl !=3D 0);
> + =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l, !bank->regs->=
irqenable_inv);
> =A0 =A0 =A0 =A0if (bank->regs->debounce_en)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->debounce_en=
, 0, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, base + bank->regs->debo=
unce_en);
>
> =A0 =A0 =A0 =A0/* Save OE default value (0xffffffff) in the context *=
/
> =A0 =A0 =A0 =A0bank->context.oe =3D __raw_readl(bank->base + bank->re=
gs->direction);
> =A0 =A0 =A0 =A0 /* Initialize interface clk ungated, module enabled *=
/
> =A0 =A0 =A0 =A0if (bank->regs->ctrl)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->ctrl, 0, 1)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, base + bank->regs->ctrl=
);
> =A0}
>
> =A0static __devinit void
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Gra=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
