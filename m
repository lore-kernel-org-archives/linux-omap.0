From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
Date: Wed, 28 Sep 2011 13:23:14 -0500
Message-ID: <4E836612.2010709@freescale.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>	<1317055821-20652-3-git-send-email-b-cousson@ti.com>	<4E8161C7.7020404@ti.com> <4E82D7B3.6080909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:59747
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754463Ab1I1SXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Sep 2011 14:23:31 -0400
In-Reply-To: <4E82D7B3.6080909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

On 09/28/2011 03:15 AM, Cousson, Benoit wrote:
> On 9/27/2011 7:40 AM, Nayak, Rajendra wrote:
>> On Monday 26 September 2011 10:20 PM, Benoit Cousson wrote:
>>> +Required properties:
>>> +- compatible:
>>> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
>>
>> Would it be more readable to have
>> "ti,omap2-gpio" for OMAP2 controllers and
>> "ti,omap3-gpio" for OMAP3 controllers?

Or have OMAP3 say this if it's fully backwards compatible:

	compatible = "ti,omap3-gpio", "ti,omap2-gpio";

>>> +  - "ti,omap4-gpio" for OMAP4 controller
>>> +- #gpio-cells : Should be two.
>>> +  - first cell is the pin number
>>> +  - second cell is used to specify optional parameters (unused)
>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>> +
>>> +OMAP specific properties:
>>> +- ti,hwmods: Name of the hwmod associated to the GPIO
>>> +- id: 32 bits to identify the id (1 based index)

What does "the id" mean, in relation to the actual hardware?

Some existing bindings have such a thing (often called "cell-index"),
but it should be well-defined what it refers to.  Often aliases would be
a better approach, if it just refers to what the manual calls the device.

>>> +- bank-width: number of pin supported by the controller (16 or 32)
>>> +- debounce: set if the controller support the debouce funtionnality
>>> +- bank-count: number of controller support by the SoC. This is a
>>> temporary
>>> +  hack until the bank_count is removed from the driver.
>>
>> Is there a general rule to be followed as to when to use
>> "ti,<prop-name>" and when to use just"<prop-name>".
>> Since all these are OMAP specific properties, shouldn't all
>> of them be "ti,<prop-name>"?
> 
> To be honest, I was wondering as well about this rule.
> I think that a property that is not purely OMAP specific and that
> represents some standard HW information does not have to be prefixed by
> "ti,XXX".
> So hwmods must be "ti,hwmods", but bank-witdh and bank-count seems to me
> quite generic.

It's about where the property is documented.  Suppose you use an
un-prefixed bank-width but define it in the TI-specific binding to mean
width in bits.  Later, someone wants something similar for another
driver, doesn't look at the TI binding, but says, "This is generic, I'll
define something in the main gpio binding," but defines it as width in
bytes (ignore the (de)merits of defining it that way in this case).  If
you had a namespace prefix, it would be clear which binding a node is
referring to.

As for bank-count, the description "this is a temporary hack until the
bank_count is removed from the driver" suggests it shouldn't be there at
all, much less be part of the generic binding.

-Scott

