From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: omap3-igep: remove VSIM regulator
Date: Wed, 19 Dec 2012 10:31:51 +0100
Message-ID: <CAAwP0s2oJCcvCgQ6UrcnLJpt7K7AdHhVWGOthhgc4v9AgmaHEQ@mail.gmail.com>
References: <1355532740-5956-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58171 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2LSJcM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 04:32:12 -0500
Received: by mail-oa0-f43.google.com with SMTP id k1so1771074oag.30
        for <linux-omap@vger.kernel.org>; Wed, 19 Dec 2012 01:32:11 -0800 (PST)
In-Reply-To: <1355532740-5956-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Sat, Dec 15, 2012 at 1:52 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> commit 5a8095e9 ARM: dts: Add omap3-beagle.dts
>
> moved the VSIM regulator definition to the twl4030.dtsi to avoid
> duplication. A definition for the VSIM regulator was also present
> on omap3-igep.dtsi which leads to the following build error:
>
> DTC     arch/arm/boot/dts/omap3-igep0020.dtb
> DTC     arch/arm/boot/dts/omap3-igep0030.dtb
> ERROR (duplicate_label): Duplicate label 'vsim' on /ocp/i2c@48070000/twl@48/regulator-vsim and /ocp/i2c@48070000/twl@48/regulator@10
> ERROR: Input tree has errors, aborting (use -f to force output)
> ERROR (duplicate_label): Duplicate label 'vsim' on /ocp/i2c@48070000/twl@48/regulator-vsim and /ocp/i2c@48070000/twl@48/regulator@10
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[1]: *** [arch/arm/boot/dts/omap3-igep0020.dtb] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/arm/boot/dts/omap3-igep0030.dtb] Error 2
> make: *** [dtbs] Error 2
>
> Since IGEP devices uses the same PMIC as Beagle boards, the VSIM
> definition from twl4030.dtsi can be used.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index 125fe00..de708ca 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -43,12 +43,6 @@
>                 interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>                 interrupt-parent = <&intc>;
>
> -               vsim: regulator@10 {
> -                       compatible = "ti,twl4030-vsim";
> -                       regulator-min-microvolt = <1800000>;
> -                       regulator-max-microvolt = <3000000>;
> -               };
> -
>                 twl_audio: audio {
>                         compatible = "ti,twl4030-audio";
>                         codec {

Hi Benoit,

It is ok for you that I send delta patches for the IGEP DT initial
support [1] such as this patch and the MMC device node mux pins setup
[2] or should I merge these changes and resend a new patch-set?

Thanks a lot and best regards,
Javier

[1]: https://lkml.org/lkml/2012/12/3/142
[2]: https://patchwork.kernel.org/patch/1882991/
