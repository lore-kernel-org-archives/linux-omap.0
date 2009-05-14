From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch "REMOVE OMAP LEGACY CODE: Reset mach-omap1/board-*.c
	files to mainline" breaks nokia770
Date: Thu, 14 May 2009 11:04:58 +0300
Message-ID: <20090514080458.GC10386@nokia.com>
References: <20090514004651.77342rqoq5tz86ww@lidskialf.net> <20090514002335.GA9538@nokia.com> <20090514014413.GE5593@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17730 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZENIPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 04:15:17 -0400
Content-Disposition: inline
In-Reply-To: <20090514014413.GE5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Andrew de Quincey <adq_dvb@lidskialf.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 14, 2009 at 03:44:14AM +0200, ext Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [090513 17:33]:
> > On Thu, May 14, 2009 at 01:46:51AM +0200, ext Andrew de Quincey wrote:
> > > Hi, I've just discovered that the patch at:
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=3eae3ea7c443fc4330574dffea65b6f2f53a2574
> > > 
> > > Breaks the nokia770's framebuffer as it removes the platform data for  
> > > the HWA742 LCD controller.
> > > 
> > > As the patch says "Patches against the mainline tree are welcome to  
> > > add back the missing functionality if needed!", I'm happy to do this.
> > > 
> > > However, since I'm fairly new to the linux-omap project, is simply  
> > > extracting the removed nokia770 code and generating a patch against  
> > > the mainline kernel sufficient? or is there a newer style of some sort  
> > > that should be adopted for this?
> > 
> > You can start by generating the new patch against mainline and running
> > scripts/checkpatch.pl, then you should probably find out if there are
> > any API changes and stuff like that. Then send the patch to lkml ccing
> > linux-omap and let's see what comments do you get from those guys :-)
> 
> Please change the code to pass the struct clock to drivers/video/omap/hwa742.c
> in hwa742_platform_data. The hw742.c can just do standard clk_enable/disable
> there. Otherwise we won't be able to get this missing part to the mainline
> kernel.

how about clkdev then ? are we gonna support that for omap1 still ?

-- 
balbi
