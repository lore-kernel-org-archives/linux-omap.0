From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 00/10] ARM: OMAP: PM usecounting changes
Date: Tue, 25 Sep 2012 14:53:21 +0300
Message-ID: <1348574001.10702.291.camel@sokoban>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
	 <506186E9.7070908@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2IYLx0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 07:53:26 -0400
In-Reply-To: <506186E9.7070908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 2012-09-25 at 15:56 +0530, Rajendra Nayak wrote:
> Hi Tero,
> 
> On Tuesday 25 September 2012 03:02 PM, Tero Kristo wrote:
> > Hi,
> >
> > Changes compared to previous version:
> 
> Did you get a chance to look at the issue I reported about autodeps?
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg72876.html

Not really, I didn't think that bug report was meant for me, I kind of
thought it only happened with your set. But now looking at your email in
detail, I guess you are saying there is a bug in this code (the one that
touches iclk stuff), which causes the USB / DSS domains to follow
MPU/CORE, is that right?

-Tero

> 
> regards,
> Rajendra
> 
> >
> > - Fixed OMAP4 support (patches 7-10)
> > - Dropped debugging support from this set for now
> > - Rebased on top of 3.6-rc5 + func-pwrst + omap4-ret code
> >    (omap4 support easier to test with these)
> > - Patch #1:
> >    * dropped clkdm_usecount_inc / clkdm_usecount_dec APIs
> >    * clkdm_clk_enable / disable are used now instead
> >    * some code ordering changed for the new setup to work properly
> >    * changed BUG_ON calls to WARN_ON
> > - Patch #2:
> >    * added spinlock for protecting voltdm callbacks
> >    * pwrdm lock extended to protect pwrdm callbacks
> > - Patch #3:
> >    * dropped generic API call for the cpu pwrdm idle / wakeup
> >    * instead use pwrdm_clkdm_enable / disable calls directly from PM code
> >    * omap4 support fixed to work properly with SMP, added omap4 specific
> >      CPU pwrdm idle / wakeup calls for this purpose
> > - Patch #4:
> >    * no changes
> >    * added 'Reviewed-by' tag for Rajendra
> > - Patch #5:
> >    * no changes, just rebase
> > - Patch #6:
> >    * no changes
> >
> > Tested with OMAP3 beagle, omap4460 GP panda + omap4430 EMU blaze boards.
> >
> > I will be posting new versions for the voltdm fixes + auto retention +
> > panda board tps6236x support code later on today, which are based on top
> > of this set.
> >
> > Branch also available here:
> >
> > git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > branch: mainline-3.6-rc5-pwrdm-changes-v5
> >
> > -Tero
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 


