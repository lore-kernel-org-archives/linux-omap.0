From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap2: Assorted GPMC cleanups
Date: Wed, 8 Jan 2014 15:40:48 -0800
Message-ID: <20140108234048.GH31323@atomide.com>
References: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140108191836.GD31323@atomide.com>
 <20140108233815.GC2595@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53165 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425AbaAHXkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 18:40:53 -0500
Content-Disposition: inline
In-Reply-To: <20140108233815.GC2595@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Pekon Gupta <pekon@ti.com>, linux-mtd@lists.infradead.org, Jon Hunter <jgchunter@gmail.com>

* Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [140108 15:39]:
> On Wed, Jan 08, 2014 at 11:18:37AM -0800, Tony Lindgren wrote:
> > * Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [131027 17:52]:
> > > (I'm CCing the MTD list, because GPMC is the memory controller
> > > used for NOR, NAND and OneNAND devices).
> > > 
> > > Hi all,
> > > 
> > > Just a small patchset containing two small cleanups and a minor fix
> > > for the GPMC memory controller. The first two are cleanups and can
> > > be considered as preparation work for the fix.
> > > 
> > > The fix is patch 3/3: "Move legacy GPMC width setting". It makes
> > > explicit use of the DT property "gpmc,device-width" and removes the
> > > subsequent (and redundant) setting of the GPMC width, based in the
> > > NAND bus widht.
> > 
> > Thanks and sorry for the delay. Applying these all into branch
> > omap-for-v3.14/fixes-not-urgent.
> > 
> 
> No problem. I'll give this a test/review next week.
> 
> Do we still need the board-file (legacy) workaround in this patchset?
> I was actually waiting for you to clean-up completely that, before
> re-sending the series, without the board-file workaround.

Yes we still need it for a little bit longer.

Regards,

Tony
