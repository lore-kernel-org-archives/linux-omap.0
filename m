From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Sun, 1 Dec 2013 13:27:25 +0100
Message-ID: <CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:56085 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3LAM11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Dec 2013 07:27:27 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so3638352wib.14
        for <linux-omap@vger.kernel.org>; Sun, 01 Dec 2013 04:27:25 -0800 (PST)
In-Reply-To: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Enric,

Thanks a lot for fixing this.

When adding NAND support for the IGEP boards I used as a base the
example from Documentation/devicetree/bindings/mtd/gpmc-nand.txt and I
wrongly assumed that bch8 was also the ECC scheme used in the legacy
IGEP board file. Sorry for the inconvenience.

On Sun, Dec 1, 2013 at 12:23 PM, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> Legacy board files for IGEP Processor Boards used 1-bit Hamming ECC layout but
> new DT uses BCH8 software layout. This breaks the backward compatibility for
> people that used board files before and switch to DT and have the problem that
> they can't flash the rootfs using the bootloader.
>
> This patch sets the ECC layout to 1-bit Hamming ECC in order to maintain this
> compatibility.
>
> Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
>  arch/arm/boot/dts/omap3-igep0030.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index d5cc792..4229e94 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -116,7 +116,7 @@
>                 linux,mtd-name= "micron,mt29c4g96maz";
>                 reg = <0 0 0>;
>                 nand-bus-width = <16>;
> -               ti,nand-ecc-opt = "bch8";
> +               ti,nand-ecc-opt = "ham1";
>
>                 gpmc,sync-clk-ps = <0>;
>                 gpmc,cs-on-ns = <0>;
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> index 525e6d9..9043e97 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -59,7 +59,7 @@
>                 linux,mtd-name= "micron,mt29c4g96maz";
>                 reg = <0 0 0>;
>                 nand-bus-width = <16>;
> -               ti,nand-ecc-opt = "bch8";
> +               ti,nand-ecc-opt = "ham1";

Just a note that this binding property got renamed for v3.13 on

commit c66d039197e42af8867e5d0d9b904daf0fb9e6bc
Author: Pekon Gupta <pekon@ti.com>
Date:   Thu Oct 24 18:20:18 2013 +0530

    mtd: nand: omap: combine different flavours of 1-bit hamming ecc schemes

so users using current v3.12 kernel or older should use

ti,nand-ecc-opt = "sw";

instead.

>
>                 gpmc,sync-clk-ps = <0>;
>                 gpmc,cs-on-ns = <0>;
> --
> 1.8.1.2
>
> --

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
