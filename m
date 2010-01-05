From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/1] OMAP3: PM: Fix OTG autoidle workaround
Date: Tue, 5 Jan 2010 15:47:38 -0800
Message-ID: <20100105234737.GH14533@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A71@dbde02.ent.ti.com>
 <1261132763-16697-1-git-send-email-eduardo.valentin@nokia.com>
 <20091218111236.GE32312@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58975 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab0AEXrj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 18:47:39 -0500
Content-Disposition: inline
In-Reply-To: <20091218111236.GE32312@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, Gadiyar Anand <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [091218 03:12]:
> Hi,
> 
> On Fri, Dec 18, 2009 at 11:39:23AM +0100, Valentin Eduardo (Nokia-D/Helsinki) wrote:
> >From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> >This patch fix the OTG autoidle workaround so now
> >usb gadget modules can be properly loaded.
> >
> >Besides it also adds a cpu check, because this hardware
> >but is present only in OMAP34xx chips.
> >
> >Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> looks like after this patch we can drop the workaround from
> omap2430.c and use whatever platform code configured.

FYI, tagging this for Kevin in patchwork as it's PM related.

Regards,

Tony
