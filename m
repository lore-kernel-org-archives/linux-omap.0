From: Felix Brack <fb@ltec.ch>
Subject: Re: [PATCH: linux-next] ARM: dts: am33xx: Remove unnecessary
 properties
Date: Sat, 19 Jan 2019 18:38:21 +0100
Message-ID: <31a68b35-8b78-8fee-3dd9-5beb3c386247@ltec.ch>
References: <20181218143931.4151-1-fb@ltec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218143931.4151-1-fb@ltec.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Brack <fb@ltec.ch>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,
On 18.12.18 15:39, Felix Brack wrote:
> Remove the unnecessary properties #address-cells and #size-cells
> of node pinmux as there are no child-nodes with property reg.
> 
> Signed-off-by: Felix Brack <fb@ltec.ch>
> ---
>   arch/arm/boot/dts/am33xx-l4.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
> index 7b818d9d2eab..e957370f8aec 100644
> --- a/arch/arm/boot/dts/am33xx-l4.dtsi
> +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
> @@ -288,8 +288,6 @@
>   				am33xx_pinmux: pinmux@800 {
>   					compatible = "pinctrl-single";
>   					reg = <0x800 0x238>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
>   					#pinctrl-cells = <1>;
>   					pinctrl-single,register-width = <32>;
>   					pinctrl-single,function-mask = <0x7f>;
> 

Just a gentle ping. BTW: the patch applies not just to linux-next 
correctly but now also to linux.

regards Felix
