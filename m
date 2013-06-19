From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: omap4-panda: Add USB Host support
Date: Wed, 19 Jun 2013 10:36:30 +0300
Message-ID: <51C15F7E.5020305@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com>
 <1371571487-14389-2-git-send-email-rogerq@ti.com> <51C106A1.9030001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51C106A1.9030001@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On 06/19/2013 04:17 AM, Benoit Cousson wrote:
> Hi Roger,
> 
> On 06/18/2013 11:04 AM, Roger Quadros wrote:
>> Provide the RESET and Power regulators for the USB PHY,
>> the USB Host port mode and the PHY device.
>>
>> Also provide pin multiplexer information for the USB host
>> pins.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4-panda-common.dtsi |   62 +++++++++++++++++++++++++++++
>>   1 files changed, 62 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> index 00cbaa5..7a21e8e 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> @@ -59,6 +59,42 @@
>>               "AFML", "Line In",
>>               "AFMR", "Line In";
>>       };
>> +
>> +    /* HS USB Port 1 RESET */
>> +    hsusb1_reset: hsusb1_reset_reg {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "hsusb1_reset";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        gpio = <&gpio2 30 0>;    /* gpio_62 */
>> +        startup-delay-us = <70000>;
>> +        enable-active-high;
>> +    };
> 
> Is this really a regulator? Or just a GPIO line used to reset the USB PHY?

It is in fact a GPIO line used as reset.
> 
> If this is the case, I don't think it should be represented as a regulator.

Why not? I think it fits very well in the regulator device model. I couldn't find a better
way to represent this. It gives us a way to specify not only the GPIO line but also
the polarity. I know mostly reset is active low but still there is flexibility as you never
know for sure.

Do you have any better ideas?

FYI. The USB PHY driver is already treating reset as a regulator and is into 3.10. Reworking that
will take some time. Not getting these in will prevent USB host/ethernet support on panda.

cheers,
-roger
