From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
Date: Thu, 15 Dec 2011 09:48:27 -0600
Message-ID: <4EEA16CB.6040708@gmail.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com> <1323439361-1647-3-git-send-email-b-cousson@ti.com> <4EE8D5A1.2080100@gmail.com> <4EEA0CC5.4090602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35514 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab1LOPsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 10:48:33 -0500
Received: by yenm11 with SMTP id m11so1550881yen.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 07:48:32 -0800 (PST)
In-Reply-To: <4EEA0CC5.4090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>

On 12/15/2011 09:05 AM, Cousson, Benoit wrote:
> Hi Rob,
> 
> On 12/14/2011 5:58 PM, Rob Herring wrote:
>> Benoit,
>>
>> On 12/09/2011 08:02 AM, Benoit Cousson wrote:
>>> Add initial DT support to retrieve the frequency using a
>>> DT attribute instead of the pdata pointer if of_node exist.
>>>
>>> Add documentation for omap i2c controller binding.
>>>
>>> Based on original patches from Manju and Grant.
>>>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Ben Dooks<ben-linux@fluff.org>
>>> ---
>>>   Documentation/devicetree/bindings/i2c/omap-i2c.txt |   42 ++++++++
>>>   drivers/i2c/busses/i2c-omap.c                      |  100
>>> +++++++++++++-------
>>>   2 files changed, 107 insertions(+), 35 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/omap-i2c.txt
>>> b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
>>> new file mode 100644
>>> index 0000000..d259a17
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
>>> @@ -0,0 +1,42 @@
>>> +I2C for OMAP platforms
>>> +
>>> +Required properties :
>>> +- compatible : Must be "ti,omap3-i2c" or "ti,omap4-i2c"
>>> +- ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
>>> +- #address-cells =<1>;
>>> +- #size-cells =<0>;
>>> +
>>> +Recommended properties :
>>> +- clock-frequency : Desired I2C bus clock frequency in Hz. Otherwise
>>> +  the default 100 kHz frequency will be used.
>>> +
>>> +Optional properties:
>>> +- Child nodes conforming to i2c bus binding
>>> +- ti,flags : u32: settings or errata relative to the i2c
>>> +    0x1:   OMAP_I2C_FLAG_NO_FIFO
>>> +    0x2:   OMAP_I2C_FLAG_SIMPLE_CLOCK
>>> +    0x4:   OMAP_I2C_FLAG_16BIT_DATA_REG
>>> +    0x8:   OMAP_I2C_FLAG_RESET_REGS_POSTIDLE
>>> +    0x10:  OMAP_I2C_FLAG_APPLY_ERRATA_I207
>>> +    0x20:  OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK
>>> +    0x40:  OMAP_I2C_FLAG_FORCE_19200_INT_CLK
>>> +  Valid for ti,omap3-i2c only:
>>> +    0x80:  OMAP_I2C_FLAG_BUS_SHIFT_1: 8 bits registers
>>> +    0x100: OMAP_I2C_FLAG_BUS_SHIFT_2: 16 bits registers
>>
>> It's generally preferred to split these out to separate properties since
>> there is not yet define capability in dts.
> 
> Yeah, I was hoping that Stephen's DTC patches were accepted to avoid that.
> 
>> Can some of these be removed
>> by having more specific compatible strings? That is the whole point in
>> having compatible strings not be generic. omap4-i2c and omap3-i2c is
>> still kind of generic.
> 
> Do you mean creating some attributes like that:
> 
> +    ti,16bits_shift;
> +    ti,reset_postidle;
> +    ti,errata_i207;
> 
> Or using some omap3-i2c or omap4-i2c to determine the proper version and
> thus populate the right flags during probe.
> 

If that's specific enough, then yes. I meant that if say only the
omap3578 (making up numbers here) has errata i207, then define a
compatible string "ti,omap3578-i2c" that implies that and possibly other
flags.

To put it another way, there are only N valid combinations of flags and
N is probably fairly small as long as the flags are dictated by the i2c
h/w rev or how it was integrated into a particular SOC. So you should
have N compatible strings that reflect those valid combinations. The
driver can still use the flags internally.

For any flags that are in fact board level configuration, they should be
broken out as individual properties. Most of these sound like they are
properties of the h/w and not user configuration of the h/w.


> [...]
> 
>>> @@ -965,6 +956,31 @@ static const struct i2c_algorithm omap_i2c_algo = {
>>>       .functionality    = omap_i2c_func,
>>>   };
>>>
>>> +#ifdef CONFIG_OF
>>> +static struct omap_i2c_bus_platform_data omap3_pdata = {
>>> +    .rev = OMAP_I2C_IP_VERSION_1,
>>> +};
>>> +
>>> +static struct omap_i2c_bus_platform_data omap4_pdata = {
>>> +    .rev = OMAP_I2C_IP_VERSION_2,
>>> +};
>>
>> This is redundant. The ip version can be determined from the compatible
>> string.
> 
> I'm confused...
> I'm using the compatible string below to chose the proper value.
> This flag is then used later at runtime.
> I'm using a pseudo pdata because that driver is still used in old
> platform that does and will never not have DT support.
> 

After more thought, never mind. You'll probably need it for handling the
flags as I proposed above.

Rob
