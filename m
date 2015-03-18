From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Wed, 18 Mar 2015 13:31:01 -0700
Message-ID: <20150318203100.GV31346@atomide.com>
References: <1426707461.13824.2.camel@symus-gk-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38461 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbbCRUfo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 16:35:44 -0400
Content-Disposition: inline
In-Reply-To: <1426707461.13824.2.camel@symus-gk-mint>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Knight <g.knight@symetrica.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Greg,

* Greg Knight <g.knight@symetrica.com> [150318 12:38]:
> Hi, linux-omap,
> 
> I've attached a patch which adds a device-tree field "ti,dma-min-bytes"
> which replaces the macro DMA_MIN_BYTES. Adjusting this field addresses
> issues we've had where, in our particular use case, the usleep() in the
> SPI worker thread eats a full 20% of our CPU (AM3359).
> 
> I opted to implement it as a device-tree parameter and keep the original
> value (160) as the default, in order to avoid impacting anyone else.
> 
> The patch is attached. Patches 1-2 are an unrelated McASP change (see my
> other message).
> 
> What is the process for getting this upstreamed?

Well I suggest you run get_maintainer.pl on your patches to figure
out who to send them to for review. For example this one:

$ scripts/get_maintainer.pl -f drivers/spi/spi-omap2-mcspi.c 
Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)
 
Also you might want to run scripts/checkpatch.pl --strict on them
to sort out any formatting issues etc.

And if it's omap related patch, please cc also the linux-omap
mailing list too.

That's pretty much all that's needed, then just update the patches
baded on people's comments :) Good idea to fix up these issues
in the upstream kernel.

Regards,

Tony
