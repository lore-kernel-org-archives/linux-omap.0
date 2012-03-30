From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: AM3517evm
Date: Fri, 30 Mar 2012 10:09:55 -0700
Message-ID: <20120330170955.GB19100@animalcreek.com>
References: <CAFu+nvFt8BcO1pDD6CXXM056WYG9AQDTv-boc7xF0C2JuHAyYw@mail.gmail.com>
 <4F5E0036.105@visionsystems.de>
 <20120315154335.GA29645@animalcreek.com>
 <4F621048.2090003@visionsystems.de>
 <20120315164221.GB29645@animalcreek.com>
 <20120315165245.GC29645@animalcreek.com>
 <4F7478D1.5080708@visionsystems.de>
 <4F758069.80502@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38367 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2C3RJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 13:09:56 -0400
Content-Disposition: inline
In-Reply-To: <4F758069.80502@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "George C. Huntington, III" <george.huntingtoniii@gmail.com>, linux-omap@vger.kernel.org, mporter@ti.com

On Fri, Mar 30, 2012 at 11:44:09AM +0200, Yegor Yefremov wrote:
> Am 29.03.2012 16:59, schrieb Yegor Yefremov:
> > Am 15.03.2012 17:52, schrieb Mark A. Greer:
> >> On Thu, Mar 15, 2012 at 09:42:21AM -0700, Mark A. Greer wrote:
> >>> On Thu, Mar 15, 2012 at 04:52:40PM +0100, Yegor Yefremov wrote:
> >>>> Am 15.03.2012 16:43, schrieb Mark A. Greer:
> >>>>> On Mon, Mar 12, 2012 at 02:55:02PM +0100, Yegor Yefremov wrote:
> >>>>>> Am 09.03.2012 18:22, schrieb George C. Huntington, III:
> >>>>>>> I would like to make the newer kernel (3.x) work with the AM3517EVM.
> >>>>>>> I have a 2.6.32 and a 2.6.33 that run well on the board, but the
> >>>>>>> recent kernels have kernel panics before even running init.  where
> >>>>>>> should I start?  is there a better place to pursue this?
> >>>>>> Have you tried this one? http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary
> >>>>>>
> >>>>>> I have this one booting one month ago, but I checked out the kernel today and it hangs somewhere:
> >>>>>>
> >>>>>> Starting kernel ...
> >>>>>>
> >>>>>> Uncompressing Linux... done, booting the kernel.
> >>>>> This looks like you have your console device set to ttyS2 instead of ttyO2.
> >>>>>
> >>>>> Which branch of that repository did you use?
> >>>> My kernel params: CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200" and I force them, so bootloader has nothing to say.
> >>>>
> >>>> I'm using master branch.
> >>> I just booted the latest master branch (b8fe178) with the hack below.
> >>> (Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw
> >>> rootfstype=ext3 rootwait)
> >> I meant to add that I booted an am3517evm.
> > 
> > Is frame buffer working? I can boot with the latest linux-omap version, but as soon as I enable omapfb, kernel freezes before making any output to the serial console. Have I missed some DSS/DPI patches?

[Sorry for the delay.  I didn't notice your email until now.]

> 
> After some research I found out that only the master branch is broken. At least rc7 is O.K.:
> 
> git checkout v3.3-rc7
> 
> master freezes:
> 
> git checkout origin/master 

I'm not sure what you're trying to say here.

> According to commit log (http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=b8fe1781ec8bed5e086691a827a6ee11facec2aa), there is nothing suspicious. 

Its not necessarily that commit.  It could be any commit between v3.3-rc7 and the current one (including the current one).

> How can I see the real difference between v3.3-rc7 and master branch? Is this command sufficient?
> 
> git diff v3.3-rc7..origin/master

Yes, that will show the actual diff.

Another way to view it would be to use gitk or qgit (or ...) to see
the commits that have been applied since v3.3-rc7.

Mark
--
