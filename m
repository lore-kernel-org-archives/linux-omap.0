From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/7] mfd: twl4030-irq: set irq nested flag
Date: Mon, 12 Dec 2011 19:58:31 +0200
Message-ID: <CAMP44s1L99rPM_=puw9XgL8obeH3f46nUkSLuqvDyCNdSbbg7A@mail.gmail.com>
References: <1309427470-605-1-git-send-email-balbi@ti.com>
	<1309427470-605-7-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58720 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1LLR6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 12:58:32 -0500
In-Reply-To: <1309427470-605-7-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jun 30, 2011 at 12:51 PM, Felipe Balbi <balbi@ti.com> wrote:
> threads from twl4030's children will be called
> nested in the context of the demultiplexing
> handler on twl4030-irq.c.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> =C2=A0drivers/mfd/twl4030-irq.c | =C2=A0 11 ++++++-----
> =C2=A01 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 1b9ab2f..ff16e9c 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -304,7 +304,7 @@ static irqreturn_t handle_twl4030_pih(int irq, vo=
id *devid)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pih_isr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pih_isr >>=3D 1, module_irq++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pih_isr & =
0x1)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 generic_handle_irq(module_irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 handle_nested_irq(module_irq);

But handle_nested_irq calls action->thread_fn, which is NULL for the
sih handlers that are set-up below; handle_twl4030_sih will never be
called.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> @@ -596,9 +596,7 @@ static void handle_twl4030_sih(unsigned irq, stru=
ct irq_desc *desc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int isr;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* reading ISR acks the IRQs, using clear-=
on-read mode */
> - =C2=A0 =C2=A0 =C2=A0 local_irq_enable();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0isr =3D sih_read_isr(sih);
> - =C2=A0 =C2=A0 =C2=A0 local_irq_disable();

But handle_twl4030_sih is still not nested.

=46ortunately, Neil Brown already fixed the issues in this patch by
making handle_twl4030_sih truly nested:
http://article.gmane.org/gmane.linux.kernel/1220708

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
