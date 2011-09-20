From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Tue, 20 Sep 2011 13:55:37 -0700
Message-ID: <20110920205537.GI2937@atomide.com>
References: <20110917014623.GC2937@atomide.com>
 <201109202201.18574.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31742 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182Ab1ITUzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 16:55:45 -0400
Content-Disposition: inline
In-Reply-To: <201109202201.18574.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [110920 12:27]:
> On Saturday 17 September 2011, Tony Lindgren wrote:
> > Please pull the first part of omap cleanup from:
> > 
> > git://github.com/tmlind/linux.git cleanup
> > 
> > This series cleans up early_init functions and removes
> > CHIP_IS macro usage. This makes it easier to have SoC
> > specific init functions so adding support for new omap
> > variants does not require patching all over the place.
> 
> Thanks, pulled.
> 
> Note that we are trying to get everyone to use the similar
> prefixes for patch summaries, so it would be nice if you could
> change 'OMAP: powerdomain:' to 'ARM: OMAP: powerdomain' or
> 'ARM: omap/powerdowmain:' in the future.

Already did that for my patches.. Paul and Kevin, can you
please also start following that standard too?

Thanks,

Tony
