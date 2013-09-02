From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Sun, 1 Sep 2013 23:15:42 -0700
Message-ID: <20130902061541.GU7656@atomide.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
 <20130813075449.GS7656@atomide.com>
 <52206A48.8040401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36361 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab3IBGPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Sep 2013 02:15:46 -0400
Content-Disposition: inline
In-Reply-To: <52206A48.8040401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130830 02:55]:
> On 13/08/13 10:54, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [130809 01:46]:
> >>
> >> So as is evident, I have things in my mind that should be improved. Maybe
> >> the most important question for short term future is:
> >>
> >> Can we add DSS DT bindings for OMAP4 as unstable bindings? It would give us
> >> some proper testing of the related code, and would also allow us to remove
> >> the related hacks (which don't even work quite right). However, I have no
> >> idea yet when the unstable DSS bindings would turn stable.
> >>
> >> If we shouldn't add the bindings as unstable, when should the bindings be
> >> added? Wait until CDF is in the mainline, and use that?
> > 
> > I don't think we should add any temporary bindings as it's going to be
> > a pain to support those in the long run. I suggest you initially just
> > stick to established bindings for the basic hardware IO address and
> > interrupts etc, then those should still be valid with the generic panel
> > bindings later on.
> 
> I don't understand what does it matter if the bindings are temporary, or
> basic established bindings. In both cases the DT data needs to be
> changed when the CDF is taken into use.

Yes but the old bindings still need to be supported because people
are doing devices using those. So any kind of temporary binding will be
a pain to support.
 
> Well, one difference is that the temporary bindings would give us
> working display, but having only basic bindings would not. So I don't
> see any reason to add only the basic bindings. Or how would it work?

You might be able to use just a minimal binding for now using the
basic reg, interrupt and entries for the various components. Those will
be still valid when the CDF bindings are available.

Regards,

Tony
