From: Anders Hedlund <anders.j.hedlund@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct
 mux mode
Date: Mon, 29 Oct 2012 22:23:18 +0100
Message-ID: <CAFCvrJmHSt4L9fxV19wvBFM8ay1zHb3i-6e7c9JDeJdWZajP5Q@mail.gmail.com>
References: <1351507226-10328-1-git-send-email-sourav.poddar@ti.com>
	<1351537155-27159-1-git-send-email-anders.j.hedlund@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48704 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2J2VXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 17:23:20 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2189566bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Oct 2012 14:23:19 -0700 (PDT)
In-Reply-To: <1351537155-27159-1-git-send-email-anders.j.hedlund@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: Anders Hedlund <anders.j.hedlund@gmail.com>, Jonas Zetterberg <jozz@jozz.se>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Matthias Brugger <mbrugger@iseebcn.com>

Hi Tony and all,
Sorry... please ignore this one. Sent with incorrect Message-Id. A new
(hopefully correct) patch mail has already been sent...

Br,
Anders

2012/10/29 Anders Hedlund <anders.j.hedlund@gmail.com>:
> Setup the WIFI/BT GPIO pin muxes to enable WIFI/BT functionality.
>
> Signed-off-by: Anders Hedlund <anders.j.hedlund@gmail.com>
> Cc: Jonas Zetterberg <jozz@jozz.se>
> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
> Cc: Javier Martinez Canillas <martinez.javier@gmail.com>
> Cc: Matthias Brugger <mbrugger@iseebcn.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 2821448..2a21947 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -583,6 +583,11 @@ static void __init igep_wlan_bt_init(void)
>         } else
>                 return;
>
> +       /* Make sure that the GPIO pins are muxed correctly */
> +       omap_mux_init_gpio(igep_wlan_bt_gpios[0].gpio, OMAP_PIN_OUTPUT);
> +       omap_mux_init_gpio(igep_wlan_bt_gpios[1].gpio, OMAP_PIN_OUTPUT);
> +       omap_mux_init_gpio(igep_wlan_bt_gpios[2].gpio, OMAP_PIN_OUTPUT);
> +
>         err = gpio_request_array(igep_wlan_bt_gpios,
>                                  ARRAY_SIZE(igep_wlan_bt_gpios));
>         if (err) {
> --
> 1.7.10.4
>
