From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH 09/11] arm64: exynos: Add bus1 pinctrl node on exynos7
Date: Sat, 22 Nov 2014 19:11:25 +0530
Message-ID: <CAGOxZ53TUvZhSDLfeCuyvBwVcrkQhFnftQzk1DbkU_krdoFbZA@mail.gmail.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com> <1416576954-11997-10-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416576954-11997-10-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, devicetree@vger.kernel.org, balbi <balbi@ti.com>, kishon <kishon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, gregkh@linuxfoundation.org, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, robh+dt <robh+dt@kernel.org>, stern <stern@rowland.harvard.edu>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Vivek,

On Fri, Nov 21, 2014 at 7:05 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> BUS1 pinctrl provides gpios for usb and power regulator
> available on exynos7-espresso board. So add relevant device
> node for pinctrl-bus1.
>
> Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |   26 +++++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 ++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> index 2eef4a2..9648e03 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> @@ -335,6 +335,32 @@
>         };
>  };
>
> +&pinctrl_bus1 {
> +       gpf0: gpf0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpf4: gpf4 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gph1: gph1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +};
> +
See my comment on patch 01/11, accordingly you can modify this.

>  &pinctrl_nfc {
>         gpj0: gpj0 {
>                 gpio-controller;
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index d7a37c3..90048b2 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -26,6 +26,7 @@
>                 pinctrl5 = &pinctrl_ese;
>                 pinctrl6 = &pinctrl_fsys0;
>                 pinctrl7 = &pinctrl_fsys1;
> +               pinctrl8 = &pinctrl_bus1;
>         };
>
>         cpus {
> @@ -242,6 +243,12 @@
>                         interrupts = <0 383 0>;
>                 };
>
> +               pinctrl_bus1: pinctrl@14870000 {
> +                       compatible = "samsung,exynos7-pinctrl";
> +                       reg = <0x14870000 0x1000>;
> +                       interrupts = <0 384 0>;
> +               };
> +
>                 pinctrl_nfc: pinctrl@14cd0000 {
>                         compatible = "samsung,exynos7-pinctrl";
>                         reg = <0x14cd0000 0x1000>;
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
