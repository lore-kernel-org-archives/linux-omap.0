From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for am330x and
 am43xx
Date: Mon, 22 Jul 2019 09:27:09 -0500
Message-ID: <8427af44-2e28-7e13-3841-15c89d60f6dd@lechnology.com>
References: <20190326181324.32140-1-tony@atomide.com>
 <20190326181324.32140-2-tony@atomide.com>
 <0af63198-5a68-2f0d-f14e-2b514580d2d5@lechnology.com>
 <20190722060951.GL5447@atomide.com> <20190722075411.GM5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190722075411.GM5447@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 7/22/19 2:54 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [190722 06:10]:
>> * David Lechner <david@lechnology.com> [190721 02:43]:
>>> On 3/26/19 1:13 PM, Tony Lindgren wrote:
>>>> We can now drop legacy platform data one interconnect target module at
>>>> a time in favor of the device tree based data that has been added earlier.
>>>>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>> ---
>>>
>>> This breaks wifi on BeagleBone Blue (found via git bisect). In dmesg, I see:
>>>
>>>      platform 47810000.mmc: Cannot lookup hwmod 'mmc3'
>>
>> Thanks for letting me know and sorry for breaking it.
>>
>>> How can we fix it?
>>
>> The warning you pasted above hints that we're still trying to
>> probe mmc3 using platform data, and that data no longer exists.
>>
>> Looks like I've completely missed updating the dts file for
>> mmc3 that is directly on the l3 interconnect instead of l4 like
>> all the other mmc instances. The same applies for am4 too, and
>> I've also left some "ti,hwmods" properties around too..
>>
>> Care to try the following patch and see if it fixes the issue
>> for you?
> 
> Oh I just noticed this needs to be fixed in v5.2, not in v5.3-rc
> series. It's best to keep the "ti,hwmods" property still around
> as there may be dependencies to ti-sysc driver changes in v5.3-rc
> series for dropping it. Below is a more minimal fix to try.
> 
> Regards,
> 
> Tony
> 
> 8< -------------
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -234,13 +234,33 @@
>   			interrupt-names = "edma3_tcerrint";
>   		};
>   
> -		mmc3: mmc@47810000 {
> -			compatible = "ti,omap4-hsmmc";
> +		target-module@47810000 {
> +			compatible = "ti,sysc-omap2", "ti,sysc";
>   			ti,hwmods = "mmc3";
> -			ti,needs-special-reset;
> -			interrupts = <29>;
> -			reg = <0x47810000 0x1000>;
> -			status = "disabled";
> +			reg = <0x478102fc 0x4>,
> +			      <0x47810110 0x4>,
> +			      <0x47810114 0x4>;
> +			reg-names = "rev", "sysc", "syss";
> +			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> +					 SYSC_OMAP2_ENAWAKEUP |
> +					 SYSC_OMAP2_SOFTRESET |
> +					 SYSC_OMAP2_AUTOIDLE)>;
> +			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>;
> +			ti,syss-mask = <1>;
> +			clocks = <&l3s_clkctrl AM3_L3S_MMC3_CLKCTRL 0>;
> +			clock-names = "fck";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x47810000 0x1000>;
> +
> +			mmc3: mmc@0 {
> +				compatible = "ti,omap4-hsmmc";
> +				ti,needs-special-reset;
> +				interrupts = <29>;
> +				reg = <0x0 0x1000>;
> +			};
>   		};
>   
>   		usb: usb@47400000 {
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -228,13 +228,33 @@
>   			interrupt-names = "edma3_tcerrint";
>   		};
>   
> -		mmc3: mmc@47810000 {
> -			compatible = "ti,omap4-hsmmc";
> -			reg = <0x47810000 0x1000>;
> +		target-module@47810000 {
> +			compatible = "ti,sysc-omap2", "ti,sysc";
>   			ti,hwmods = "mmc3";
> -			ti,needs-special-reset;
> -			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> -			status = "disabled";
> +			reg = <0x478102fc 0x4>,
> +			      <0x47810110 0x4>,
> +			      <0x47810114 0x4>;
> +			reg-names = "rev", "sysc", "syss";
> +			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
> +					 SYSC_OMAP2_ENAWAKEUP |
> +					 SYSC_OMAP2_SOFTRESET |
> +					 SYSC_OMAP2_AUTOIDLE)>;
> +			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>;
> +			ti,syss-mask = <1>;
> +			clocks = <&l3s_clkctrl AM4_L3S_MMC3_CLKCTRL 0>;
> +			clock-names = "fck";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x47810000 0x1000>;
> +
> +			mmc3: mmc@0 {
> +				compatible = "ti,omap4-hsmmc";
> +				ti,needs-special-reset;
> +				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x1000>;
> +			};
>   		};
>   
>   		sham: sham@53100000 {
> 

This fixes wifi on BeagleBone Blue for me in v5.2.

Tested-by: David Lechner <david@lechnology.com>
