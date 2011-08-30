From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: How to handle named resources with DT?
Date: Tue, 30 Aug 2011 12:29:12 +1000
Message-ID: <20110830022912.GE4254@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
 <877h6173wm.fsf@ti.com>
 <20110826041200.GD2308@yookeroo.fritz.box>
 <201108261258.32880.arnd@arndb.de>
 <4E57A9FB.5030404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:46100 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1H3DOk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 23:14:40 -0400
Content-Disposition: inline
In-Reply-To: <4E57A9FB.5030404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 26, 2011 at 04:13:15PM +0200, Cousson, Benoit wrote:
> On 8/26/2011 12:58 PM, Arnd Bergmann wrote:
> >On Friday 26 August 2011, David Gibson wrote:
> >>Seriously, how many times do I have to say it?
> 
> [...]
> 
> >>Insisting that the names come from the DT is to mistakenly think of
> >>the DT as an extension of the kernel's internal interfaces, instead of
> >>as the external and OS neutral data structure it actually is.
> 
> You are wrongly interpreting the consequence: a smart Linux guy
> added a _byname API, without seeing the real cause: most HW
> resources have a name to identify them and not a number.

No, I'm really not.

> >Agreed, that was my main point anyway: Getting the name from the
> >device tree would be a huge mistake.
> 
> No, it would not. In fact, storing name in DT is even much more
> aligned with the goal of DT for my point of view, since it is
> supposed to describe the HW without any assumption about the OS
> usage. DT data are supposed to be driven by the HW specs.

So, I actually agree that in the long term getting resource names in
the DT would be a generally good thing.

But doing so is a *huge* change in one of the very core semantics of
all the DT bindings.  It's not something that should be done lightly
or quickly.  It absolutely should not be tied to how this is handled
on the Linux side.  Therefore *for now* it is much better to have glue
which binds existing DT practice to the new Linux interface; then
thinking about this from the DT point of view can be a long term
project.

> The ordering you are relying on for the moment is purely arbitrary
> and do not have any signification for the HW point of view. Just
> have a look at a HW spec and you will see that most signals have a
> *name*, not a number, to identify them.

Sure, but assigning that arbitrary order is well-established practice
for device DT bindings.

> Without that, you have to add some unnecessary and error prone
> processing to the original information:
> - Encode an information that is there originally (resource name from
> the HW spec) into a arbitrary number without any meaning: Why tx_irq
> should be before the rx_irq and after the err_irq???
> - Remove the original name to confuse people.
> - Expect the driver to use a number that does not come from the HW
> spec but from a DT binding text file to figure out what resource it
> has to use.

No, I don't expect that bit - see the discussion of how we can glue
the DT order to names inside the kernel.

> - Pray that the driver guy didn't wrongly interpret the irq #2138469
> to be the tx_irq instead of the rx_irq.

Um, this is an order, not an arbitrary int number.  So try irq #2.
Maybe #3 or #4 on a really complicated device.

> If you extend a little bit the scope of the discussion and start
> considering that clocks, voltage rails, reset lines are as well a
> resources for the IP point of view, do you really think that using a
> number to identify a clock or a voltage will really make sense?
> Guess what? The current clock binding is using clock name...

Yes.  There's a big difference between creating a new binding to use
names, and creating a new practice in the core DT semantics used by
every single existing binding.

> In order to have a consistent way of using resources in DT, it makes
> sense to have the ability to provide a name for any kind of
> resources.
> BTW, adding a name should not prevent people to use the legacy by
> index method.
> 
> 
> Moreover, anybody deserve to have a name... Otherwise we will end up
> with situation like that:
> 
> resource #6: Who are you?
> resource #2: The new #2.
> resource #6: Who is #1?
> resource #2: You are #6.
> resource #6: I am not a number, I am a free resource.

Allusions to TV programs do not an argument make, no matter how
interesting and influential they might have been.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
