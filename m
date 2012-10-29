From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct
 mux mode
Date: Mon, 29 Oct 2012 19:31:37 +0100
Message-ID: <CAFqH_53q8yTy=yBxDE=SFQ=j-ogy4yNF5KpNBsLd1OQ9dbA37g@mail.gmail.com>
References: <1351533073-5974-1-git-send-email-anders.j.hedlund@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:47519 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760237Ab2J2Sbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 14:31:37 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2552526dak.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Oct 2012 11:31:37 -0700 (PDT)
In-Reply-To: <1351533073-5974-1-git-send-email-anders.j.hedlund@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anders Hedlund <anders.j.hedlund@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Jonas Zetterberg <jozz@jozz.se>, Javier Martinez Canillas <martinez.javier@gmail.com>, Matthias Brugger <mbrugger@iseebcn.com>

Hi,

Thanks for the patch, just one comment below.

2012/10/29 Anders Hedlund <anders.j.hedlund@gmail.com>:
> Configure the WIFI/BT GPIO pin muxes unless the bootloader hasn't already
> done so.
>
> Signed-off-by: Anders Hedlund <anders.j.hedlund@gmail.com>
> Cc: Jonas Zetterberg <jozz@jozz.se>
> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index dbc705a..17e45bc 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -579,6 +579,13 @@ static void __init igep_wlan_bt_init(void)
>         } else
>                 return;
>
> +#ifdef CONFIG_OMAP_MUX

The ifdef is not required here (the mux.h file does this for you)

> +       /* Make sure that the GPIO pins are muxed correctly */
> +       omap_mux_init_gpio(igep_wlan_bt_gpios[0].gpio, OMAP_PIN_OUTPUT);
> +       omap_mux_init_gpio(igep_wlan_bt_gpios[1].gpio, OMAP_PIN_OUTPUT);
> +       omap_mux_init_gpio(igep_wlan_bt_gpios[2].gpio, OMAP_PIN_OUTPUT);
> +#endif
> +
>         err = gpio_request_array(igep_wlan_bt_gpios,
>                                  ARRAY_SIZE(igep_wlan_bt_gpios));
>         if (err) {
> --
> 1.7.10.4
>

Tony, after corrections, as this is a fix could be included ?  Or we
need to wait to the next merge window.

The problem is, with recent u-boot these pins are not muxed because
u-boot sets only the minimum required for uboot functionality and
kernel boot. In kernel these pins must be muxed in order to get the
wifi and bluetooth work.

( CCing: Javier Martinez and Matthias Brugger )
