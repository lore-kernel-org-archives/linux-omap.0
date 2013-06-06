From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH] arm/omap: use const char properly
Date: Thu, 6 Jun 2013 16:42:40 +0300
Message-ID: <CAB=otbRkdAxWoQq0wsUNdgdWg-TUs0wY58AXhfxAQ24JCj_80Q@mail.gmail.com>
References: <1370525079-22195-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:43077 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3FFNml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 09:42:41 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so4725216obc.34
        for <linux-omap@vger.kernel.org>; Thu, 06 Jun 2013 06:42:40 -0700 (PDT)
In-Reply-To: <1370525079-22195-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Sebastian,

On Thu, Jun 6, 2013 at 4:24 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> The itention was probably to make both pointers const but as it is now,
> it is just const used twice.

Yes, it's a typo I did accidentally. Good catch!

Regards,
Ruslan

>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-omap2/id.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 1272c41..54e4c16 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -601,7 +601,7 @@ void __init omap2_set_globals_tap(u32 class, void __iomem *tap)
>
>  #ifdef CONFIG_SOC_BUS
>
> -static const char const *omap_types[] = {
> +static const char * const omap_types[] = {
>         [OMAP2_DEVICE_TYPE_TEST]        = "TST",
>         [OMAP2_DEVICE_TYPE_EMU]         = "EMU",
>         [OMAP2_DEVICE_TYPE_SEC]         = "HS",
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
