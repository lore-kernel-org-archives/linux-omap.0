From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep0020: Add USB OTG support
Date: Sun, 6 Oct 2013 12:26:50 +0200
Message-ID: <CAFqH_530ibnuqPsMQuiPZL_5HraqJUy9rpHswa9hCh4WWyC_Vg@mail.gmail.com>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
	<1380931479-16142-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:54838 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab3JFK0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Oct 2013 06:26:51 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so5947526wgg.8
        for <linux-omap@vger.kernel.org>; Sun, 06 Oct 2013 03:26:50 -0700 (PDT)
In-Reply-To: <1380931479-16142-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

2013/10/5 Javier Martinez Canillas <javier.martinez@collabora.co.uk>:
> Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards")
> added USB OTG support for most OMAP boards but some OMAP3 boards
> such as the IGEPv2 were not updated. This patch adds an USB OTG
> device node to this board.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3-igep0020.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index eedf0d8..903e944 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -166,3 +166,10 @@
>                 smsc,save-mac-address;
>         };
>  };
> +
> +&usb_otg_hs {
> +       interface-type = <0>;
> +       usb-phy = <&usb2_phy>;
> +       mode = <3>;
> +       power = <50>;
> +};
> --
> 1.8.4.rc3
>

Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
