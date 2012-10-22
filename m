From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 2/4] ARM/dts: omap5: Update I2C with address space and interrupts
Date: Mon, 22 Oct 2012 16:44:01 +0530
Message-ID: <CAM=Q2cuRyiPdv3xcfdh2uDWHtns24NgAgX1+D4hCoxwU+7mHiQ@mail.gmail.com>
References: <1350901328-3525-1-git-send-email-s-guiriec@ti.com>
	<1350901328-3525-3-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41269 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab2JVLOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 07:14:02 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3351243iea.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 04:14:01 -0700 (PDT)
In-Reply-To: <1350901328-3525-3-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Mon, Oct 22, 2012 at 3:52 PM, Sebastien Guiriec <s-guiriec@ti.com> wrote:
> Add base address and interrupt line inside Device Tree data for
> OMAP5
Looks good to me.
Thanks ,

Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 9e39f9f..6c22e1b 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -192,6 +192,8 @@
>
>                 i2c1: i2c@48070000 {
>                         compatible = "ti,omap4-i2c";
> +                       reg = <0x48070000 0x100>;
> +                       interrupts = <0 56 0x4>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c1";
> @@ -199,6 +201,8 @@
>
>                 i2c2: i2c@48072000 {
>                         compatible = "ti,omap4-i2c";
> +                       reg = <0x48072000 0x100>;
> +                       interrupts = <0 57 0x4>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c2";
> @@ -206,20 +210,26 @@
>
>                 i2c3: i2c@48060000 {
>                         compatible = "ti,omap4-i2c";
> +                       reg = <0x48060000 0x100>;
> +                       interrupts = <0 61 0x4>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c3";
>                 };
>
> -               i2c4: i2c@4807A000 {
> +               i2c4: i2c@4807a000 {
>                         compatible = "ti,omap4-i2c";
> +                       reg = <0x4807a000 0x100>;
> +                       interrupts = <0 62 0x4>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c4";
>                 };
>
> -               i2c5: i2c@4807C000 {
> +               i2c5: i2c@4807c000 {
>                         compatible = "ti,omap4-i2c";
> +                       reg = <0x4807c000 0x100>;
> +                       interrupts = <0 60 0x4>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c5";
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
