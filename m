From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] arm, am335x: add support for the bosch shc board
Date: Tue, 1 Dec 2015 06:19:53 +0100
Message-ID: <565D2DF9.2010806@denx.de>
References: <1447748655-2088-1-git-send-email-hs@denx.de>
 <20151130214130.GA23396@atomide.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151130214130.GA23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Robert Nelson <robertcnelson@gmail.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Georg.Soffel@bosch-si.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

Am 30.11.2015 um 22:41 schrieb Tony Lindgren:
> * Heiko Schocher <hs@denx.de> [151117 00:25]:
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am335x-shc.dts
>> +&tps {
>> +	compatible = "ti,tps65217";
>> +	ti,pmic-shutdown-controller;
>> +
>> +	regulators {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		dcdc1_reg: regulator@0 {
>> +			reg = <0>;
>> +			regulator-name = "vdds_dpr";
>> +			regulator-compatible = "dcdc1";
>> +			regulator-min-microvolt = <1300000>;
>> +			regulator-max-microvolt = <1450000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +		};
>> +
>> +		dcdc2_reg: regulator@1 {
>> +			reg = <1>;
>> +			/*
>> +			 * VDD_MPU voltage limits 0.95V - 1.26V with
>> +			 * +/-4% tolerance
>> +			 */
>> +			regulator-compatible = "dcdc2";
>> +			regulator-name = "vdd_mpu";
>> +			regulator-min-microvolt = <925000>;
>> +			regulator-max-microvolt = <1375000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +			regulator-ramp-delay = <70000>;
>> +		};
>> +
>> +		dcdc3_reg: regulator@2 {
>> +			reg = <2>;
>> +			/*
>> +			 * VDD_CORE voltage limits 0.95V - 1.1V with
>> +			 * +/-4% tolerance
>> +			 */
>> +			regulator-name = "vdd_core";
>> +			regulator-compatible = "dcdc3";
>> +			regulator-min-microvolt = <925000>;
>> +			regulator-max-microvolt = <1125000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +		};
>> +
>> +		ldo1_reg: regulator@3 {
>> +			reg = <3>;
>> +			regulator-name = "vio,vrtc,vdds";
>> +			regulator-compatible = "ldo1";
>> +			regulator-min-microvolt = <1000000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		ldo2_reg: regulator@4 {
>> +			reg = <4>;
>> +			regulator-name = "vdd_3v3aux";
>> +			regulator-compatible = "ldo2";
>> +			regulator-min-microvolt = <900000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		ldo3_reg: regulator@5 {
>> +			reg = <5>;
>> +			regulator-name = "vdd_1v8";
>> +			regulator-compatible = "ldo3";
>> +			regulator-min-microvolt = <900000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		ldo4_reg: regulator@6 {
>> +			reg = <6>;
>> +			regulator-name = "vdd_3v3a";
>> +			regulator-compatible = "ldo4";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-always-on;
>> +		};
>> +	};
>> +};
>
> Applying this into omap-for-v4.5/dt.. But I'm getting concerned about this
> "regulator-always-on" stuff and having multiple copies of the same thing.
>
> I think we should have a common am33xx-tps65217.dtsi file that has the
> regulators defined at one place and other then include it. And they are
> controllable AFAIK..

Hmm... Mark Brown (added to Cc) suggested to move this regulator nodes
into the board DT file and remove such files [1].

bye,
Heiko

[1] https://lkml.org/lkml/2015/10/21/581
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
