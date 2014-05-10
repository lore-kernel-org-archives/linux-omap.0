From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 4/6] ARM: dts: am43xx: fix starting offset of
 NAND.filesystem MTD partition
Date: Sat, 10 May 2014 19:02:55 +0200
Message-ID: <CABxcv=n4gH4y0Y8aNT5KUGzgA33pcw9XHsT+FCxgmxMaW0fqNg@mail.gmail.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
	<1399668412-10818-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49022 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055AbaEJRC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2014 13:02:56 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so2690709wib.0
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2014 10:02:55 -0700 (PDT)
In-Reply-To: <1399668412-10818-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>

Hello Pekon,

On Fri, May 9, 2014 at 10:46 PM, Pekon Gupta <pekon@ti.com> wrote:
> MTD NAND partition for file-system should start at offset=0xA00000
>
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index cf8bdf1..fd29930 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -360,7 +360,7 @@
>                 };
>                 partition@9 {
>                         label = "NAND.file-system";
> -                       reg = <0x00800000 0x1F600000>;
> +                       reg = <0x00A00000 0x1F600000>;
>                 };
>         };
>  };

While you are there, could you please change to lower case the hex
values to be consistent with the rest of the Device Trees?

Thanks a lot and best regards,
Javier
