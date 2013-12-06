From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Fri, 6 Dec 2013 09:57:53 +0100
Message-ID: <CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51995 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab3LFI5z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 03:57:55 -0500
Received: by mail-wg0-f42.google.com with SMTP id a1so581531wgh.1
        for <linux-omap@vger.kernel.org>; Fri, 06 Dec 2013 00:57:54 -0800 (PST)
In-Reply-To: <1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

On Wed, Dec 4, 2013 at 1:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi | 102 ++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 298e85020e1b..51a79756e67e 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -409,3 +409,105 @@
>  &usbhsehci {
>         phys = <&hsusb1_phy>;
>  };
> +
> +&dpi {
> +       dpi_out: endpoint {
> +               remote-endpoint = <&tfp410_in>;
> +               data-lines = <24>;
> +       };
> +};
> +
> +&dsi1 {
> +       vdds_dsi-supply = <&vcxio>;
> +};
> +
> +&dsi2 {
> +       vdds_dsi-supply = <&vcxio>;
> +};
> +
> +&hdmi {
> +       vdda_hdmi_dac-supply = <&vdac>;
> +
> +       hdmi_out: endpoint {
> +               remote-endpoint = <&tpd12s015_in>;
> +       };
> +};
> +
> +/ {
> +       aliases {
> +               display0 = &dvi0;
> +               display1 = &hdmi0;
> +       };
> +
> +       tfp410: encoder@0 {
> +               compatible = "ti,tfp410";
> +               gpios = <&gpio1 0 0>;   /* 0, power-down */
> +

Please use the constants from include/dt-bindings/ instead of magic
numbers, i.e:

gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */

> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +
> +                               tfp410_in: endpoint@0 {
> +                                       remote-endpoint = <&dpi_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +
> +                               tfp410_out: endpoint@1 {
> +                                       remote-endpoint = <&dvi_connector_in>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       dvi0: connector@0 {
> +               compatible = "ti,dvi-connector";
> +               i2c-bus = <&i2c3>;
> +
> +               dvi_connector_in: endpoint {
> +                       remote-endpoint = <&tfp410_out>;
> +               };
> +       };
> +
> +       tpd12s015: encoder@1 {
> +               compatible = "ti,tpd12s015";
> +
> +               gpios = <&gpio2 28 0>,  /* 60, CT CP HPD */
> +                       <&gpio2 9 0>,   /* 41, LS OE */
> +                       <&gpio2 31 0>;  /* 63, HPD */
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +
> +                               tpd12s015_in: endpoint@0 {
> +                                       remote-endpoint = <&hdmi_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +
> +                               tpd12s015_out: endpoint@1 {
> +                                       remote-endpoint = <&hdmi_connector_in>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       hdmi0: connector@1 {
> +               compatible = "ti,hdmi-connector";
> +
> +               hdmi_connector_in: endpoint {
> +                       remote-endpoint = <&tpd12s015_out>;
> +               };
> +       };
> +};
> --
> 1.8.3.2
>

Best regards,
Javier
