From: Tony Lindgren <tony@atomide.com>
Subject: Re: N810: linux-2.6.26-rc2-omap1 with muru.com N810 patches
Date: Thu, 15 May 2008 11:28:41 -0700
Message-ID: <20080515182840.GS8928@atomide.com>
References: <20080515140914.GA30594@swansys> <20080515165448.GB8875@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53867 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbYEOS2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 14:28:42 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1JwiC0-0002lq-Lv
	for linux-omap@vger.kernel.org; Thu, 15 May 2008 18:28:41 +0000
Content-Disposition: inline
In-Reply-To: <20080515165448.GB8875@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

* green <greenfreedom10@gmail.com> [080515 10:03]:
> On Thu, 2008.05.15, 136, green wrote:
> > I have built a Debian Sid armel chroot on the N810 and have compiled many 
> > kernels in the chroot.  I send the kernels to the N810 using the flasher (-f 
> > -k $IMAGE -R).
> 
> I've also built 2.6.26-rc2-omap1 (with muru.com N810 patches) on my amd64 
> system using the gnueabi tools from emdebian.org.
> 
> gcc 4.3.0-4
> binutils 2.18.1~cvs20080103-4
> 
> Same results.
> >  - The NOKIA splash screen is displayed for about 20 seconds and then the N810 
> > powers off.

Hmm, the patches I've posted should work fine to mount root from
internal MMC card (assuming you have both cards inserted right now...)

You should see the white Nokia splash screen for few seconds, then
the black framebuffer console with penguin.

I tarred up my n810 hacks to http://muru.com/linux/n8x0/ with the
keyboard patches included.

Here's also a temporary test zImage:

http://muru.com/linux/n8x0/zImage-n8x0-2008-05-15

You can test that with:

$ flasher -k zImage-n8x0-2008-05-15 -l -b

I'll remove that zImage at some point soon because of my limited
server bandwidth.. This zImage works with n810, and seemed to boot
on n800 too.

BTW, you need to disable rd mode with flasher --disable-rd-mode with
the serial clock hack applied. Otherwise the boot won't complete. Or
at least you should not have --set-rd-flags=serial-console set.

Tony
