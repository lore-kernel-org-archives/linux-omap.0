From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V5 0/6] OMAPDSS: Cleanup cpu_is checks
Date: Thu, 6 Sep 2012 13:08:54 -0700
Message-ID: <20120906200853.GC1303@atomide.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <cover.1345468541.git.cmahapatra@ti.com>
 <20120830002039.GP1303@atomide.com>
 <1346312061.2327.27.camel@deskari>
 <20120830171908.GQ1303@atomide.com>
 <1346412220.16067.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:41775 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759239Ab2IFUI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:08:57 -0400
Content-Disposition: inline
In-Reply-To: <1346412220.16067.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120831 04:24]:
> On Thu, 2012-08-30 at 10:19 -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120830 00:35]:
> > > On Wed, 2012-08-29 at 17:20 -0700, Tony Lindgren wrote:
> > > > 
> > > > Good to see this, we need this badly to avoid blocking
> > > > single zImage effort on omaps. Can you also please take
> > > 
> > > What is the issue with single zImage? How do cpu_is_ check affect it?
> > 
> > The usage for that should only be limited to arch/arm/mach-omap2
> > so we can make cpu.h local as we can't include mach and plat
> > header files from the drivers with single zImage.
> 
> Ok.
> 
> > > $ git grep -E "<plat|<mach" drivers/video/omap*
> > > drivers/video/omap/lcd_ams_delta.c:#include <plat/board-ams-delta.h>
> > > * Needs to be moved
> > 
> > Yes, that should be either mach/board-ams-delta.h, or separate driver
> > specific headers in include/linux/platform_data. For omap1 we are not
> > planning common zImage support, so let's just make sure we're not
> > breaking anything there as people are still using it.
> 
> Hmm, so did I understand right, for omap1 stuff we can still include
> from arch/arm/mach-omap1/include/mach?

Yes that's a separate issue to fix that up for armv4/5 common
zImage support if people want to do that later on.
 
> If so, that makes things easier. I can manage the omap2+ stuff fine, but
> I have no experience with omap1, nor do I have any omap1 devices. So I'd
> rather keep the omap1 code as it is, in fear that I'd just break it
> totally, and I'd rather spend my time on omap2+ code.

Regards,

Tony

