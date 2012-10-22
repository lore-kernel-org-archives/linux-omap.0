From: Sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH 3/4] ARM/dts: omap5: Update UART with address space and
 interrupts
Date: Mon, 22 Oct 2012 16:46:09 +0530
Message-ID: <50852AF9.10703@ti.com>
References: <1350901328-3525-1-git-send-email-s-guiriec@ti.com> <1350901328-3525-4-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60835 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab2JVLPz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 07:15:55 -0400
In-Reply-To: <1350901328-3525-4-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Sebastien,
On Monday 22 October 2012 03:52 PM, Sebastien Guiriec wrote:
> Add base address and interrupt line inside Device Tree data for
Incomplete sentence!
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 6c22e1b..413df94 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -237,36 +237,48 @@
>   
>   		uart1: serial@4806a000 {
>   			compatible = "ti,omap4-uart";
> +			reg = <0x4806a000 0x100>;
> +			interrupts = <0 72 0x4>;
>   			ti,hwmods = "uart1";
>   			clock-frequency = <48000000>;
>   		};
>   
>   		uart2: serial@4806c000 {
>   			compatible = "ti,omap4-uart";
> +			reg = <0x4806c000 0x100>;
> +			interrupts = <0 73 0x4>;
>   			ti,hwmods = "uart2";
>   			clock-frequency = <48000000>;
>   		};
>   
>   		uart3: serial@48020000 {
>   			compatible = "ti,omap4-uart";
> +			reg = <0x48020000 0x100>;
> +			interrupts = <0 74 0x4>;
>   			ti,hwmods = "uart3";
>   			clock-frequency = <48000000>;
>   		};
>   
>   		uart4: serial@4806e000 {
>   			compatible = "ti,omap4-uart";
> +			reg = <0x4806e000 0x100>;
> +			interrupts = <0 70 0x4>;
>   			ti,hwmods = "uart4";
>   			clock-frequency = <48000000>;
>   		};
>   
>   		uart5: serial@48066000 {
> -			compatible = "ti,omap5-uart";
> +			compatible = "ti,omap4-uart";
> +			reg = <0x48066000 0x100>;
> +			interrupts = <0 105 0x4>;
In Omap5 TRM, the interrupt number mentioned for uart5 is 138. How is 
105 coming?
>   			ti,hwmods = "uart5";
>   			clock-frequency = <48000000>;
>   		};
>   
>   		uart6: serial@48068000 {
> -			compatible = "ti,omap6-uart";
> +			compatible = "ti,omap4-uart";
> +			reg = <0x48068000 0x100>;
> +			interrupts = <0 106 0x4>;
Same here, TRM shows this number to be 139 ?
>   			ti,hwmods = "uart6";
>   			clock-frequency = <48000000>;
>   		};

