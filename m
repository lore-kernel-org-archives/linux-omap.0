From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: AM33xx: Add RNG node
Date: Tue, 6 Aug 2013 11:17:18 -0700
Message-ID: <CA+Bv8XZ0SqtCJQszrpVcRuksJU+GNBoJD7FaP+NuQrbshnnBpg@mail.gmail.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
	<1375777984-6267-4-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50969 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab3HFSRT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 14:17:19 -0400
In-Reply-To: <1375777984-6267-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, devicetree@vger.kernel.org, rob@landley.net, rnayak@ti.com, benoit.cousson@linaro.org

On Tue, Aug 6, 2013 at 1:33 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> Add the generic AM33xx RNG module's device tree data and
> enable it for the am335x-evm, am335x-evmsk, and am335x-bone
> platforms.  Also add Documentation file describing the data
> for the RNG module.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++++++++++
>  arch/arm/boot/dts/am335x-bone.dts                  |    4 ++++
>  arch/arm/boot/dts/am335x-evm.dts                   |    4 ++++
>  arch/arm/boot/dts/am335x-evmsk.dts                 |    4 ++++
>  arch/arm/boot/dts/am33xx.dtsi                      |    8 +++++++
>  5 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt
>
> diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> new file mode 100644
> index 0000000..6a62acd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> @@ -0,0 +1,22 @@
> +OMAP SoC HWRNG Module
> +
> +Required properties:
> +
> +- compatible : Should contain entries for this and backward compatible
> +  RNG versions:
> +  - "ti,omap2-rng" for OMAP2.
> +  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
> +  Note that these two versions are incompatible.
> +- ti,hwmods: Name of the hwmod associated with the RNG module
> +- reg : Offset and length of the register set for the module
> +- interrupts : the interrupt number for the RNG module.
> +               Only used for "ti,omap4-rng".
> +
> +Example:
> +/* AM335x */
> +rng: rng@48310000 {
> +       compatible = "ti,omap4-rng";
> +       ti,hwmods = "rng";
> +       reg = <0x48310000 0x2000>;
> +       interrupts = <111>;
> +};
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 444b4ed..46a3887 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -234,3 +234,7 @@
>         pinctrl-0 = <&davinci_mdio_default>;
>         pinctrl-1 = <&davinci_mdio_sleep>;
>  };
> +
> +&rng {
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 3aee1a4..ebfbebe1 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -488,3 +488,7 @@
>                 ti,adc-channels = <4 5 6 7>;
>         };
>  };
> +
> +&rng {
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index 0c8ad17..6610a05 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -402,3 +402,7 @@
>         phy_id = <&davinci_mdio>, <1>;
>         phy-mode = "rgmii-txid";
>  };
> +
> +&rng {
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..b1e6205 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -530,5 +530,13 @@
>                         #size-cells = <1>;
>                         status = "disabled";
>                 };
> +
> +               rng: rng@48310000 {
> +                       compatible = "ti,omap4-rng";
> +                       ti,hwmods = "rng";
> +                       reg = <0x48310000 0x2000>;
> +                       interrupts = <111>;
> +                       status = "disabled";

Is there any point in making this default to "disabled"? Are there any
am335x platforms where the trng doesn't function?

> +               };
>         };
>  };
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
