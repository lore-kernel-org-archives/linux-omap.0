From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Add wakeup interrupt source for
 pixcir_i2c_ts
Date: Wed, 14 Oct 2015 14:42:41 +0530
Message-ID: <561E1C89.9080508@ti.com>
References: <1444801956-17817-1-git-send-email-vigneshr@ti.com>
 <561E165B.3000907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561E165B.3000907@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Gerlach, Dave" <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org



On 10/14/2015 02:16 PM, Roger Quadros wrote:

> 
> On 14/10/15 08:52, Vignesh R wrote:
>> On am437x-gp-evm, pixcir_i2c_ts can wakeup the system from lower power
>> state via pinctrl and IO daisy chain using generic wakeirq framework.
>> With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
>> interrupt in device tree") i2c core allows optional wakeirq to be
>> specified via device tree. Add wakeup irq entry to enable pixcir_i2c_ts
>> to wake the system from low power state.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  arch/arm/boot/dts/am437x-gp-evm.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
>> index 22038f21f228..69e93af7df0d 100644
>> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
>> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
>> @@ -581,8 +581,13 @@
>>  
>>  		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>>  
>> +		interrupts-extended = <&gpio3 22 GPIO_ACTIVE_HIGH>,
>> +				      <&am43xx_pinmux 0x264>;
> 
> How does this work?
> 
> interrupts-extended property must have
> 1) interrupt parent
> 2) interrupt number
> 3) interrupt flags
> 
> Your change doesn't seem to comply with those requirements.

AFAIU, interrupts-extended has two parts: interrupt parent phandle and
interrupt specifier.
The number of cells in interrupt specifier is determined by
interrupt-cells property of interrupt parent node.
In above case, gpio3 has interrupt-cells = 2 hence interrupt specifier
has interrupt number and interrupt flag field.
But in case am43xx_pinmux node, interrupt-cells is 1 hence has no
interrupt flag field.

-- 
Regards
Vignesh
