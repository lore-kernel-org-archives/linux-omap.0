From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Thu, 11 Aug 2011 14:28:55 +0200
Message-ID: <4E43CB07.20002@ti.com>
References: <4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
	<4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca>
	<4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca>
	<4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
	<CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Balbi,
	Felipe" <balbi@ti.com>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: linux-omap@vger.kernel.org

On 8/10/2011 9:22 PM, Grant Likely wrote:
> On Tue, Aug 9, 2011 at 7:52 PM, David Gibson
> <david@gibson.dropbear.id.au>  wrote:
>> On Tue, Aug 09, 2011 at 11:53:32PM +0200, Cousson, Benoit wrote:
>>> On 8/9/2011 11:49 PM, Grant Likely wrote:
>>>> That won't work either because that also breaks the existing 'reg'
>>>> binding.  Anything you do will need to supplement the existing
>>>> binding without changing it in an incompatible way.
>>>
>>> OK, but can we add a new attribute then? reg2, reg_ng, reg_plusplus,
>>> reg_named...?
>>
>> He already suggested reg-names to be interpreted in parallel with the
>> existing reg property.  The (serious) problem with replacing the reg
>> property is that it will break all existing OSes (including old Linux
>> versions) that don't understand the new property.
>>
>> Of course, the problem with reg-names is that it will be ignored by
>> older OSes, and so 'reg' must still be in the correct order.  In which
>> case you could argue it's more sensible to just have a static place to
>> name mapping in the Linux driver.
>>
>> In short, yes, named reg elements in the DT would be nice in theory,
>> but I'm not convinced it's worth a DT flag day to accomplish it.
>
> I'm inclined the same way, though I agree with the replies that point
> out it wouldn't result in a 'flag day' because existing bindings
> cannot become incompatible.  The problem I have is that adding
> reg-names or similar implies that ordering of the reg property is no
> longer defined which I absolutely do not think is a good idea.

That will not be an issue if "reg-named" is a completely new node. It 
will replace the "reg" node only when a named entry is needed.
Most devices will use the regular "reg" entry, and only the one that 
need extra information will use the reg-named.

That seems to be pretty straightforward to implement, and as soon as it 
is useful even for a couple of drivers, it worth adding it.

It is anyway better than having to add a custom property to get the 
information we will miss otherwise.

Moreover, since some drivers are relying on that call, it will avoid 
having to add extra code for nothing if CONFIG_OF is set.

It will allow the driver to use a pretty standard API in anycase vs 
using platform_get_resource + some extra optional calls to of_ functions 
+ some code to get the information for non-DT build.

> Please, stick with the established convention and explicitly order
> 'reg' and 'interrupts' properties.  If there is a specific use case
> where this doesn't work, then bring it up, but I haven't seen any yet.

There will always be some alternatives, but they will be uglier, and the 
effort to add some extra node to DT is so small, that it is better to do 
that instead of adding some useless extra code in the driver.

>   The current users of _byname that I've looked seem to only use it for
> convenience, not because a register range may be optional.  ie. they
> all fail out if a reg resource isn't present.

If that API can help the driver writer and can avoid adding 10 lines of 
code, it is still useful to use it.

To be honest, I still do not understand why you are so reluctant to add 
that small feature.

That will not break compatibility and it will make our life easier.
Don't you want to make our life easier? :-)

Benoit
