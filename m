From: Anil Kumar <anilkumar880@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Sat, 16 Feb 2013 18:39:15 +0530
Message-ID: <CAPjKCR_oh25c4NKUTWjU6BYp64GjPoi2LWDpRhTUkBkRmc_HUw@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
	<1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63764 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab3BPNJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Feb 2013 08:09:16 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so5780356iea.38
        for <linux-omap@vger.kernel.org>; Sat, 16 Feb 2013 05:09:16 -0800 (PST)
In-Reply-To: <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Florian,

On Mon, Jan 28, 2013 at 11:24 PM, Florian Vaussard
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

Tested on devkit8000 (omap3 based board)

Please take my Tested-by: Anil Kumar <anilk4.v@gmail.com>

Thanks,
Anil
