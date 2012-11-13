From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Tue, 13 Nov 2012 11:03:41 +1100
Message-ID: <20121113000341.GO4696@truffula.fritz.box>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <20121109022624.GI23553@truffula.fritz.box>
 <A97699E9-6C57-4A56-BC45-86A57CF2496F@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A97699E9-6C57-4A56-BC45-86A57CF2496F-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 09, 2012 at 04:40:15PM +0100, Pantelis Antoniou wrote:
> Hi David,

[snip]
> > I think graft is basically a safer operation, particular if we're
> > doing this at runtime with userspace passing in these fdt fragments.
> > In fact I'd go so far as to say if you really need the full overlay
> > functionality, then you really ought to be working at the bootloader
> > or early kernel load level to assemble the correct full device tree.
> > And as Mitch says, an existing programming language (C, OFW Forth or
> > whatever as you please) will serve you better for this sort of general
> > manipulation than a limited template system.
> > 
> > I also think graft will handle most of your use cases, although as I
> > said I don't fully understand the implications of some of them, so I
> > could be wrong.  So, the actual insertion of the subtree is pretty
> > trivial to implement.  phandles are the obvious other matter to be
> > dealt with.  I haven't found the right thread where what you've
> > envisaged so far is discussed, so here are things I can see:
> > 
> 
> An overlay is more generic and can handle more complex cases.
> For our use case, a graft should work - with a few caveats.

Obviously an overlay is more generic.  But the ability to arbitrarily
modify existing tree nodes, without any obvious way to enforce rules
about what can be altered and what can't frankly gives me the
heebie-jeebies.

> Due to the insertion/removal of the DT fragments other node's state
> change from 'disabled' <-> 'okay' and platform devices created or
> removed. This can be handled either via overlays, or via special
> casing it.

Ah, yes, the status transition is a good point.

[snip]
> > 1) Avoiding phandle collisions between main tree and subtree (or
> >   between subtrees).
> > 
> > I'm hopeful that this can be resolved just by establishing some
> > conventions about the ranges of phandles to be used for various
> > components.  I'd certainly be happy to add a directive to dtc which
> > enforces allocation of phandles within a specified range.
> > 
> 
> Really doubtful IMHO. That will impose yet more structure on the DT
> syntax, and it will make it even more difficult for users.

Um.. I really don't see what's so hard about adding an incantation
like:
	/phandle-range/ 1-0xffff;
at the top of your base dts.  Then
	/phandle-range/ 0x10000-0x1ffff;
to the plugin dts.

Especially if we made the most common base range the default.

> We're talking about users that do understand the hardware, but can't
> really grok linux kernel development.
> 
> DT is used a structured h/w definition and seems to work just
> fine for these kind of users.
> 
> > 2) Resolving phandle references within a subtree
> > 
> > If we can handle (1) by convention, we don't need anything here, the
> > references are fine as is.
> > 
> > (3) Resolving phandle references from the subtree to the main tree.
> > 
> > So, I think this can actually be avoided, at least in cases where what
> > physical connections are available to the expansion module is well
> > defined.  The main causes to have external references are interrupts
> > and gpios.  Interrupts we handle by defining an interrupt specifier
> > space for the interrupts available on the expansion
> > socket/connector/bus/whatever.  In the master tree we then have
> > something like:
> > 
> > ...
> > 	expansion-socket@XXXX {
> > 		expansion-id = "SlotA";
> > 		interrupt-map = < /* map expansion irq specs to
> > 				     board interrupt controllers */ >;
> > 		interrupt-map-mask = < ... >;
> > 		ranges = < /* map expansion local addresses to global
> > 		              mmio */ >;
> > 	};
> > 
> > The subtree for the expansion module gets attached as a subnode of
> > this one.  It doesn't use explicit interrupt-parents but instead just
> > uses the expansion local irq specifiers, letting the parent be the
> > default which will bubble up to this socket node where the
> > interrupt-map will send them to the right places.
> > 
> > I don't recall the gpio bindings off hand, but as I recall we based
> > them off the irq tree bindings so we ought to be able to do the same
> > thing for them.
> 
> Please, don't try to do it this way. It is very debatable that we'll 
> identify all the types that will need special handling.
> For example for our cape use, we already have references that do not
> follow this example.
> 
> A generic way to resolve references is what we need.

Hrm... *mutters dubiously*.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
