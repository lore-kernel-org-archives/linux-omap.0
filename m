From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Thu, 16 Sep 2010 11:57:43 -0700
Message-ID: <20100916185743.GJ29610@atomide.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
 <20100915224007.GJ4174@atomide.com>
 <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com>
 <AANLkTimC7_pGag4e+Q0fasP=mdsug8xrU95UJLKOJHvf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52013 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab0IPS5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 14:57:47 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimC7_pGag4e+Q0fasP=mdsug8xrU95UJLKOJHvf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

* Gadiyar, Anand <gadiyar@ti.com> [100915 21:51]:
> 
> > About two months of it is my fault, since it was posted to l-o on July 21.
> > But all the time between 12 March and 21 July is up to TI to answer.
> > This really could have been a useful patch for certain vendors to have
> > that are using CORE DVFS on their currently-shipping OMAP3 devices.
> 
> Sure, and I'm certain those other vendors have an equal number of critical
> bug fixes sitting in their own trees, which they steadfastly refuse to
> share with
> other competing vendors until their own products are out. (I have specific
> examples in mind, but don't want to start another flame war).
> 
> Grow up - when a bug is discovered in the field, people are not likely to
> share with others in the interest of their own product timelines. While
> this may overall be less beneficial for everyone, that is indeed how many
> think and work.

I don't buy this. But maybe some of TI's customers can comment on this?

AFAIK everybody wants to avoid the duplicate effort of finding and fixing
these bugs.

TI is the only party who is even aware of all the bugs fixed in various
places. And it's TI who should follow up that the bugfixes get posted
in a timely manner.

Regards,

Tony
