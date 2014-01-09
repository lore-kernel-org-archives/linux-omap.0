From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 1/2] ARM: dts: Add omap specific pinctrl defines to
 use padconf addresses
Date: Thu, 09 Jan 2014 20:51:34 +0100
Message-ID: <52CEFDC6.4010408@epfl.ch>
References: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com> <1387554677-21100-2-git-send-email-laurent.pinchart@ideasonboard.com> <20140107223021.GA5074@atomide.com> <1562680.iFW31kAxBU@avalon> <20140107232018.GE5074@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:48396 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbaAITwZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 14:52:25 -0500
In-Reply-To: <20140107232018.GE5074@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, Sakari Ailus <sakari.ailus@iki.fi>

Hi Tony,

On 01/08/2014 12:20 AM, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140107 15:10]:
>> Hi Tony,
>>
>> On Tuesday 07 January 2014 14:30:21 Tony Lindgren wrote:
>>> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131220 07:52]:
>>>> From: Tony Lindgren <tony@atomide.com>
>>>> +/*
>>>> + * Macros to allow using the absolute physical address instead of the
>>>> + * padconf registers instead of the offset from padconf base.
>>>> + */
>>>> +#define OMAP_IOPAD_OFFSET(pa, offset)	(((pa) & 0xffff) - (offset))
>>>> +
>>>> +#define OMAP2420_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0030)
>>>> (val)
>>>> +#define OMAP2430_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030)
>>>> (val)
>>>> +#define OMAP3_CORE1_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
>>>> +#define OMAP3_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25a0) (val)
>>>
>>> Sorry for the delay on these, I'm only now getting back to looking
>>> at all the emails since the holidays :)
>>>
>>> After looking at Nishant's omap3 pinctrl core2 patch, looks like we need
>>> to have separate OMAP3430_CORE2_IOPAD and OMAP3630_CORE2_IOPAD defines.
>>
>> That was my first impression as well, but I think we actually don't need to. 
>> The OMAP3430 just has no useful registers in the 0x25a0 - 0x25d7 area, so we 
>> can make the CORE2 macro span that for both 3430 and 3630.
> 
> Hmm well I already did it :) In general my gut feeling is along the lines
> what you're saying, I think the padconf registers are all there on all
> omap3 SoCs, but only some of the padconf registers are used depending on
> the SoC revision and package.
> 
> Anyways, it should not hurt to have the padconf registers defined the
> same way as the documentation has them, at least we may get some extra
> warnings if people try to configure unused registers for 3430.
>  

I can see one downside to this approach; if you update the revision of
your processor from omap34xx to omap36xx, and if you are using pins from
the overlapping range [0x25d8; 0x25fc], you will have to update all the
macros, instead of simply updating the #include statement.

Let me introduce a real-life example. I am using Overo products. The
processor board must be stacked onto an expansion board. I currently
have only one include file for the processor board (omap3-overo.dtsi).
But in reality, Gumstix is currently selling 14 models, with
pin-compatible processors (omap35x3, dm3730, am3703) [1].

So I #include omap34xx.dtsi (to be compatible with the omap35x3 models).
The range [0x25d8; 0x25fc] defines a number of used features (hsusb2,
gpios). To update to newer versions, I have to change the #include, but
also all the OMAP3430_CORE2_IOPAD() macros spread across the expansion
boards (omap3-tobi + future expansion boards, see my series from today).
Even if the newer models do not use the omap36xx-specific features.

Obviously, I currently do not have a straightforward way to support all
the models/revisions with one single file. But if a solution is found in
the future, it will be far easier if the expansions boards do not depend
on the exact processor with such macros.

Regards,

Florian

[1] https://store.gumstix.com/index.php/category/33/
