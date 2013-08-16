From: "Kozaruk, Oleksandr" <oleksandr.kozaruk@ti.com>
Subject: RE: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
Date: Fri, 16 Aug 2013 12:48:32 +0000
Message-ID: <2A7ABDFCE21540479A5AEB0244A684D5E3EEC2@DNCE04.ent.ti.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
 <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
 <520CB566.2050201@kernel.org>
 <20130815125906.GA32421@e106331-lin.cambridge.arm.com>
 <520D16EC.90604@kernel.org>
 <2A7ABDFCE21540479A5AEB0244A684D5E3EE9C@DNCE04.ent.ti.com>,
 <20130816085440.GF32421@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130816085440.GF32421@e106331-lin.cambridge.arm.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kim, Milo" <Milo.Kim@ti.com>, "lars@metafoo.de" <lars@metafoo.de>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak,
 Rajendra" <rnayak@ti.com>, "poeschel@lemonage.de" <poeschel@lemonage.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "ABRAHAM,
 KISHON VIJAY" <kishon@ti.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Krishnamoorthy,
 Balaji T" <balajitk@ti.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.or>
List-Id: linux-omap@vger.kernel.org

>On Fri, Aug 16, 2013 at 07:39:35AM +0100, Kozaruk, Oleksandr wrote:
>>>On 08/15/13 13:59, Mark Rutland wrote:
>>>> On Thu, Aug 15, 2013 at 12:03:02PM +0100, Jonathan Cameron wrote:
>>>>>
>>>>>>> The changes to the original driver:
>>>>>>> - device tree adaptation;
>>>>>>
>>>>>> I couldn't see a binding document in this series or in mainline. Have I
>>>>>> looked in the wrong places?
>>>>>
>>>>> Nothing explicit supplied, but does it need one given it is doing only
>>>>> iio bindings (bindings/iio/iio-bindings.txt)
>>>>> plus twl child bindings
>>>>> (bindings/mfd/twl-family.txt)
>>>>
>>>> Every binding needs to be documented.
>>>>
>>>>>
>>>>> If it does, I guess absolutely everything does, then fair enough!
>>>>> I guess that would make sense as there is no way for someone writing
>>>>> a device tree to know that there is nothing else to be specified.
>>>>
>>>> Yup, that's why. Also, Linux isn't necessarily the only consumer, and
>>>> other consumers shouldn't need to read Linux code to figure out how a
>>>> particular binding is supposed to look.
>>>>
>>>Fair enough. Thanks for clearing that up.
>>>
>>>Oleksandr, could you send a follow up patch adding the required documentation?
>>>(mostly a cut and paste job from similar elements by the look of it).
>>>
>>
>>Hello,
>>
>>Is this good enough?
>>
>>From 211e81ff4a146d9ec27443696a429e795c58dc30 Mon Sep 17 00:00:00 2001
>>From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
>>Date: Thu, 15 Aug 2013 16:14:11 +0300
>>Subject: [PATCH] iio: adc: Add bindigs documentation for twl6030 GPADC
>>
>>Add required documentation for twl6030 GPADC device tree
>>bindings.
>>
>>Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
>>---
>> .../devicetree/bindings/iio/adc/twl6030-gpadc.txt          | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
>>
>>diff --git a/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
>>new file mode 100644
>>index 0000000..6829420
>>--- /dev/null
>>+++ b/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
>>@@ -0,0 +1,14 @@
>>+Texas Instruments twl6030/twl6032 GPADC device driver
>>+
>>+Required properties:
>>+       - compatible: must be "ti,twl6030-gpadc" for TWL6030 or
>>+         "ti,twl6032-gpadc" for TWL6032
>>+       - interrupts: interrupt number associated with it
>>+       - #io-channel-cells: must be <1> - multiple IIO outputs
>
>There should be a desscription of valid values for the io-channel-cells
>as used by consumers.
>
>Otherwise, this looks fine.
>
>Thanks,
>Mark.
>
>> +
>> +Example:
>> +       adc {
>> +               compatible = "ti,twl6030-gpadc";
>> +               interrupts = <3>;
>> +               #io-channel-cells = <1>;
>> +       };
>> 

Hi Mark,

Thank you for the review.

Here is new version.

>From 167b0aab359a9c38dfb2fd11bc3f810d1c403952 Mon Sep 17 00:00:00 2001
From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Date: Thu, 15 Aug 2013 16:14:11 +0300
Subject: [PATCH] iio: adc: Add bindigs documentation for twl6030 GPADC

Add required documentation for twl6030 GPADC device tree
bindings.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 .../devicetree/bindings/iio/adc/twl6030-gpadc.txt  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
new file mode 100644
index 0000000..6cd3ef3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
@@ -0,0 +1,45 @@
+Texas Instruments twl6030/twl6032 GPADC device driver
+
+Required properties:
+	- compatible: must be "ti,twl6030-gpadc" for TWL6030 or
+	  "ti,twl6032-gpadc" for TWL6032
+	- interrupts: interrupt number associated with it
+	- #io-channel-cells: must be <1> - multiple IIO outputs are present
+	  iio consumers can use following io-channels:
+		twl6030:
+			0 - battery type
+			1 - battery temperature resistor value
+			2 - audio accessory/general purpose
+			3 - general purpose
+			4 - temperature/general purpose
+			5 - general purpose
+			6 - general purpose
+			7 - main battery
+			8 - backup battery
+			9 - charger input
+			10 - VBUS
+			11 - VBUS charging current
+			14 - USB ID
+		twl6032:
+			0 - battery type
+			1 - battery temperature resistor value
+			2 - audio accessory/general purpose
+			3 - temperature with external diode/general purpose
+			4 - temperature/general purpose
+			5 - general purpose
+			6 - general purpose
+			7 - system supply
+			8 - backup battery
+			9 - charger input
+			10 - VBUS
+			11 - VBUS charging current
+			14 - USB ID
+			17 - battery charging current
+			18 - battery voltage
+
+Example:
+	adc {
+		compatible = "ti,twl6030-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
-- 
1.8.1.2

Regards,
Sasha.
