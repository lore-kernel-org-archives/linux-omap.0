From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Mon, 4 Aug 2008 14:37:34 -0700
Message-ID: <200808041437.34822.david-b@pacbell.net>
References: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com> <200808041326.38840.david-b@pacbell.net> <20080804205617.GF31974@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:28335 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1765651AbYHDVhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 17:37:37 -0400
In-Reply-To: <20080804205617.GF31974@xi.wantstofly.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Tony Lindgren <tony@atomide.com>, "Kamat, Nishant" <nskamat@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Monday 04 August 2008, Lennert Buytenhek wrote:
> 
> I've never seen CPU endianity being hardwired in any ARM system ever
> -- but maybe OMAP is different.

I'll let TI answer that one, since I'm not going to look at docs for
all the ARM's I've ever used.

My observation stands *REGARDLESS* of whether endianness was fixed in
hardware, bootloader, or kernel ... and in any case, with very few
exceptions (not including OMAP), Linux uses ARMs in LE mode:

  ~/kernel/linux-2.6/arch/arm/configs$ grep ENDIAN * | egrep -v '#' |egrep -v OHCI
  ixp2000_defconfig:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
  ixp2000_defconfig:CONFIG_CPU_BIG_ENDIAN=y
  ixp23xx_defconfig:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
  ixp23xx_defconfig:CONFIG_CPU_BIG_ENDIAN=y
  ixp4xx_defconfig:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
  ixp4xx_defconfig:CONFIG_CPU_BIG_ENDIAN=y
  ~/kernel/linux-2.6/arch/arm/configs$  ls | wc -l
  105
  ~/kernel/linux-2.6/arch/arm/configs$ 

To repeat:  there's no point in having the words byteswapped when
writing, then again when reading, like this driver does.  All that
does is ensure slow I/O paths.  Were you disagreeing with that main
point?  Or just quibbling about where any unusual big-endianness
might come from?

- Dave
