From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
Date: Thu, 15 Dec 2011 17:09:34 +0100
Message-ID: <4EEA1BBE.2090802@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com> <1323439361-1647-3-git-send-email-b-cousson@ti.com> <4EE8D5A1.2080100@gmail.com> <4EEA0CC5.4090602@ti.com> <4EEA16CB.6040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab1LOQJ5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 11:09:57 -0500
In-Reply-To: <4EEA16CB.6040708@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>

On 12/15/2011 4:48 PM, Rob Herring wrote:
> On 12/15/2011 09:05 AM, Cousson, Benoit wrote:

[...]

>> Or using some omap3-i2c or omap4-i2c to determine the proper version and
>> thus populate the right flags during probe.
>>
>
> If that's specific enough, then yes. I meant that if say only the
> omap3578 (making up numbers here) has errata i207, then define a
> compatible string "ti,omap3578-i2c" that implies that and possibly other
> flags.
>
> To put it another way, there are only N valid combinations of flags and
> N is probably fairly small as long as the flags are dictated by the i2c
> h/w rev or how it was integrated into a particular SOC. So you should
> have N compatible strings that reflect those valid combinations. The
> driver can still use the flags internally.
>
> For any flags that are in fact board level configuration, they should be
> broken out as individual properties. Most of these sound like they are
> properties of the h/w and not user configuration of the h/w.

Yes, indeed, I got the point. This is even much better for the 
implementation standpoint. The whole stuff is located inside the driver 
where it should belong.

>> [...]
>>
>>>> @@ -965,6 +956,31 @@ static const struct i2c_algorithm omap_i2c_algo = {
>>>>        .functionality    = omap_i2c_func,
>>>>    };
>>>>
>>>> +#ifdef CONFIG_OF
>>>> +static struct omap_i2c_bus_platform_data omap3_pdata = {
>>>> +    .rev = OMAP_I2C_IP_VERSION_1,
>>>> +};
>>>> +
>>>> +static struct omap_i2c_bus_platform_data omap4_pdata = {
>>>> +    .rev = OMAP_I2C_IP_VERSION_2,
>>>> +};
>>>
>>> This is redundant. The ip version can be determined from the compatible
>>> string.
>>
>> I'm confused...
>> I'm using the compatible string below to chose the proper value.
>> This flag is then used later at runtime.
>> I'm using a pseudo pdata because that driver is still used in old
>> platform that does and will never not have DT support.
>>
>
> After more thought, never mind. You'll probably need it for handling the
> flags as I proposed above.

Yes, I'm taking advantage of the existing pdata structure to provide the 
proper flags.

Thanks for that feedback,
Benoit

