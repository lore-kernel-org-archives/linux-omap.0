From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/5] ARM: dts: OMAP2+: create a DT header for GPIO
Date: Wed, 22 May 2013 10:03:26 -0600
Message-ID: <519CEC4E.2060208@wwwdotorg.org>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch> <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch> <519CE3BB.3040704@wwwdotorg.org> <20130522153452.GZ10378@atomide.com> <519CEBA0.1080103@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56545 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab3EVQDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 12:03:30 -0400
In-Reply-To: <519CEBA0.1080103@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 05/22/2013 10:00 AM, Florian Vaussard wrote:
> Hello Stephan, Tony,
> 
> Thank you for your reviews.
> 
> On 05/22/2013 05:34 PM, Tony Lindgren wrote:
>> * Stephen Warren <swarren@wwwdotorg.org> [130522 08:32]:
>>> On 05/22/2013 08:27 AM, Florian Vaussard wrote:
>>>> Define the OMAP_GPIO macro to conveniently use GPIO inside OMAP DT.
>>>> For example:
>>>>
>>>>     gpios = <&gpio6 3 0>;  /* GPIO 163 */
>>>>
>>>> can be replaced by
>>>>
>>>>     gpios = OMAP_GPIO(163, 0);
>>>
>>>> diff --git a/include/dt-bindings/gpio/omap-gpio.h
>>>> b/include/dt-bindings/gpio/omap-gpio.h
>>>
>>>> +#define OMAP_GPIO_0_BANK        gpio1
>>>> +#define OMAP_GPIO_1_BANK        gpio1
>>>> +#define OMAP_GPIO_2_BANK        gpio1
>>>> +#define OMAP_GPIO_3_BANK        gpio1
>>>
>>> There are a /lot/ of those. Is this really worth it?
...
> From a board point a view, I consider this macro as being easier to use,
> than having to perform the necessary arithmetic to get the bank + offset
> for each GPIO when converting existing boards or developing new ones.
> 
> But I also agree with you, and I was sad not to find a more elegant
> way. Maybe someone with better preprocessor skills could come up with
> a better solution?

I did a quick bit of searching before, and while cpp is certainly
capable of doing the shifting/masking required to calculate the bank ID
directly, I don't think it's capable of constructing the symbol gpio1 as
opposed to the string "gpio1":-( I'd love to be proven wrong though, but
the torture e.g. cpp "99 bottles of beer on the wall" goes through to
stuff implies it isn't possible.
