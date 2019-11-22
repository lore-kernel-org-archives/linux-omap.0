From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/1] ARM: dts: am5729: beaglebone-ai: adding device tree
Date: Fri, 22 Nov 2019 11:29:58 +0200
Message-ID: <a02ff0ca-f061-4d9e-977b-f41b52bbf18a@ti.com>
References: <20191119202850.18149-1-c-robey@ti.com>
 <20191119202850.18149-2-c-robey@ti.com>
 <8465b8c3-db4b-31fd-a299-3d5251ec99cf@ti.com>
 <12acbc1a96754fe68d7447b6ee99efd3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12acbc1a96754fe68d7447b6ee99efd3@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Robey, Caleb" <c-robey@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Jason Kridner <jkridner@gmail.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, "Kridner, Jason" <jdk@ti.com>, "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>, "Dannenberg, Andreas" <dannenberg@ti.com>, "Hiblot, Jean-Jacques" <jjhiblot@ti.com>, "Bajjuri, Praneeth" <praneeth@ti.com>, "Davis, Andrew" <afd@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 21/11/2019 16:41, Robey, Caleb wrote:
> 
> 
>> -----Original Message-----
>> From: Strashko, Grygorii
>> Sent: Thursday, November 21, 2019 5:05 AM
>> To: Robey, Caleb; linux-omap@vger.kernel.org
>> Cc: Jason Kridner; Vutla, Lokesh; Kridner, Jason; Rizvi, Mohammad Faiz
>> Abbas; Dannenberg, Andreas; Hiblot, Jean-Jacques; Bajjuri, Praneeth; Davis,
>> Andrew; Tom Rini; Robert Nelson; Rob Herring; Mark Rutland; Benoît
>> Cousson; Tony Lindgren; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/1] ARM: dts: am5729: beaglebone-ai: adding device
>> tree
>>
>>
>>
>> On 19/11/2019 22:28, Caleb Robey wrote:
>>> From: Jason Kridner <jdk@ti.com>
>>>
>>> BeagleBoard.org BeagleBone AI is an open source hardware single
>>> board computer based on the Texas Instruments AM5729 SoC featuring
>>> dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
>>> signal processor (DSP), quad-core embedded vision engine (EVE),
>>> Arm Cortex-M4 processors, dual programmable realtime unit
>>> industrial control subsystems and more. The board features 1GB
>>> DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
>>> 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
>>> headers.
>>>
>>> For more information, refer to:
>>> https://beaglebone.ai
>>
>>
>>>
>>> This patch introduces the BeagleBone AI device tree.
>>>
>>> Note that the device use the "ti,tpd12s016" component which is
>>> software compatible with "ti,tpd12s015". Thus we only use the
>>> latter driver.
>>>
>>> Signed-off-by: Jason Kridner <jdk@ti.com>
>>> Signed-off-by: Caleb Robey <c-robey@ti.com>
>>> Cc: Robert Nelson <robertcnelson@gmail.com>
>>>
>>> ---
>>>    arch/arm/boot/dts/Makefile                |   1 +
>>>    arch/arm/boot/dts/am5729-beagleboneai.dts | 782
>> ++++++++++++++++++++++
>>>    2 files changed, 783 insertions(+)
>>>    create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index b21b3a64641a..b1154dbda73c 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>
>> [..]
>>
>>> +
>>> +&uart1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&davinci_mdio {
>>> +	reset-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
>>> +	reset-delay-us = <2>;
>>> +
>>> +	phy0: ethernet-phy@1 {
>>> +		reg = <4>;
>>> +		compatible = "ethernet-phy-id004d.d072",
>>> +			"ethernet-phy-ieee802.3-c22";
>>
>> Pls, do not ignore my comments.
>>
>> Above compatible should not be required.
> 
> Grygori, I am so sorry about this - I had deleted this,
> but must have made a mistake in the resubmission. I
> will fix it immediately.
> 

Yep. thanks and sorry.
I saw you fixed it in next version.

-- 
Best regards,
grygorii
