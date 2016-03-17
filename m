From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v5 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Thu, 17 Mar 2016 10:53:57 -0500
Message-ID: <56EAD315.1030307@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-7-git-send-email-fcooper@ti.com>
 <20160317151147.GA29802@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20160317151147.GA29802@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: thierry.reding@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
List-Id: linux-omap@vger.kernel.org



On 03/17/2016 10:11 AM, Rob Herring wrote:
> On Mon, Mar 07, 2016 at 07:23:44PM -0600, Franklin S Cooper Jr wrote:
>> From: Vignesh R <vigneshr@ti.com>
>>
>> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
>> for dt bindings.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> [fcooper@ti.com: Add eCAP and use updated bindings for PWMSS and ePWM]
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>> Version 5 changes:
>> Add DT node for eCAP and update eCAP binding documentation
>>
>> Version 4 changes:
>> Updated link to the latest documentation
>>
>>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
>>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
>>  .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
>>  arch/arm/boot/dts/dra7.dtsi                        | 84 ++++++++++++++++++++++
>>  4 files changed, 116 insertions(+), 1 deletion(-)
>
>> +			ehrpwm1: pwm@48440200 {
>> +				compatible = "ti,dra7xx-ehrpwm",
>> +					     "ti,am33xx-ehrpwm";
>> +				#pwm-cells = <3>;
>> +				reg = <0x48440200 0x80>;
>> +				clocks = <&ehrpwm1_tbclk>;
>> +				clock-names = "tbclk";
>> +				status = "disabled";
>> +			};
>> +
>> +			ecap1: ecap@48440100 {
> This also is a PWM? Then it should also be pwm@...

The enhanced capture module primary purpose is to measure
time between external signals which is called capture mode.
It also has a PWM mode. So I wouldn't recommend generalizing
the entire node to pwm.
>
>> +				compatible = "ti,dra7xx-ecap",
>> +					     "ti,am33xx-ecap";
>> +				#pwm-cells = <3>;
>> +				reg = <0x48440100 0x80>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		epwmss2: epwmss@48442000 {
>> +			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
>> +			reg = <0x48442000 0x30>;
>> +			ti,hwmods = "epwmss2";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			status = "disabled";
>> +			ranges;
>> +
>> +			ehrpwm2: pwm@48442200 {
>> +				compatible = "ti,dra7xx-ehrpwm",
>> +					     "ti,am33xx-ehrpwm";
>> +				#pwm-cells = <3>;
>> +				reg = <0x48442200 0x80>;
>> +				clocks = <&ehrpwm2_tbclk>;
>> +				clock-names = "tbclk";
>> +				status = "disabled";
>> +			};
>> +
>> +			ecap2: ecap@48442100 {
> And here.
>
>> +				compatible = "ti,dra7xx-ecap",
>> +					     "ti,am33xx-ecap";
>> +				#pwm-cells = <3>;
>> +				reg = <0x48442100 0x80>;
>> +				status = "disabled";
>> +			};
>> +		};
>>  	};
>>  
>>  	thermal_zones: thermal-zones {
>> -- 
>> 2.7.0
>>
