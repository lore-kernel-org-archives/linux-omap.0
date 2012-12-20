From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] two trivial omap build error fixes for v3.8 merge
 window
Date: Thu, 20 Dec 2012 07:56:14 -0800
Message-ID: <20121220155614.GA1034@quad.lixom.net>
References: <20121219171828.GP4989@atomide.com>
 <20121220150105.GA28275@n2100.arm.linux.org.uk>
 <20121220152508.GW4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33801 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab2LTP4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 10:56:13 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so2072694pbc.37
        for <linux-omap@vger.kernel.org>; Thu, 20 Dec 2012 07:56:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121220152508.GW4989@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 20, 2012 at 07:25:08AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121220 07:03]:
> > On Wed, Dec 19, 2012 at 09:18:28AM -0800, Tony Lindgren wrote:
> > > Here's few more trivial build fixes caused by the merge
> > > conflicts.
> > 
> > If Olof isn't able to pull this stuff in tonight, I'll pull it into my
> > tree and send it up with my stuff.  I'll also see about picking up
> > on the previous one with the common.c vram.h fix too.
> 
> I just replied to the "[GIT PULL] ARM: arm-soc fixes for 3.8" thread
> suggesting Linus pull it. It seems that the issue with that one
> .dts file can easily be fixed later on and there's no need to go
> tinker with that branch.
> 
> Please go ahead and pull in the $Subject: branch though, these two
> are not yet in Olof's branch.
> 
> > I'm not sure what Olof's plans are, but I know Arnd isn't around at
> > the moment, and Olof was travelling a couple of days ago and hasn't
> > reappeared since.  I don't think we can leave these fixes any longer
> > as OMAP has been broken in mainline for at least the last four days
> > and we're nearing the end of the merge window.
> 
> Yes, Olof mentioned that he should be back online within few days.
> He's probably enjoying the bastu :)

More like dealing with sick and jetlagged kids, and having issues with
a decent 3G connection where I'm staying (almost literally in the middle
of nowhere). It's the first time my current workflow of ssh:ing to my main
workstation has not worked well, unfortunately.

I've redone the sunxi pieces of the fixes branch now, and will apply the other
recent pull requests and will include those. Since Tony's patches are on
a branch, if Russell overtakes me and gets his pull request in, there won't be
any problems caused by it.

I'll have a fresh pull request for Linus in an hour or so.


-Olof

