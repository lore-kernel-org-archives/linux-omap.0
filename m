From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 11:17:22 -0800
Message-ID: <20090123191721.GW7172@atomide.com>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk> <20090123011726.GG7172@atomide.com> <20090123174249.GM26184@n2100.arm.linux.org.uk> <20090123175401.GU7172@atomide.com> <7B4574D56E4ADF438756313E9A172A872CABB868@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55157 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbZAWTRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 14:17:25 -0500
Content-Disposition: inline
In-Reply-To: <7B4574D56E4ADF438756313E9A172A872CABB868@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Stanley Miao <stanley.miao@windriver.com>

* Hunter, Jon <jon-hunter@ti.com> [090123 11:03]:
> Tony Lindgren wrote on Friday, January 23, 2009 11:54 AM:
> 
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090123 09:43]:
> >> On Thu, Jan 22, 2009 at 05:17:28PM -0800, Tony Lindgren wrote:
> >>> Basically we currently cannot use virtual clocks because of this
> >>> and the fact that the parent of the virtual clock may not be known
> >>> as pointed out by Paul Walmsley.
> >>
> >> One other thing I'd like to confirm is how the kernel treats the
> >> OMAP5912. OMAP5912 is interesting to me at the moment because it
> >> seems that all the information on it is freely available.  I don't
> >> know about the others.
> >>
> >> However, it would be useful to know how the kernel treats this - iow,
> >> which of the four categories for OMAP1 SoCs - 310, 730, 1510, 1610.
> >
> > 5912 = 1611b = 16xx. Then 1710 is quite similar.
> 
> Right, the OMAP5912 started off life as the 1611, but 1611 involved into the 1621. So really 5912 = 1621. There are a couple differences between the 1610 and 1621, one of the main being the size of the internal RAM.

Thanks for setting that straight. And looks like we have cpu_is_omap1621()
macro in the kernel.

> >> Of course, if someone knows (or can send me, maybe Richard W?) where
> >> there's a similar document to spru751a for the clock architecture for
> >> these other CPUs (and OMAP2420, OMAP2430, OMAP3430, etc) it would be
> >> most useful.
> 
> Unfortunately, most of the original devices have NDA restrictions which is a royal pain in the neck especially for people in the open-source community who would like to develop with these. I am sure this infuriates many. Please don't shoot the messenger!
> 
> I am disappointed it is still that way for some of these parts. The good news is that for OMAP3 we appear to be getting our act together here.
> 
> > I have some links on my webpage to the docs:
> >
> > http://www.muru.com/linux/omap/
> 
> Tony, I see you have a link on your website to the OMAP3525. The OMAP3530 == OMAP3430, I would recommend that you point people to the following product folder for documentation:
> http://focus.ti.com/docs/prod/folders/print/omap3530.html

Thanks, fixed now. Also removed some earlier dead link.

> The OMAP3525 has a reduced feature set...see the following page for an overview of the OMAP35xx series:
> http://wiki.omap.com/index.php?title=OMAP3_Overview
> 
> Cheers
> Jon
> 
> 
