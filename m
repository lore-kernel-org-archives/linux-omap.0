From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Mon, 4 Aug 2008 23:42:49 +0200
Message-ID: <20080804214249.GI31974@xi.wantstofly.org>
References: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com> <200808041326.38840.david-b@pacbell.net> <20080804205617.GF31974@xi.wantstofly.org> <200808041437.34822.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([83.160.184.112]:44432 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765858AbYHDVmv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 17:42:51 -0400
Content-Disposition: inline
In-Reply-To: <200808041437.34822.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, "Kamat, Nishant" <nskamat@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Mon, Aug 04, 2008 at 02:37:34PM -0700, David Brownell wrote:

> > I've never seen CPU endianity being hardwired in any ARM system ever
> > -- but maybe OMAP is different.
> 
> I'll let TI answer that one, since I'm not going to look at docs for
> all the ARM's I've ever used.
> 
> My observation stands *REGARDLESS* of whether endianness was fixed in
> hardware, bootloader, or kernel ... and in any case, with very few
> exceptions (not including OMAP), Linux uses ARMs in LE mode:
> 
>   ~/kernel/linux-2.6/arch/arm/configs$ grep ENDIAN * | egrep -v '#' |egrep -v OHCI
>   ixp2000_defconfig:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
>   ixp2000_defconfig:CONFIG_CPU_BIG_ENDIAN=y
>   ixp23xx_defconfig:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
>   ixp23xx_defconfig:CONFIG_CPU_BIG_ENDIAN=y
>   ixp4xx_defconfig:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
>   ixp4xx_defconfig:CONFIG_CPU_BIG_ENDIAN=y
>   ~/kernel/linux-2.6/arch/arm/configs$  ls | wc -l
>   105
>   ~/kernel/linux-2.6/arch/arm/configs$ 

That's just because not many people ask for BE or use BE -- not
because the LE'ness would be hardwired in hardware as you asserted
earlier.


> To repeat:  there's no point in having the words byteswapped when
> writing, then again when reading, like this driver does.  All that
> does is ensure slow I/O paths.  Were you disagreeing with that main
> point?  Or just quibbling about where any unusual big-endianness
> might come from?

I was responding to your statement that ARM CPU endianity is
hardwired when ARM cores are turned into silicon.
