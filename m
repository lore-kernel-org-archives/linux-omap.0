From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4 naming conventions
Date: Tue, 12 May 2009 08:17:16 -0700
Message-ID: <20090512151715.GQ5593@atomide.com>
References: <87tz3qe5ay.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301D789E426@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53431 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875AbZELPRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 11:17:18 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D789E426@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Premi, Sanjeev <premi@ti.com> [090512 08:01]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> > Sent: Tuesday, May 12, 2009 8:29 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Shilimkar, Santosh
> > Subject: OMAP4 naming conventions
> > 
> > As the OMAP4 patches are coming in, there seems to be a bit of variety
> > in the naming of functions/macros/variables etc.
> > 
> > Could I propose that we just use omap4_* and OMAP4_* instead of
> > OMAP44XX_* or OMAP4XXXX_* etc.
> > 
> > I know that OMAP2 and OMAP3 have a variety of forms here too, but
> > those should probably be cleaned up eventually too.
> > 
> > With proper runtime revision detecting, IMO, we should only really
> > have the OMAP4 prefix, and leave the sub revision handling to runtime
> > code.
> > 
> > Thoughts?
> 
> Full ACK.

Sounds good to me too.

Tony
