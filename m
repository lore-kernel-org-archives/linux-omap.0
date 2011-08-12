From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 13:02:18 +1000
Message-ID: <20110812030218.GP30552@yookeroo.fritz.box>
References: <4E417BD5.8080409@freescale.com>
 <20110809205723.GE11568@ponder.secretlab.ca>
 <4E41A1B9.1060400@ti.com>
 <20110809211747.GJ11568@ponder.secretlab.ca>
 <4E41AA43.1000506@ti.com>
 <20110809214905.GK11568@ponder.secretlab.ca>
 <4E41AC5C.20301@ti.com>
 <20110810015214.GD23511@yookeroo.fritz.box>
 <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
 <4E43CB07.20002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:39198 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166Ab1HLDC1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 23:02:27 -0400
Content-Disposition: inline
In-Reply-To: <4E43CB07.20002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

On Thu, Aug 11, 2011 at 02:28:55PM +0200, Cousson, Benoit wrote:
> On 8/10/2011 9:22 PM, Grant Likely wrote:
> >On Tue, Aug 9, 2011 at 7:52 PM, David Gibson
> ><david@gibson.dropbear.id.au>  wrote:
> >>On Tue, Aug 09, 2011 at 11:53:32PM +0200, Cousson, Benoit wrote:
> >>>On 8/9/2011 11:49 PM, Grant Likely wrote:
> >>>>That won't work either because that also breaks the existing 'reg'
> >>>>binding.  Anything you do will need to supplement the existing
> >>>>binding without changing it in an incompatible way.
> >>>
> >>>OK, but can we add a new attribute then? reg2, reg_ng, reg_plusplus,
> >>>reg_named...?
> >>
> >>He already suggested reg-names to be interpreted in parallel with the
> >>existing reg property.  The (serious) problem with replacing the reg
> >>property is that it will break all existing OSes (including old Linux
> >>versions) that don't understand the new property.
> >>
> >>Of course, the problem with reg-names is that it will be ignored by
> >>older OSes, and so 'reg' must still be in the correct order.  In which
> >>case you could argue it's more sensible to just have a static place to
> >>name mapping in the Linux driver.
> >>
> >>In short, yes, named reg elements in the DT would be nice in theory,
> >>but I'm not convinced it's worth a DT flag day to accomplish it.
> >
> >I'm inclined the same way, though I agree with the replies that point
> >out it wouldn't result in a 'flag day' because existing bindings
> >cannot become incompatible.  The problem I have is that adding
> >reg-names or similar implies that ordering of the reg property is no
> >longer defined which I absolutely do not think is a good idea.
> 
> That will not be an issue if "reg-named" is a completely new node.
> It will replace the "reg" node only when a named entry is needed.
> Most devices will use the regular "reg" entry, and only the one that
> need extra information will use the reg-named.

Um, you seem to be confusing nodes and properties here.

> That seems to be pretty straightforward to implement, and as soon as
> it is useful even for a couple of drivers, it worth adding it.
> 
> It is anyway better than having to add a custom property to get the
> information we will miss otherwise.
> 
> Moreover, since some drivers are relying on that call, it will avoid
> having to add extra code for nothing if CONFIG_OF is set.
> 
> It will allow the driver to use a pretty standard API in anycase vs
> using platform_get_resource + some extra optional calls to of_
> functions + some code to get the information for non-DT build.

You don't need to add stuff to the DT to use the byname interface.
Really.  All you need is a way for the driver (well match table entry,
really) to provide a list of names to attach to the reg entries in
order.

> >Please, stick with the established convention and explicitly order
> >'reg' and 'interrupts' properties.  If there is a specific use case
> >where this doesn't work, then bring it up, but I haven't seen any yet.
> 
> There will always be some alternatives, but they will be uglier, and
> the effort to add some extra node to DT is so small, that it is
> better to do that instead of adding some useless extra code in the
> driver.
> 
> >  The current users of _byname that I've looked seem to only use it for
> >convenience, not because a register range may be optional.  ie. they
> >all fail out if a reg resource isn't present.
> 
> If that API can help the driver writer and can avoid adding 10 lines
> of code, it is still useful to use it.
> 
> To be honest, I still do not understand why you are so reluctant to
> add that small feature.

Because this is a totally new basic feature to add to the DT
bindings.  Once in there, we're stuck with it indefinitely, which
means it warrants considerably more conservatism than mere internal
code changes which can be easily updated or reverted.

> That will not break compatibility and it will make our life easier.
> Don't you want to make our life easier? :-)
> 
> Benoit
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
