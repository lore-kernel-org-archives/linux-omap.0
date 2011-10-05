From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 11:59:16 -0700
Message-ID: <20111005185916.GB6324@atomide.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
 <20111005162618.GA6324@atomide.com>
 <CAGDS+nkHCmt0+Z82fSX3+bRLy4RR-_4vegb0tGUwD5u_ttnMSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26945 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933170Ab1JES7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 14:59:18 -0400
Content-Disposition: inline
In-Reply-To: <CAGDS+nkHCmt0+Z82fSX3+bRLy4RR-_4vegb0tGUwD5u_ttnMSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Dave Hylands <dhylands@gmail.com>, linux-omap@vger.kernel.org

* Steve Sakoman <sakoman@gmail.com> [111005 10:46]:
> On Wed, Oct 5, 2011 at 9:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Dave Hylands <dhylands@gmail.com> [111004 23:41]:
> 
> >> I then also had to modify drivers/mmc/card/block.c and initializing
> >> disable_multi to 1 in the mmc_blk_issue_rw_rq function to get rid of
> >> the following messages for every I/O request.
> >>
> >> mmcblk0: retrying using single block read
> >> mmcblk0: retrying using single block read
> >> mmcblk0: retrying using single block read
> >> mmcblk0: retrying using single block read
> >>
> >> (since this revision of the silicon doesn't support multi-block MMC reads).
> >
> > ..but this one is usually a problem muxing the MMC data lines.
> >
> > Are you sure this revision only supports one data line?
> 
> No, I think you misunderstood the issue!
> 
> The issue is that multi-block mmc reads are broken and the code falls
> back to single block reads but prints a warning each time.
> 
> Looking for a definitive source for this errata with Google I find:
> 
> "According to the TI docs, multiple block read transfer
> does not work correctly in CPU revisions 2.1 and earlier (TI advisory
> 2.1.1.128)."

OK, thanks for correcting me.
 
> So the correct fix is probably to use multi-block reads only on
> revisions post 2.1.

Or just permanently switch to single-block reads if the multi-block
reads fail?

Regards,

Tony
