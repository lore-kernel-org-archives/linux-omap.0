From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: dts: omap3-igep: fix boot fail due wrong
 compatible match
Date: Fri, 28 Feb 2014 15:49:28 -0300
Message-ID: <CABxcv=nomABe13t+zKL1=ofeGvB2hL7B3tVU6KohzGw9y5OTKg@mail.gmail.com>
References: <1393077576-25730-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48430 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbaB1St2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 13:49:28 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so1085763pdi.33
        for <linux-omap@vger.kernel.org>; Fri, 28 Feb 2014 10:49:28 -0800 (PST)
In-Reply-To: <1393077576-25730-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Nishanth Menon <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi Tony,

On Sat, Feb 22, 2014 at 10:59 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> This patch is based on commit:
>
> 016c12d2 ("ARM: OMAP3: Fix hardware detection for omap3630 when booted with device tree")
>
> and fixes a boot hang due the IGEP board being wrongly initialized
> as an OMAP3430 platform instead of an OMAP3630.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>
> Tony and Benoit,
>
> Sorry for posting this patch this late on the -rc cycle but I just didn't
> have time before to test IGEP boards against 3.14.
>
> I hope this fix can still make it to 3.14 since is a very big issue
> (board not even booting).
>
> Thanks a lot and best regards,
> Javier
>
>  arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
>  arch/arm/boot/dts/omap3-igep0030.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index 25a2b5f..f2779ac 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model = "IGEPv2 (TI OMAP AM/DM37x)";
> -       compatible = "isee,omap3-igep0020", "ti,omap3";
> +       compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
>
>         leds {
>                 pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> index 145c58c..2793749 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -13,7 +13,7 @@
>
>  / {
>         model = "IGEP COM MODULE (TI OMAP AM/DM37x)";
> -       compatible = "isee,omap3-igep0030", "ti,omap3";
> +       compatible = "isee,omap3-igep0030", "ti,omap36xx", "ti,omap3";
>
>         leds {
>                 pinctrl-names = "default";
> --
> 1.8.5.3
>

I saw you send a pull request for 3.14-rc4 fixes and this fix was not included.

Are you planning to send more fixes for 3.14?

Thanks a lot and best regards,
Javier
