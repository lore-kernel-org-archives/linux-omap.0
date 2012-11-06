From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
Date: Tue, 6 Nov 2012 14:08:34 -0800
Message-ID: <20121106220833.GQ6801@atomide.com>
References: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42629 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753206Ab2KFWIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 17:08:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121101 05:18]:
> Hi Tony
> 
> The following changes since commit 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33:
> 
>   Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm (2012-10-26 13:32:22 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-b-for-3.8
> 
> for you to fetch changes up to f17d60d20eb8e679cdd1e9d507394237e58ce0d8:

Tried pulling but..

> These patches remove the use of omap_prcm_get_reset_sources() from the
> OMAP watchdog driver, and remove mach-omap2/prcm.c and
> plat-omap/include/plat/prcm.h.
> 
> Basic test logs for this branch on top of Tony's cleanup-prcm branch
> at commit 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33 are here:
> 
>     http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/
> 
> However, cleanup-prcm at 7fc54fd3 does not build for several
> Kconfigs here and doesn't include some fixes that are needed for
> a successful test.  With several reverts, fixes, and workarounds
> applied, the following test logs were obtained:

..now wondering which configs do not build for you at 7fc54fd3?

It builds at least all my test configs. Well at least the ones
I have recovered after accidentally deleting some files yesterday,
did not have a back up copy of two of them.

However if I pull your branch in, build breaks for me for
with the rmk-omap3430-ldp-noconfig and rmk-omap4430-sdp-noconfig:

arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x48): undefined reference to `omap44xx_restart'

Regards,

Tony
