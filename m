From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Tue, 23 Oct 2012 19:34:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210231933400.27211@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> <50857444.9080308@ti.com> <20121022163825.GA4730@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59870 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922Ab2JWTeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 15:34:17 -0400
In-Reply-To: <20121022163825.GA4730@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 22 Oct 2012, Tony Lindgren wrote:

> * Jon Hunter <jon-hunter@ti.com> [121022 09:30]:
> > On 10/20/2012 04:26 PM, Paul Walmsley wrote:
> > > 
> > > * 2430sdp: vfp_reload_hw oops during MMC initialization
> > >   - Kernel attempts to save FP registers that don't exist; fix posted:
> > >     - http://www.spinics.net/lists/arm-kernel/msg200646.html
> 
> Has that one been posted to RMK's patch system?

Just did that, let's see what happens.

> > > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> > >   - due to a GPMC bug
> > >   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html
> > 
> > This is now addressed and I have verified it is booting on v3.7-rc2. The
> > following patch address this boot problem ...
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3
> 
> That's in v3.7-rc2 already, is there some other problem too?

Will try a re-test.

- Paul
