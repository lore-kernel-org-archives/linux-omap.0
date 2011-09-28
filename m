From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
Date: Wed, 28 Sep 2011 22:57:37 +0200
Message-ID: <4E838A41.8010408@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-3-git-send-email-b-cousson@ti.com>
	<4E8161C7.7020404@ti.com> <4E82D7B3.6080909@ti.com>
	<4E836612.2010709@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E836612.2010709@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Scott Wood <scottwood@freescale.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On 9/28/2011 8:23 PM, Scott Wood wrote:
> On 09/28/2011 03:15 AM, Cousson, Benoit wrote:
>> On 9/27/2011 7:40 AM, Nayak, Rajendra wrote:
>>> On Monday 26 September 2011 10:20 PM, Benoit Cousson wrote:
>>>> +Required properties:
>>>> +- compatible:
>>>> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
>>>
>>> Would it be more readable to have
>>> "ti,omap2-gpio" for OMAP2 controllers and
>>> "ti,omap3-gpio" for OMAP3 controllers?
>
> Or have OMAP3 say this if it's fully backwards compatible:
>
> 	compatible = "ti,omap3-gpio", "ti,omap2-gpio";

I saw that several time for other platform, but was wondering if this 
was a strong rule or not. In that case, the IP is the same, so should we 
still identify it with a different compatible value?

>>>> +  - "ti,omap4-gpio" for OMAP4 controller
>>>> +- #gpio-cells : Should be two.
>>>> +  - first cell is the pin number
>>>> +  - second cell is used to specify optional parameters (unused)
>>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>>> +
>>>> +OMAP specific properties:
>>>> +- ti,hwmods: Name of the hwmod associated to the GPIO
>>>> +- id: 32 bits to identify the id (1 based index)
>
> What does "the id" mean, in relation to the actual hardware?

It's true that the description is not super meaningful...
This is the HW instance number. We have 6 gpios, named gpio1 to gpio6, 
but the pin numbering is global, meaning from 1 to 192, sine only the 
global number is referenced in the pinmuxing control, we have to 
maintain the order to ensure the right number.

I still do not know how to use that with the way gpio binding is 
working. Because in theory each gpio controller should be referenced 
with the local number, not the global one. And converting that global 
number from HW spec to a gpio instance + local number seems to me very 
error prone.

> Some existing bindings have such a thing (often called "cell-index"),
> but it should be well-defined what it refers to.  Often aliases would be
> a better approach, if it just refers to what the manual calls the device.

The issue is that the manual refer to a global gpio controller.

>>>> +- bank-width: number of pin supported by the controller (16 or 32)
>>>> +- debounce: set if the controller support the debouce funtionnality
>>>> +- bank-count: number of controller support by the SoC. This is a
>>>> temporary
>>>> +  hack until the bank_count is removed from the driver.
>>>
>>> Is there a general rule to be followed as to when to use
>>> "ti,<prop-name>" and when to use just"<prop-name>".
>>> Since all these are OMAP specific properties, shouldn't all
>>> of them be "ti,<prop-name>"?
>>
>> To be honest, I was wondering as well about this rule.
>> I think that a property that is not purely OMAP specific and that
>> represents some standard HW information does not have to be prefixed by
>> "ti,XXX".
>> So hwmods must be "ti,hwmods", but bank-witdh and bank-count seems to me
>> quite generic.
>
> It's about where the property is documented.  Suppose you use an
> un-prefixed bank-width but define it in the TI-specific binding to mean
> width in bits.  Later, someone wants something similar for another
> driver, doesn't look at the TI binding, but says, "This is generic, I'll
> define something in the main gpio binding," but defines it as width in
> bytes (ignore the (de)merits of defining it that way in this case).  If
> you had a namespace prefix, it would be clear which binding a node is
> referring to.

Good to know, and that makes sense. So the recommendation is to add that 
into the generic gpio as much as possible if this can be reused by 
someone else.

> As for bank-count, the description "this is a temporary hack until the
> bank_count is removed from the driver" suggests it shouldn't be there at
> all, much less be part of the generic binding.

That one sucks and will be removed soon since the driver cleanup was 
posted and waiting for upstream acceptance.

Thanks for the detailed explanations.
Benoit
