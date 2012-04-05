From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod
 fixes for early v3.4-rc
Date: Wed, 4 Apr 2012 17:41:40 -0700
Message-ID: <20120405004139.GA10780@atomide.com>
References: <alpine.DEB.2.00.1204041658200.7161@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45207 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab2DEAln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 20:41:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204041658200.7161@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120404 16:03]:
> Hi Tony,
> 
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> 
>   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-fixes-a-for-3.4rc
> 
> for you to fetch changes up to cf1a9298231d7719b67ad0eae6236c91888b7a32:
> 
>   Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', 'hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hwmod_fixes_3.4rc', 'powerdomain_fixes_a_3.4rc' and 'prcm_fixes_3.4rc' into fixes_for_3.4rc2 (2012-04-04 14:53:33 -0600)
> 
> These changes have been boot-tested on OMAP37xx ES1.0 Beagleboard-XM,
> OMAP2420 N800, OMAP4430 ES2.0 Pandaboard, and OMAP35xx ES3.0
> BeagleBoard.  System suspend and serial wakeup has been tested
> on OMAP4430 ES2.0 Pandaboard, and dynamic retention idle and serial
> wakeup has been tested on OMAP35xx ES3.0 BeagleBoard.

Thanks, looks like two of these patches I already merged into
fixes yesterday from your earlier pull request. So merging this
in would cause duplicate commits. Can you please update your
branch to remove those two commits?

Meanwhile, I've merged your branch into linux-omap master branch
for some more testing while waiting for the update.

Regards,

Tony
