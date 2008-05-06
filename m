From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: public git l2 cache off.
Date: Tue, 6 May 2008 11:51:38 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290439AE8F@dlee13.ent.ti.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com> <4BE5184F-5D21-4487-B19A-DCA436A9C77E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48669 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758998AbYEFQwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 12:52:14 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4BE5184F-5D21-4487-B19A-DCA436A9C77E@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

> Beagleboard (omap3530)
> 
> > I'll try the latest from here on SDP with this and see if it works.
> > There is also a difference in CR handling.  I had submitted long
> > back a fix to Russell but let it get by me as I didn't have the time
> > to fix per his comments.  I think our version was more correct then
> > the one in place but was still lacking a bit.
> >
> > [*] It seems possible you could have an issue depending on what your
> > boot loader is or isn't doing for you.
> 
> U-boot (both 1.1.4 and 1.3.2) calls l2disable() before booting linux,
> so linux needs to enable it. I vote for removing the l2disable() in u-
> boot, but I can see that people might be stuck with broken binary
> bootloaders...

Yes, this 'might' help for some users if it works.  Traditionally things usually have had some complications here at multiple levels in both hardware and software.  And yes not everyone can upgrade a boot loader.  However, with expanding boot from MMC/SD support things are getting safer.

The bit I was more worried about was the boot loader may not be invalidating secure L2 tags correctly.  The method to do this correctly is a little different between EMU/HS and GP devices.  Also these base methods changed some between ES1 and ES2 of the chip.  I hope no one is using an ES1 anymore but I'm sure code remnants exist.

The working code variants did some work in u-boot and some in the kernel to handle these conditions.  The current balance today in working variants today has u-boot doing more work.  This probably merges with fewer conflicts with the arm-kernel.  Last I checked u-boot on Beagle was a based on an older version of the code and probably even a wider range of versions exist in the community.  As such it's a good bet some of this is at the root of the problems you are seeing.

It is important to keep x-loader/u-boot/kernel somewhat in sync for some of these kinds of issues until the development process has settled down and code matured.

L2 cache is a huge performance boost on an OMAP3 so it's good to get it.  Also you really haven't validated your software if you're running with it off.

Regards,
Richard W.

