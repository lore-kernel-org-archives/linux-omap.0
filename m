From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v6 1/4] Documentation: mfd: LP873X: Add information for
 the mfd driver
Date: Wed, 10 Aug 2016 08:26:01 +0530
Message-ID: <57AA97C1.8010004@ti.com>
References: <1470635218-15951-1-git-send-email-j-keerthy@ti.com>
 <1470635218-15951-2-git-send-email-j-keerthy@ti.com>
 <20160809125037.GE5243@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160809125037.GE5243@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, tony@atomide.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 09 August 2016 06:20 PM, Lee Jones wrote:
> On Mon, 08 Aug 2016, Keerthy wrote:
>
>> The lp873x series of PMICs have a bunch of regulators and a couple
>> of GPO(General Purpose Outputs).
>> Add information for the MFD and regulator drivers.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> These should be in chronological order.  Rob could not have Acked the
> patch before you sent it.
>
>> ---
>> Changes in v6:
>>
>>    * Added more formating for properties.
>>
>> Changes in v4:
>>
>>    * Added the GPIO properties.
>>
>> Changes in v3:
>>
>>    * Changed the example node lable to pmic from lp8733.
>>
>>   Documentation/devicetree/bindings/mfd/lp873x.txt | 59 ++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
>
> Patch looks good though.
>
> I'll fix the nit above.

Okay thanks.

>
> Applied, thanks.
>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> new file mode 100644
>> index 0000000..1377c25
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> @@ -0,0 +1,59 @@
>> +TI LP873X PMIC MFD driver
>> +
>> +Required properties:
>> +  - compatible:	"ti,lp8732", "ti,lp8733"
>> +  - reg:		I2C slave address.
>> +  - gpio-controller:	Marks the device node as a GPIO Controller.
>> +  - #gpio-cells:	Should be two.  The first cell is the pin number and
>> +			the second cell is used to specify flags.
>> +			See ../gpio/gpio.txt for more information.
>> +  - regulators:	List of child nodes that specify the regulator
>> +			initialization data.
>> +Example:
>> +
>> +pmic: lp8733@60 {
>> +	compatible = "ti,lp8733";
>> +	reg = <0x60>;
>> +	gpio-controller;
>> +	#gpio-cells = <2>;
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
