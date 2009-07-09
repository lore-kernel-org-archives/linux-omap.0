From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [PATCH 0/44] includecheck: fix multiple includes
Date: Thu, 09 Jul 2009 09:58:31 +0530
Message-ID: <1247113711.2453.27.camel@ht.satnam>
References: <1247063308.4382.12.camel@ht.satnam>
	 <1247076059.4382.127.camel@ht.satnam>
	 <20090708211321.GA15928@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47003 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbZGIEa2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jul 2009 00:30:28 -0400
In-Reply-To: <20090708211321.GA15928@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, davinci <davinci-linux-open-source@linux.davincidsp.com>, Hugo Villeneuve <hugo.villeneuve@lyrtec>

On Wed, 2009-07-08 at 22:13 +0100, Russell King wrote:
> On Wed, Jul 08, 2009 at 11:30:59PM +0530, Jaswinder Singh Rajput wrote:
> > I am still waiting ACK/NAK for :
> > 
> >       includecheck fix: arm, misc.c
> >       includecheck fix: arm, atomic.h
> >       includecheck fix: arm, board-dm355-evm.c
> >       includecheck fix: arm, board-dm355-leopard.c
> >       includecheck fix: arm, board-dm644x-evm.c
> >       includecheck fix: arm, board-dm646x-evm.c
> >       includecheck fix: arm, board-sffsdr.c
> >       includecheck fix: arm, mach-mx3/devices.c
> >       includecheck fix: arm, mach-omap1/mcbsp.c
> >       includecheck fix: arm, mach-omap2/mcbsp.c
> >       includecheck fix: arm, plat-s3c64xx/pm.c
> >       includecheck fix: arm, plat-stmp3xxx/pinmux.c
> 
> You're still waiting because apparantly you never sent this set anywhere
> near any ARM people before.
> 
> For the first two, I'll ack them:
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> The remainder look sane to me, but you'll have to seek acks from the
> individual platform maintainer(s).
> 

OK, adding some more ARM people and ARM lists to get remaining ACK/NAK.

Patches are already posted to LKML and also available at :

http://git.kernel.org/?p=linux/kernel/git/jaswinder/headers-check-2.6.git;a=summary

In case if you are not able to find these patches let me know.

Thanks,
--
JSR


