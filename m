From: Tony Lindgren <tony@atomide.com>
Subject: Re: public git l2 cache off.
Date: Tue, 6 May 2008 14:25:41 -0700
Message-ID: <20080506212541.GB18682@atomide.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com> <4BE5184F-5D21-4487-B19A-DCA436A9C77E@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AE8F@dlee13.ent.ti.com> <137745C3-BCAB-4A39-8023-F255463194BF@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65338 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578AbYEFVZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 17:25:45 -0400
Content-Disposition: inline
In-Reply-To: <137745C3-BCAB-4A39-8023-F255463194BF@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap@vger.kernel.org

* Koen Kooi <k.kooi@student.utwente.nl> [080506 10:02]:
> 
> Op 6 mei 2008, om 18:51 heeft Woodruff, Richard het volgende geschreven:
> >> Beagleboard (omap3530)
> >>
> >>> I'll try the latest from here on SDP with this and see if it works.
> >>> There is also a difference in CR handling.  I had submitted long
> >>> back a fix to Russell but let it get by me as I didn't have the time
> >>> to fix per his comments.  I think our version was more correct then
> >>> the one in place but was still lacking a bit.
> >>>
> >>> [*] It seems possible you could have an issue depending on what your
> >>> boot loader is or isn't doing for you.
> >>
> >> U-boot (both 1.1.4 and 1.3.2) calls l2disable() before booting linux,
> >> so linux needs to enable it. I vote for removing the l2disable() in  
> >> u-
> >> boot, but I can see that people might be stuck with broken binary
> >> bootloaders...
> >
> > Yes, this 'might' help for some users if it works.  Traditionally  
> > things usually have had some complications here at multiple levels  
> > in both hardware and software.  And yes not everyone can upgrade a  
> > boot loader.  However, with expanding boot from MMC/SD support  
> > things are getting safer.
> >
> > The bit I was more worried about was the boot loader may not be  
> > invalidating secure L2 tags correctly.  The method to do this  
> > correctly is a little different between EMU/HS and GP devices.  Also  
> > these base methods changed some between ES1 and ES2 of the chip.  I  
> > hope no one is using an ES1 anymore but I'm sure code remnants exist.
> >
> > The working code variants did some work in u-boot and some in the  
> > kernel to handle these conditions.  The current balance today in  
> > working variants today has u-boot doing more work.  This probably  
> > merges with fewer conflicts with the arm-kernel.  Last I checked u- 
> > boot on Beagle was a based on an older version of the code and  
> > probably even a wider range of versions exist in the community.  As  
> > such it's a good bet some of this is at the root of the problems you  
> > are seeing.
> 
> I'm currently using the u-boot Jason built (1.3.2 + beagle patches)  
> which disables l2 cache before boot and I switch between 2.6.22-wtbu  
> (which enables L2) and git HEAD (which doesn't enable L2).

Sounds like the bootloader should configure L2 cache and just leave
the C bit off for kernel looking at the "Cortex-A8 L2 cache handling at
startup?" thread on linux-arm-kernel. I guess the L2 configuration
is implementation specific and cannot be read from the ARM registers.

Regards,

Tony


> 
> regards,
> 
> Koen
> 
> 
> >
> >
> > It is important to keep x-loader/u-boot/kernel somewhat in sync for  
> > some of these kinds of issues until the development process has  
> > settled down and code matured.
> >
> > L2 cache is a huge performance boost on an OMAP3 so it's good to get  
> > it.  Also you really haven't validated your software if you're  
> > running with it off.
> >
> > Regards,
> > Richard W.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux- 
> > omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
