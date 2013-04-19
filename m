From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Fri, 19 Apr 2013 10:44:55 -0700
Message-ID: <20130419174454.GM10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
 <517181B2.9070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36632 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752523Ab3DSRo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 13:44:59 -0400
Content-Disposition: inline
In-Reply-To: <517181B2.9070302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 10:43]:
> On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's a list of breakage I've noticed so far while trying to
> > use linux next on my pandaboard es. Probably similar issues exist
> > on other boards as well.
> > 
> > Ideally we would not have any breakage by the merge window, so
> > let's try to get these fixed ASAP:
> > 
> > 1. Serial console broken on panda es booting with DT
> > 
> > The symptoms are dmesg output stopping after few lines
> > and only continuing after pressing a key. Does not seem to
> > happen on blaze with DT for some reason. And does not happen
> > on panda es with legacy booting.
> > 
> This one is known and reported on list along with fix patches and
> later pull request [1].
> 
> Unfortunately with all the testing and everything and patches have
> been on the list for quite some time, feedback on one of the patch
> received was after pull request and then there was no further
> clarification. That series address the same exact issue you have
> mentioned above.

OK thanks. I think Paul picked some of those and the plan was
to update the branch? Which one(s) should go into v3.10 as fixes?

Regards,

Tony

> [1] http://patchwork.ozlabs.org/patch/229269/
