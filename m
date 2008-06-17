From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 21/21] ARM: OMAP: Add OMAP chip type structure; clean up
 mach-omap2/id.c
Date: Tue, 17 Jun 2008 09:43:00 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806170856580.11210@utopia.booyaka.com>
References: <1212802253-17797-13-git-send-email-tony@atomide.com> <1212802253-17797-14-git-send-email-tony@atomide.com> <1212802253-17797-15-git-send-email-tony@atomide.com> <1212802253-17797-16-git-send-email-tony@atomide.com> <1212802253-17797-17-git-send-email-tony@atomide.com>
 <1212802253-17797-18-git-send-email-tony@atomide.com> <1212802253-17797-19-git-send-email-tony@atomide.com> <1212802253-17797-20-git-send-email-tony@atomide.com> <1212802253-17797-21-git-send-email-tony@atomide.com> <1212802253-17797-22-git-send-email-tony@atomide.com>
 <20080614092235.GR32122@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44753 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYFQPnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 11:43:03 -0400
In-Reply-To: <20080614092235.GR32122@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


Hello Russell,

On Sat, 14 Jun 2008, Russell King - ARM Linux wrote:

> On Fri, Jun 06, 2008 at 06:30:53PM -0700, Tony Lindgren wrote:
> > omap_chip is set in mach-omap2/id.c by _set_omap_chip(). Other
> > code should use the omap_chip_is() function to test against omap_chip.
> 
> > +/**
> > + * omap_chip_is - test whether currently running OMAP matches a chip type
> > + * @oc: omap_chip_t to test against
> > + *
> > + * Test whether the currently-running OMAP chip matches the supplied
> > + * chip type 'oc'.  Returns 1 upon a match; 0 upon failure.
> > + */
> > +int omap_chip_is(struct omap_chip_id oci)
> > +{
> > +	return (oci.oc & omap_chip.oc) ? 1 : 0;
> > +}
> > +EXPORT_SYMBOL(omap_chip_is);
> 
> I've not seen any use cases for this function, so I don't know how it's
> intended to be used.  However, is it really sensible for this to take a
> structure rather than just a value?

It was created as a structure so the size of the underlying bitmask can be 
increased later without patching all of the structure definitions that use 
it in other code.  (Originally it was a typedef.)  Here's a basic use 
case:

struct foo {
	...
	struct omap_chip_id omap_chip;
};

static const struct foo foo_instance_omap2420 = {
	...
	.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
};

static const struct foo foo_instance_omap3430 = {
	...
	.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
};

static const struct foo *foo_instances[] = {
	&foo_instance_omap2420,
	&foo_instance_omap3430,
	NULL
};

void fn(void) {
	for (p = foo_instances; p; p++) {
		if (omap_chip_is(p->omap_chip) 
			pr_debug("Chip type matches - use this structure");
}


- Paul

