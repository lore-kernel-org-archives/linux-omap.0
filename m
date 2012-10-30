From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RESEND/PATCHv3] arm: dts: omap5-evm: Add keypad support
Date: Tue, 30 Oct 2012 10:13:34 +0100
Message-ID: <508F9A3E.9020105@ti.com>
References: <1351507226-10328-1-git-send-email-sourav.poddar@ti.com> <508EB250.20607@ti.com> <508F64EC.9000809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <508F64EC.9000809@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

On 10/30/2012 6:26 AM, Sourav wrote:
> Hi Benoit,
> On Monday 29 October 2012 10:14 PM, Benoit Cousson wrote:
>> Hi Sourav,
>>
>> On 10/29/2012 11:40 AM, Sourav Poddar wrote:
>>> Add keypad data node in omap5-evm.
>>>
>>> Based on I2C support patch for omap5, which has been
>>> already posted as a different series.
>>>
>>> Tested on omap5430 evm with 3.7-rc1 kernel.
>>>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Tested on omap5430 sdp with 3.7-rc1 kernel.
>>>
>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>> ---
>>>   arch/arm/boot/dts/omap5-evm.dts |   95
>>> +++++++++++++++++++++++++++++++++++++++
>>>   1 files changed, 95 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap5-evm.dts
>>> b/arch/arm/boot/dts/omap5-evm.dts
>>> index c663eba..b812d6d 100644
>>> --- a/arch/arm/boot/dts/omap5-evm.dts
>>> +++ b/arch/arm/boot/dts/omap5-evm.dts
>>> @@ -140,3 +140,98 @@
>>>   &mcbsp3 {
>>>       status = "disabled";
>>>   };
>>> +
>>> +&i2c5 {
>>> +    clock-frequency = <400000>;
>>> +
>>> +    smsc@38 {
>>> +        compatible = "smscece1099";
>>> +        reg = <0x38>;
>>> +        clock = <0x13>;
>> What does that "clock" mean?
> This chip supports a clock control register which is used to enable the
> interface used by the chip to communicate. Here, the interface which you
> can are
> SMBUS interface or BC-LINK interface.

OK, so you should use a less generic name than "clock" and potentially 
prefix it with "smsc," since it is not a generic attribute at all.

BTW, cannot we use the CCF in order to control that clock? I guess it is 
just a clock mux?
Well, anyway we need CCF for OMAP to be merged first :-)

But it might worth highlighting this is a temporary solution.

>> I cannot find that in the binding documentation. BTW, did you add that
>> documentation in the driver patch?
> Nope, I missed out on the dt binding documentation for the driver. :(
>
> Will send a seperate patch for the bindings.

Thanks,
Benoit
