From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Fri, 27 May 2011 21:03:57 +0530
Message-ID: <BANLkTi=imJXEKriWdXOGE_wWWkQvdtLAHg@mail.gmail.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50907 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab1E0PkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 11:40:04 -0400
Received: by bwz15 with SMTP id 15so1392833bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 08:40:02 -0700 (PDT)
In-Reply-To: <1304846514-15641-1-git-send-email-rabin@rab.in>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rabin Vincent <rabin@rab.in>

Tony,

On Sun, May 8, 2011 at 14:51, Rabin Vincent <rabin@rab.in> wrote:
> omap_readl() is used from the sched_clock() implementations and so mu=
st
> be marked notrace to avoid recursion in ftrace. =A0Same thing with
> mpu_read() for OMAP1.
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Comments on this patch?  This is a bugfix; the function graph tracer
will crash and burn on OMAP without this.

> ---
> =A0arch/arm/mach-omap1/io.c =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap1/time.c | =A0 =A02 +-
> =A0arch/arm/mach-omap2/io.c =A0 | =A0 =A02 +-
> =A03 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
> index 870886a..36ec2d7 100644
> --- a/arch/arm/mach-omap1/io.c
> +++ b/arch/arm/mach-omap1/io.c
> @@ -158,7 +158,7 @@ u16 omap_readw(u32 pa)
> =A0}
> =A0EXPORT_SYMBOL(omap_readw);
>
> -u32 omap_readl(u32 pa)
> +u32 notrace omap_readl(u32 pa)
> =A0{
> =A0 =A0 =A0 =A0return __raw_readl(OMAP1_IO_ADDRESS(pa));
> =A0}
> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
> index 6885d2f..88c5c5e 100644
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
> @@ -203,7 +203,7 @@ static struct irqaction omap_mpu_timer2_irq =3D {
> =A0 =A0 =A0 =A0.handler =A0 =A0 =A0 =A0=3D omap_mpu_timer2_interrupt,
> =A0};
>
> -static cycle_t mpu_read(struct clocksource *cs)
> +static cycle_t notrace mpu_read(struct clocksource *cs)
> =A0{
> =A0 =A0 =A0 =A0return ~omap_mpu_timer_read(1);
> =A0}
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 441e79d..f1987b1 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -441,7 +441,7 @@ u16 omap_readw(u32 pa)
> =A0}
> =A0EXPORT_SYMBOL(omap_readw);
>
> -u32 omap_readl(u32 pa)
> +u32 notrace omap_readl(u32 pa)
> =A0{
> =A0 =A0 =A0 =A0return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
> =A0}
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
