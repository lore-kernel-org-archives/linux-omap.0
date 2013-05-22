From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 2/5] ARM: dts: OMAP2+: create a DT header for GPIO
Date: Wed, 22 May 2013 18:00:32 +0200
Message-ID: <519CEBA0.1080103@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch> <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch> <519CE3BB.3040704@wwwdotorg.org> <20130522153452.GZ10378@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:46066 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753956Ab3EVQAh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 12:00:37 -0400
In-Reply-To: <20130522153452.GZ10378@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello Stephan, Tony,

Thank you for your reviews.

On 05/22/2013 05:34 PM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [130522 08:32]:
>> On 05/22/2013 08:27 AM, Florian Vaussard wrote:
>>> Define the OMAP_GPIO macro to conveniently use GPIO inside OMAP DT.
>>> For example:
>>>
>>> 	gpios = <&gpio6 3 0>;  /* GPIO 163 */
>>>
>>> can be replaced by
>>>
>>> 	gpios = OMAP_GPIO(163, 0);
>>
>>> diff --git a/include/dt-bindings/gpio/omap-gpio.h b/include/dt-bindings/gpio/omap-gpio.h
>>
>>> +#define OMAP_GPIO_0_BANK        gpio1
>>> +#define OMAP_GPIO_1_BANK        gpio1
>>> +#define OMAP_GPIO_2_BANK        gpio1
>>> +#define OMAP_GPIO_3_BANK        gpio1
>>
>> There are a /lot/ of those. Is this really worth it?
>>
>> If the OMAP GPIO HW is already represented as a bunch of separate DT
>> nodes which represent separate GPIO blocks, then I would have thought
>> the syntax <&gpioN M 0> more directly represents what would be found in
>> the HW manual? If not, surely the DT should have a single node to
>> represent a single GPIO controller, which just happens to internally
>> support a bunch of register arrays.
>
> Yes I agree, let's not go back to numbering anything except within the
> a single instance. If anything, we can put the gpio number into comments.
>

 From a board point a view, I consider this macro as being easier to use,
than having to perform the necessary arithmetic to get the bank + offset
for each GPIO when converting existing boards or developing new ones.

But I also agree with you, and I was sad not to find a more elegant
way. Maybe someone with better preprocessor skills could come up with
a better solution?

Regards,

Florian
