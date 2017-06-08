From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v3] mfd: lp87565: Add lp87565 PMIC support
Date: Thu, 8 Jun 2017 09:10:41 +0530
Message-ID: <0a5db53d-a875-ca31-2d40-0c6fa14be5c2@ti.com>
References: <1496150860-25919-1-git-send-email-j-keerthy@ti.com>
 <20170607211149.ozftwb5pqnso5xgk@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607211149.ozftwb5pqnso5xgk@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, lee.jones@linaro.org, t-kristo@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, afd@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 08 June 2017 02:41 AM, Rob Herring wrote:
> On Tue, May 30, 2017 at 06:57:40PM +0530, Keerthy wrote:
>> The LP87565 chip is a power management IC for Portable Navigation Systems
>> and Tablet Computing devices. It contains the following components:
>>
>>         - Configurable Bucks(Single and multi-phase).
>>         - Configurable General Purpose Output Signals (GPO).
>>
>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
>> output.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> The other patches are already pulled by Mark. Hence posting
>> the remaining patch.
>>
>> Changes in v3:
>>
>>   * Fixed License to GPL v2.
>>   * Fixed an indentation issue.
>>
>> Changes in v2:
>>
>>   * Fixed a bunch of whitespace errors.
>>   * Changed the License to short form.
>>   * Added the generic compatible lp87565
>>   * Removed i2c_device_id table.
>>   * Introduced probe_new function in place of probe.
>>
>>  Documentation/devicetree/bindings/mfd/lp87565.txt |  45 ++++
>>  drivers/mfd/Kconfig                               |  14 ++
>>  drivers/mfd/Makefile                              |   1 +
>>  drivers/mfd/lp87565.c                             |  92 ++++++++
>>  include/linux/mfd/lp87565.h                       | 270 ++++++++++++++++++++++
>>  5 files changed, 422 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>>  create mode 100644 drivers/mfd/lp87565.c
>>  create mode 100644 include/linux/mfd/lp87565.h
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
>> new file mode 100644
>> index 0000000..f63d568
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
>> @@ -0,0 +1,45 @@
>> +TI LP87565 PMIC MFD driver
>> +
>> +Required properties:
>> +  - compatible:	"ti,lp87565", "ti,lp87565-q1"
>> +  - reg:		I2C slave address.
>> +  - gpio-controller:	Marks the device node as a GPIO Controller.
>> +  - #gpio-cells:	Should be two.  The first cell is the pin number and
>> +			the second cell is used to specify flags.
>> +			See ../gpio/gpio.txt for more information.
>> +  - xxx-in-supply:	Phandle to parent supply node of each regulator
>> +			populated under regulators node. xxx should match
>> +			the supply_name populated in driver.
>> +  - regulators:	List of child nodes that specify the regulator
>> +			initialization data.
> 
> This is a node, not a property.

Okay

> 
>> +Example:
>> +
>> +lp87565_pmic: lp87565@60 {
> 
> pmic@60

Okay. I will fix that.

> 
>> +	compatible = "ti,lp87565-q1";
>> +	reg = <0x60>;
>> +	gpio-controller;
>> +	#gpio-cells = <2>;
>> +
>> +	buck10-in-supply = <&vsys_3v3>;
>> +	buck23-in-supply = <&vsys_3v3>;
>> +
>> +	regulators: regulators {
>> +		buck10_reg: buck10 {
>> +			/* VDD_MPU */
>> +			regulator-name = "buck10";
>> +			regulator-min-microvolt = <850000>;
>> +			regulator-max-microvolt = <1250000>;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +		};
>> +
>> +		buck23_reg: buck23 {
>> +			/* VDD_GPU */
>> +			regulator-name = "buck23";
>> +			regulator-min-microvolt = <850000>;
>> +			regulator-max-microvolt = <1250000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +		};
>> +	};
>> +};
