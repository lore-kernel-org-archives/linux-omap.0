From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-uevm: Add Uart wakeup interrupt
Date: Fri, 15 May 2015 17:01:46 -0500
Message-ID: <55566CCA.5070701@ti.com>
References: <1431727161-16870-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431727161-16870-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/15/2015 04:59 PM, Nishanth Menon wrote:
> UART3 wakeup takes place with iodaisy chain. enable the wakeup pin.
> 
> Reported-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Test on linus master (f0897f4cc0fc) with 8250  driver: http://pastebin.ubuntu.com/11154446/
> 
> Applies on next-20150515 and linus master (f0897f4cc0fc)
> 
>  arch/arm/boot/dts/omap5-uevm.dts |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 74777a6e200a..214190796143 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -604,6 +604,8 @@
>  &uart3 {
>          pinctrl-names = "default";
>          pinctrl-0 = <&uart3_pins>;
> +	interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
I think I should have used WUGEN here! Sorry about that.. just noticed
in the log
308:        259          0       GIC 106 Level     serial

Sorry about that.
> +			      <&omap5_pmx_core 0x19c>;
>  };
>  
>  &uart5 {
> 


-- 
Regards,
Nishanth Menon
