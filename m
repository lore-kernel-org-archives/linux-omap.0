From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 10:14:48 +0200
Message-ID: <4E44E0F8.6000102@ti.com>
References: <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
	<4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca>
	<4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca>
	<4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
	<CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
	<4E43CB07.20002@ti.com> <20110812030218.GP30552@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110812030218.GP30552-787xzQ0H9iQXU02nzanrWNbf9cGiqdzd@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Balbi,
	Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/12/2011 5:02 AM, David Gibson wrote:
> On Thu, Aug 11, 2011 at 02:28:55PM +0200, Cousson, Benoit wrote:
>> On 8/10/2011 9:22 PM, Grant Likely wrote:
>>> On Tue, Aug 9, 2011 at 7:52 PM, David Gibson
>>> <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>   wrote:
>>>> On Tue, Aug 09, 2011 at 11:53:32PM +0200, Cousson, Benoit wrote:
>>>>> On 8/9/2011 11:49 PM, Grant Likely wrote:
>>>>>> That won't work either because that also breaks the existing 'reg'
>>>>>> binding.  Anything you do will need to supplement the existing
>>>>>> binding without changing it in an incompatible way.
>>>>>
>>>>> OK, but can we add a new attribute then? reg2, reg_ng, reg_plusplus,
>>>>> reg_named...?
>>>>
>>>> He already suggested reg-names to be interpreted in parallel with the
>>>> existing reg property.  The (serious) problem with replacing the reg
>>>> property is that it will break all existing OSes (including old Linux
>>>> versions) that don't understand the new property.
>>>>
>>>> Of course, the problem with reg-names is that it will be ignored by
>>>> older OSes, and so 'reg' must still be in the correct order.  In which
>>>> case you could argue it's more sensible to just have a static place to
>>>> name mapping in the Linux driver.
>>>>
>>>> In short, yes, named reg elements in the DT would be nice in theory,
>>>> but I'm not convinced it's worth a DT flag day to accomplish it.
>>>
>>> I'm inclined the same way, though I agree with the replies that point
>>> out it wouldn't result in a 'flag day' because existing bindings
>>> cannot become incompatible.  The problem I have is that adding
>>> reg-names or similar implies that ordering of the reg property is no
>>> longer defined which I absolutely do not think is a good idea.
>>
>> That will not be an issue if "reg-named" is a completely new node.
>> It will replace the "reg" node only when a named entry is needed.
>> Most devices will use the regular "reg" entry, and only the one that
>> need extra information will use the reg-named.
>
> Um, you seem to be confusing nodes and properties here.

I don't think so. What I was proposing before was something like that:

dev {
	reg_named {
		name = "foo_wrapper";
		start =<0x10000>;
		end =<0x200>;
	}
	reg_named {
		name = "foo";
		start =<0x20000>;
		end =<0x200>;
	}
}

So, AFAIK, this is a node and not a property, isn't it?

OK, I was proposing as well something at attribute level:
reg_named = <0x10000 0x200>, "foo_wrapper", <0x20000 0x200>, "foo";

But I'm not sure it is easy to parse. Moreover, I cannot find a way to 
differentiate a string from a cell in the property, so maybe I'm missing 
something.

>> That seems to be pretty straightforward to implement, and as soon as
>> it is useful even for a couple of drivers, it worth adding it.
>>
>> It is anyway better than having to add a custom property to get the
>> information we will miss otherwise.
>>
>> Moreover, since some drivers are relying on that call, it will avoid
>> having to add extra code for nothing if CONFIG_OF is set.
>>
>> It will allow the driver to use a pretty standard API in anycase vs
>> using platform_get_resource + some extra optional calls to of_
>> functions + some code to get the information for non-DT build.
>
> You don't need to add stuff to the DT to use the byname interface.
> Really.  All you need is a way for the driver (well match table entry,
> really) to provide a list of names to attach to the reg entries in
> order.

That looks interesting, but I'm not sure to understand how it works.
Do you have an example?
It still looks like I will have to add some extra stuff in the driver, 
whereas I will not have to if the DT core can handle that new reg_named.

>>> Please, stick with the established convention and explicitly order
>>> 'reg' and 'interrupts' properties.  If there is a specific use case
>>> where this doesn't work, then bring it up, but I haven't seen any yet.
>>
>> There will always be some alternatives, but they will be uglier, and
>> the effort to add some extra node to DT is so small, that it is
>> better to do that instead of adding some useless extra code in the
>> driver.
>>
>>>   The current users of _byname that I've looked seem to only use it for
>>> convenience, not because a register range may be optional.  ie. they
>>> all fail out if a reg resource isn't present.
>>
>> If that API can help the driver writer and can avoid adding 10 lines
>> of code, it is still useful to use it.
>>
>> To be honest, I still do not understand why you are so reluctant to
>> add that small feature.
>
> Because this is a totally new basic feature to add to the DT
> bindings.  Once in there, we're stuck with it indefinitely, which
> means it warrants considerably more conservatism than mere internal
> code changes which can be easily updated or reverted.

OK, so it means that we need to be very careful with the design, but 
does not mean it should be rejected.
Since that feature can be useful for some people, it still worth doing 
it. Or do we have to keep that bindings for OMAP only?
In a period of consolidation, that does not seems to be the right solution.

Bottom-line, I can start with a RFC patch to add a new bindings and see 
it is make sense to go further with it.

Benoit
