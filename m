From: Tony Lindgren <tony@atomide.com>
Subject: Re: OK to base some patches on lmb branch?
Date: Mon, 2 Aug 2010 16:16:56 +0300
Message-ID: <20100802131653.GN12293@atomide.com>
References: <20100707105213.GJ1920@atomide.com>
 <20100709144901.GK22845@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58265 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab0HBNQy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 09:16:54 -0400
Content-Disposition: inline
In-Reply-To: <20100709144901.GK22845@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100709 17:42]:
> On Wed, Jul 07, 2010 at 01:52:14PM +0300, Tony Lindgren wrote:
> > Hi Russell,
> > 
> > Is your lmb branch going to stay static?
> 
> Not at the moment, I'm still tweaking things in there, and the main
> lmb conversion commit needs a better description...  I think there's
> also a few bits missing from the discontigmem removal patch.

Back online now from a vacation.

I have separated the omap common map_io patches into a branch based
on your lmb branch and merged into omap for-next.

Will not merge into omap-for-linus until I have a confirmation
from you it will stay static.

Regards,

Tony
