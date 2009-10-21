From: Ladislav.Michl@seznam.cz
Subject: Re: [APPLIED] [PATCH] [RFC] OMAP: eliminate OMAP_MAX_NR_PORTS
Date: Wed, 21 Oct 2009 11:48:19 +0200
Message-ID: <20091021094819.GA2111@localhost.localdomain>
References: <1254995997-26420-1-git-send-email-virtuoso@slind.org> <notify-1255128339@atomide.com> <20091020233115.GA7363@localhost.localdomain> <20091020221543.GL12576@atomide.com> <20091020230131.GB16230@atomide.com> <20091021004016.GD16230@atomide.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:44348 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbZJUHsN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 03:48:13 -0400
Content-Disposition: inline
In-Reply-To: <20091021004016.GD16230@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Tue, Oct 20, 2009 at 05:40:17PM -0700, Tony Lindgren wrote:
> > > > Unable to handle kernel NULL pointer dereference at virtual address 00000028
> > > > pgd = c0004000
> > > > [00000028] *pgd=00000000
> > > > Internal error: Oops: 80000005 [#1]
> > > > last sysfs file:
> > > > Modules linked in:
> > > > CPU: 0    Not tainted  (2.6.32-rc5-06314-g4155da6-dirty #12)
> > > > PC is at 0x28
> > > > LR is at serial8250_config_port+0x184/0xc34
> > > > (...etc...)
> > > > 
> > > > Please consider following fix (and while there fix OMAP2 too as patch broke
> > > > it as well (untested))
> > > 
> > > Thanks, I already refreshed the original patch with the same fix few
> > > days ago :) It should be there in for-next branch and master branch.
> > 
> > Correction, sorry looks like I did not really read your patch. It seems
> > to be the right solution for mach-omap1, but not needed for mach-omap2
> > because the array is not plat_serial8250_port on mach-omap2.

Ach, sorry. Now it was me who didn't read code carefully.

> I've refreshed the original serial.c patch in for-next branch by leaving
> out the mach-omap2 changes. Also updated in the master branch, can you
> please check?

Just pulled master branch and succesfully booted on OMAP5910 board.

Thank you,
	ladis
