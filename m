From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] DSS fixes for v3.2-rc2
Date: Thu, 24 Nov 2011 11:42:08 -0800
Message-ID: <20111124194208.GF13928@atomide.com>
References: <20111123235542.GL31337@atomide.com>
 <201111241606.54879.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18734 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531Ab1KXTmM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Nov 2011 14:42:12 -0500
Content-Disposition: inline
In-Reply-To: <201111241606.54879.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Arnd Bergmann <arnd@arndb.de> [111124 07:31]:
> On Wednesday 23 November 2011, Tony Lindgren wrote:
> > Hi Arnd,
> > 
> > This one has been separated out from the rest of the fixes.
> 
> Pulled into the fixes branch now. I'll send out the branch
> after testing it on tomorrow's linux-next.
> 
> > If some of these need to go to stable, then Tomi should
> > do the rebasing and send them to stable@vger.kernel.org
> > as they don't apply cleanly on v3.1.
> 
> Ok. I've taken Tomi on Cc as a reminder for him, although I guess
> you already discussed it with him.

Well did not discuss with Tomi yet, but based on some comments
from Greg if the patches did not originally have Cc: stable in them
when committed, then it's probably best to send to the stable list
only after the commits hit the mainline so he knows what they are.

> Kiitoksia paljon,

Samoin!

Tony
