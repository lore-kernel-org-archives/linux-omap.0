From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 1/3] Documentation: mfd: LP873X: Add information for
 the mfd and regulator drivers
Date: Fri, 13 May 2016 04:51:34 +0530
Message-ID: <57350FFE.9030903@ti.com>
References: <1462853079-10708-1-git-send-email-j-keerthy@ti.com>
 <1462853079-10708-2-git-send-email-j-keerthy@ti.com>
 <20160512132140.GC1433@dell.open.watershed.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512132140.GC1433@dell.open.watershed.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org



On Thursday 12 May 2016 06:51 PM, Lee Jones wrote:
> On Tue, 10 May 2016, Keerthy wrote:
>
>> Add information for the mfd and regulator drivers.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/lp873x.txt | 55 ++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> new file mode 100644
>> index 0000000..3ef5ea0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> @@ -0,0 +1,55 @@
>> +TI LP3943 MFD driver
>> +
>> +Required properties:
>> +  - compatible: "ti,lp8732", "ti,lp8733"
>> +  - reg: I2C slave address.
>> +
>> +For the lp873x regulator properties please refer to:
>> +Documentation/devicetree/bindings/regulator/lp873x.txt
>
> This is a Linuxism.  Use ../bindings/.. instead.

Okay.

>
>> +Example:
>> +
>> +lp8733: lp8733@60 {
>
> lp8733 is not a device 'type'.  What does it do?
>
> Looks like a 'pmic' to me.
>
>> +	compatible = "ti,lp8733";
>> +	reg = <0x60>;
>> +
>> +	regulators {
>> +		lp8733_buck0: buck0 {
>> +			regulator-name = "lp8733-buck0";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <1400000>;
>> +			regulator-min-microamp = <1500000>;
>> +			regulator-max-microamp = <4000000>;
>> +			regulator-ramp-delay = <10000>;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +		};
>> +
>> +		lp8733_buck1: buck1 {
>> +			regulator-name = "lp8733-buck1";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <1400000>;
>> +			regulator-min-microamp = <1500000>;
>> +			regulator-max-microamp = <4000000>;
>> +			regulator-ramp-delay = <10000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +		};
>> +
>> +		lp8733_ldo0: ldo0 {
>> +			regulator-name = "lp8733-ldo0";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <3000000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +		};
>> +
>> +		lp8733_ldo1: ldo1 {
>> +			regulator-name = "lp8733-ldo1";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <3000000>;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +		};
>> +	};
>> +};
>
> I'm failing to see how this is an MFD?

As of now, only regulators part is supported, there are Configurable 
General Purpose Output Signals (GPO), Over-Temperature Warning and 
Protection apart from regulators.

>
