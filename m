From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Wed, 4 Sep 2013 10:20:18 -0700
Message-ID: <20130904172017.GA31541@atomide.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
 <20130813075449.GS7656@atomide.com>
 <52206A48.8040401@ti.com>
 <20130902061541.GU7656@atomide.com>
 <52243362.3090905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57323 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756765Ab3IDRUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 13:20:21 -0400
Content-Disposition: inline
In-Reply-To: <52243362.3090905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130901 23:50]:
> On 02/09/13 09:15, Tony Lindgren wrote:
> > 
> > Yes but the old bindings still need to be supported because people
> > are doing devices using those. So any kind of temporary binding will be
> > a pain to support.
> 
> If old bindings need to be supported, then we also need to support the
> current state for Panda and SDP, i.e. there are no DSS related DT
> bindings, but displays still work. Which means we'll have to keep the
> current hacky DSS device construction mechanism for Panda and SDP.

Yes we want to keep things working for the users where possible and
not cause regressions. At least some kind of output about what the
user needs to do to update to latest kernel and some documentation
is would be needed..

> Although maybe it's cleaner to somehow inject the DSS DT nodes for Panda
> and SDP in case they are missing from the real DT data.

.. but naturally that would certainly make users life easier :)
 
> Doesn't supporting old bindings also mean that we can never get rid of
> the hwmods? Or will there be code that injects the missing interrupt
> etc. entries?

I certainly hope we won't be stuck with that and can define most of
the hwmod related data in the .dts files. We should be able to
provide at least some debug output so users know what needs to
be done to upgrade.

But yeah, if there were popular devices with the .dtb in ROM using
the legacy hwmod binding, then we'd be stuck with building or generating
the data in the kernel. Or load the data later on via /lib/firmware and
let deferred probe deal with it.
 
> >> Well, one difference is that the temporary bindings would give us
> >> working display, but having only basic bindings would not. So I don't
> >> see any reason to add only the basic bindings. Or how would it work?
> > 
> > You might be able to use just a minimal binding for now using the
> > basic reg, interrupt and entries for the various components. Those will
> > be still valid when the CDF bindings are available.
> 
> Well, the entries will be valid, but the displays won't work with just
> the basic bindings. I could perhaps add a new hack that creates the
> required panel devices and video pipeline connections dynamically in
> code for Panda and SDP, a bit like what the code does now, except the
> basic DSS entries would be in the DT. But that would just add another
> set of DT data that I would need to support in the future, and there
> would be three different cases to support for Panda and SDP:
> 
> - DT data with no DSS related nodes
> - DT data with basic DSS related nodes
> - DT data with full DSS
> 
> So... If old bindings have to be supported, I'd rather try to minimize
> the pain, and not add anything but the final bindings. In retrospect, it
> was a bit of a mistake to add the hacky DT display support for Panda and
> SDP, as it won't be very nice to keep supporting those.

Yes if that just makes things more complex, it's probably best to work
on getting the generic binding done instead.

Or just rely on getting the configuration from kernel cmdline and always
use just the basic bindings? That might help keep things working for
the "DT data with no DSS related nodes" case?

Regards,

Tony

Regards,

Tony
