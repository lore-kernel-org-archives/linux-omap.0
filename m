From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] two trivial omap build error fixes for v3.8 merge
 window
Date: Thu, 20 Dec 2012 07:25:08 -0800
Message-ID: <20121220152508.GW4989@atomide.com>
References: <20121219171828.GP4989@atomide.com>
 <20121220150105.GA28275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:65273 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751195Ab2LTPZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 10:25:15 -0500
Content-Disposition: inline
In-Reply-To: <20121220150105.GA28275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121220 07:03]:
> On Wed, Dec 19, 2012 at 09:18:28AM -0800, Tony Lindgren wrote:
> > Here's few more trivial build fixes caused by the merge
> > conflicts.
> 
> If Olof isn't able to pull this stuff in tonight, I'll pull it into my
> tree and send it up with my stuff.  I'll also see about picking up
> on the previous one with the common.c vram.h fix too.

I just replied to the "[GIT PULL] ARM: arm-soc fixes for 3.8" thread
suggesting Linus pull it. It seems that the issue with that one
.dts file can easily be fixed later on and there's no need to go
tinker with that branch.

Please go ahead and pull in the $Subject: branch though, these two
are not yet in Olof's branch.

> I'm not sure what Olof's plans are, but I know Arnd isn't around at
> the moment, and Olof was travelling a couple of days ago and hasn't
> reappeared since.  I don't think we can leave these fixes any longer
> as OMAP has been broken in mainline for at least the last four days
> and we're nearing the end of the merge window.

Yes, Olof mentioned that he should be back online within few days.
He's probably enjoying the bastu :)

Regards,

Tony
