From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 6/6] ARM: dts: am335x-evm: fix reg and range property
 of GPMC NAND node
Date: Sat, 10 May 2014 19:11:33 +0200
Message-ID: <CABxcv==icXxn74_zz1YQTq2jvuPyDSSh5ZM_NKA1W3SUzD6EKA@mail.gmail.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
	<1399668412-10818-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49829 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaEJRLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2014 13:11:34 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so2696082wiv.1
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2014 10:11:33 -0700 (PDT)
In-Reply-To: <1399668412-10818-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>

Hello Pekon,

On Fri, May 9, 2014 at 10:46 PM, Pekon Gupta <pekon@ti.com> wrote:
> 1) NAND device memory is not directly accessible to CPU, its indirectly accessed
>    via registers. So the 'reg' property for GPMC NAND nodes should be limited to
>    address range of internal GPMC registers only.
> 2) Also, minimum granularity of address space under a GPMC chip-select is 16MB
>    so 'range' property for GPMC NAND node should specify 16MB as its memory-size

This is true for all SoC using the GPMC right? So we need to do the
same modification for all OMAP boards to avoid mapping a bigger
address space unnecessarily.

> 3) On AM437x, address map of external memory accessible via GPMC starts from 0x0
>

You are talking about AM437x here but changing an am335x board. Is this a typo?

Best regards,
Javier

> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 33f7c57..bae7575 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -437,9 +437,9 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&nandflash_pins_s0>;
> -       ranges = <0 0 0x08000000 0x10000000>;   /* CS0: NAND */
> +       ranges = <0 0 0 0x1000000>;     /* CS0: NAND */
>         nand@0,0 {
> -               reg = <0 0 0>; /* CS0, offset 0 */
> +               reg = <0 0 0x380>; /* CS0, offset=0, reg-map size=0x380 */
>                 ti,nand-ecc-opt = "bch8";
>                 ti,elm-id = <&elm>;
>                 nand-bus-width = <8>;
> --
> 1.8.5.1.163.gd7aced9
>
