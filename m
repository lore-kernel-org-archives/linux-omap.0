From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] arm/dts: OMAP2+: Add mailbox nodes
Date: Thu, 24 May 2012 17:47:30 +0200
Message-ID: <4FBE5812.8020806@ti.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org> <1335894460-19941-3-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1335894460-19941-3-git-send-email-omar.luna@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

On 5/1/2012 7:47 PM, Omar Ramirez Luna wrote:
> Add nodes for mailbox DT, to interface with hwmods.
>
> Signed-off-by: Omar Ramirez Luna<omar.luna@linaro.org>

Acked-by: Benoit Cousson <b-cousson@ti.com>

> ---
>   arch/arm/boot/dts/omap2.dtsi |    5 +++++
>   arch/arm/boot/dts/omap3.dtsi |    5 +++++
>   arch/arm/boot/dts/omap4.dtsi |    5 +++++
>   3 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
> index f2ab4ea..2175cc3 100644
> --- a/arch/arm/boot/dts/omap2.dtsi
> +++ b/arch/arm/boot/dts/omap2.dtsi
> @@ -46,6 +46,11 @@
>   			#interrupt-cells =<1>;
>   		};
>
> +		mailbox: mailbox@48094000 {
> +			compatible = "ti,omap2-mailbox";
> +			ti,hwmods = "mailbox";
> +		};
> +
>   		uart1: serial@4806a000 {
>   			compatible = "ti,omap2-uart";
>   			ti,hwmods = "uart1";
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index c612135..540f6d6 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -69,6 +69,11 @@
>   			reg =<0x48200000 0x1000>;
>   		};
>
> +		mailbox: mailbox@48094000 {
> +			compatible = "ti,omap3-mailbox";
> +			ti,hwmods = "mailbox";
> +		};
> +
>   		uart1: serial@4806a000 {
>   			compatible = "ti,omap3-uart";
>   			ti,hwmods = "uart1";
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 3d35559..84f27dd 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -104,6 +104,11 @@
>   			<0x48240100 0x0100>;
>   		};
>
> +		mailbox: mailbox@4a0f4000 {
> +			compatible = "ti,omap4-mailbox";
> +			ti,hwmods = "mailbox";
> +		};
> +
>   		uart1: serial@4806a000 {
>   			compatible = "ti,omap4-uart";
>   			ti,hwmods = "uart1";

