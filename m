From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in gpio_irq_handler
Date: Fri, 9 Mar 2012 14:16:52 +0530
Message-ID: <CAC83ZvJXK-FsiqyQT6BQxggRewkiHZkRBi44CVH15gb4dUbsjw@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47017 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab2CIIqy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 03:46:54 -0500
Received: by mail-qy0-f169.google.com with SMTP id d16so1188364qcs.0
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 00:46:53 -0800 (PST)
In-Reply-To: <1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Wed, Mar 7, 2012 at 4:45 PM, Tarun Kanti DebBarma <tarun.kanti@ti.co=
m> wrote:
> This local variable is just assigned zero and then OR'ed
> with isr. It does not appear to serve any purpose and so
> removing it.
Missed following comments from Kevin given in v2. Sorry about that.
I have updated the change in:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-om=
ap-dev
for_3.4/gpio_further_cleanup_fixes

"commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
framework) removed retrigger support in favor of using generic IRQ
framework.  This patch cleans up some unused remnants of that removal.
--
Tarun
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
> =A0drivers/gpio/gpio-omap.c | =A0 =A03 ---
> =A01 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 3765654..de5fe8f 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -626,7 +626,6 @@ static void gpio_irq_handler(unsigned int irq, st=
ruct irq_desc *desc)
> =A0 =A0 =A0 =A0u32 isr;
> =A0 =A0 =A0 =A0unsigned int gpio_irq, gpio_index;
> =A0 =A0 =A0 =A0struct gpio_bank *bank;
> - =A0 =A0 =A0 u32 retrigger =3D 0;
> =A0 =A0 =A0 =A0int unmasked =3D 0;
> =A0 =A0 =A0 =A0struct irq_chip *chip =3D irq_desc_get_chip(desc);
>
> @@ -663,8 +662,6 @@ static void gpio_irq_handler(unsigned int irq, st=
ruct irq_desc *desc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chained_irq_exit(chip,=
 desc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr |=3D retrigger;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retrigger =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!isr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> --
> 1.7.0.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
