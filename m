From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Mon, 4 Feb 2013 10:27:38 +0100
Message-ID: <CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
	<1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:40910 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3BDJ1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 04:27:40 -0500
Received: by mail-we0-f170.google.com with SMTP id z53so4754615wey.29
        for <linux-omap@vger.kernel.org>; Mon, 04 Feb 2013 01:27:38 -0800 (PST)
In-Reply-To: <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Florian,

On Mon, Jan 28, 2013 at 6:54 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> Add device-tree support for the GPMC controller on the OMAP3.
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 6c63118..2ddae38 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -403,5 +403,16 @@
>                         ti,timer-alwon;
>                         ti,timer-secure;
>                 };
> +
> +               gpmc: gpmc@6e000000 {
> +                       compatible = "ti,omap3430-gpmc";
> +                       ti,hwmods = "gpmc";
> +                       reg = <0x6e000000 0x1000000>;
> +                       interrupts = <20>;
> +                       gpmc,num-cs = <8>;
> +                       gpmc,num-waitpins = <4>;
> +                       #address-cells = <2>;
> +                       #size-cells = <1>;
> +               };
>         };
>  };

I had the same patch on a tree I was working on to add DT support for
gpmc-smsc911x on an OMAP3 board but I was waiting for Daniel's patches
to hit mainline before sending the RFC. So please feel free to add:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
