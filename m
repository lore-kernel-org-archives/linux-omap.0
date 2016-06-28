From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v3 02/10] Documentation: regulator: tps65218: Update
 examples
Date: Tue, 28 Jun 2016 13:15:14 +0530
Message-ID: <57722B0A.2070706@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-3-git-send-email-j-keerthy@ti.com>
 <20160628065950.GE6720@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160628065950.GE6720@dell>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 28 June 2016 12:29 PM, Lee Jones wrote:
> This is a more common format for DT bindings:
>
>    dt-bindings: regulator:
>
> On Tue, 28 Jun 2016, Keerthy wrote:
>> This updates the device tree according to the preferred way of parsing
>
> Nit: Device Tree

Okay.

>
>> the nodes using the regulator framework.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../devicetree/bindings/regulator/tps65218.txt     | 87 ++++++++++++++++++----
>>   1 file changed, 71 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
>> index fccc1d2..5e1888f 100644
>> --- a/Documentation/devicetree/bindings/regulator/tps65218.txt
>> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
>> @@ -1,23 +1,78 @@
>>   TPS65218 family of regulators
>>
>>   Required properties:
>> -For tps65218 regulators/LDOs
>> -- compatible:
>> -  - "ti,tps65218-dcdc1" for DCDC1
>> -  - "ti,tps65218-dcdc2" for DCDC2
>> -  - "ti,tps65218-dcdc3" for DCDC3
>> -  - "ti,tps65218-dcdc4" for DCDC4
>> -  - "ti,tps65218-dcdc5" for DCDC5
>> -  - "ti,tps65218-dcdc6" for DCDC6
>> -  - "ti,tps65218-ldo1" for LDO1
>> -
>> -Optional properties:
>> -- Any optional property defined in bindings/regulator/regulator.txt
>> +- compatible: "ti,tps65218"
>> +- reg: I2C slave address
>
> '\n' here for clarity.

Okay.

>
>> +- list of regulators provided by this controller, must be named
>
> Sentences start with an uppercase char.

Okay.

>
>> +  after their hardware counterparts: dcdc[1-6] and ldo1
>> +- This is the list of child nodes that specify the regulator
>> +  initialization data for defined regulators. Not all regulators for the given
>> +  device need to be present. The definition for each of these nodes is defined
>> +  using the standard binding for regulators found at
>> +  Documentation/devicetree/bindings/regulator/regulator.txt.
>
> Use relative path names for brevity.

Okay.

>
> ./regulator.txt
>
>> +  The valid names for regulators are:
>> +  tps65217: regulator-dcdc1, regulator-dcdc2, regulator-dcdc3, regulator-dcdc4,
>> +  regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3
>> +  Each regulator is defined using the standard binding for regulators.
>>
>>   Example:
>> +tps65218: tps65218@24 {
>
> Is this label used?

Yes. This can be used in the dts files.

>
>> +	reg = <0x24>;
>> +	compatible = "ti,tps65218";
>> +	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>
> [...]
>
