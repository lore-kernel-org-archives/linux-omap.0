From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: Generic cleanups for 3.10
Date: Wed, 27 Mar 2013 11:03:21 -0700
Message-ID: <20130327180321.GB10155@atomide.com>
References: <1363768789-17929-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63887 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751128Ab3C0SDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 14:03:23 -0400
Content-Disposition: inline
In-Reply-To: <1363768789-17929-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:42]:
> Tony,
> 
> Here is the pull request for various OMAP cleanups and fixes which are posted
> earlier on the list. It contains OMAP4 smp cleanup, removal of unwanted static
> deps from OMAP4, RAM offset consolidation and fiq tuple cleanup. 
> 
> 
> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> 
>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_generic_cleanup
> 
> for you to fetch changes up to 37e1f64c3bc2b3455a9688de8527a341847b3ad9:
> 
>   ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build (2013-03-19 12:57:30 +0530)

Thanks pulled this into omap-for-v3.10/cleanup.

Regards,

Tony
