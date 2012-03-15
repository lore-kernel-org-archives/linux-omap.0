From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: AM3517evm
Date: Thu, 15 Mar 2012 09:42:21 -0700
Message-ID: <20120315164221.GB29645@animalcreek.com>
References: <CAFu+nvFt8BcO1pDD6CXXM056WYG9AQDTv-boc7xF0C2JuHAyYw@mail.gmail.com>
 <4F5E0036.105@visionsystems.de>
 <20120315154335.GA29645@animalcreek.com>
 <4F621048.2090003@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:44088 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031620Ab2COQmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 12:42:22 -0400
Content-Disposition: inline
In-Reply-To: <4F621048.2090003@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "George C. Huntington, III" <george.huntingtoniii@gmail.com>, linux-omap@vger.kernel.org, mporter@ti.com

On Thu, Mar 15, 2012 at 04:52:40PM +0100, Yegor Yefremov wrote:
> Am 15.03.2012 16:43, schrieb Mark A. Greer:
> > On Mon, Mar 12, 2012 at 02:55:02PM +0100, Yegor Yefremov wrote:
> >> Am 09.03.2012 18:22, schrieb George C. Huntington, III:
> >>> I would like to make the newer kernel (3.x) work with the AM3517EVM.
> >>> I have a 2.6.32 and a 2.6.33 that run well on the board, but the
> >>> recent kernels have kernel panics before even running init.  where
> >>> should I start?  is there a better place to pursue this?
> >> Have you tried this one? http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary
> >>
> >> I have this one booting one month ago, but I checked out the kernel today and it hangs somewhere:
> >>
> >> Starting kernel ...
> >>
> >> Uncompressing Linux... done, booting the kernel.
> > This looks like you have your console device set to ttyS2 instead of ttyO2.
> >
> > Which branch of that repository did you use?
> 
> My kernel params: CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200" and I force them, so bootloader has nothing to say.
> 
> I'm using master branch.

I just booted the latest master branch (b8fe178) with the hack below.
(Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw
rootfstype=ext3 rootwait)

Note that it is a ***HACK*** and should only be used temporarily.

Also note that I've been working on fixing up some of the am35x issues
including PM related ones that I'm in the middle of right now.  If all goes
to plan, the am35x code will work better in the community in the
not-too-distant future.

Mark
--

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 027a537..5d1952b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -397,7 +397,7 @@ static void omap3_pm_idle(void)
 {
        local_fiq_disable();
 
-       if (omap_irq_pending())
+       if (omap_irq_pending() || !omap3_has_io_wakeup())
                goto out;
 
        trace_power_start(POWER_CSTATE, 1, smp_processor_id());

