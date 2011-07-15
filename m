From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 00:50:24 -0700
Message-ID: <20110715075024.GO5783@atomide.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
 <20110714073445.GL5783@atomide.com>
 <1310632792.4008.3.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21571 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755198Ab1GOHu2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 03:50:28 -0400
Content-Disposition: inline
In-Reply-To: <1310632792.4008.3.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <J.Weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sshtylyov@mvista.com>

* Jan Weitzel <J.Weitzel@phytec.de> [110714 01:34]:
> Am Donnerstag, den 14.07.2011, 00:34 -0700 schrieb Tony Lindgren:
> > * Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> > > Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyov:
> > > 
> > > > 
> > > >     Have you added that 'i' at the end intentionally?
> > > > 
> > > Thank you. It was a tribute to vim.
> > 
> > :i)
> > 
> > I'll fold the fixed patch into your original patch. Will also
> > keep the new board files in testing-board because of the code
> > coalescing and device tree conversion effort.
> 
> So there is no way to get the board mainline yet?

Well we can add it even before device tree support if it makes
sense from code coalescing point of view. In this case it would
mean creating board-panda-common.c or similar so the code can
be shared amongst the panda variants.

It seems that some GPIO pins are different and there are some
difference in devices connected, but big parts of the code can be
shared.

Adding the pending boards without combining code would be adding code
that will be going away for most part with the device tree support.

And most likely the beagle and panda based boards will be the first
ones to work with device tree. So anything we can do to have common
board init code will also help with this effort.

Regards,

Tony
