From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: fix build, sparse problems in
 cleanup-headers
Date: Fri, 26 Oct 2012 13:19:43 -0700
Message-ID: <20121026201943.GS11908@atomide.com>
References: <alpine.DEB.2.00.1210262012250.11258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43118 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966367Ab2JZUTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:19:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210262012250.11258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121026 13:16]:
> Hi Tony,
> 
> The following changes since commit 2da8a79f7d81853d00b6a00621aeef7545196084:
> 
>   Merge branch 'omap-for-v3.8/cleanup-headers-menelaus' into omap-for-v3.8/cleanup-headers (2012-10-25 12:21:48 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-fixes-a-for-3.8
> 
> for you to fetch changes up to 97af08b6e10e06563309728ed2fe8fdd919c5a33:
> 
>   ARM: OMAP1: fix sparse warning added by commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3 (2012-10-26 13:21:48 -0600)
> 
> ----------------------------------------------------------------
> Several fixes for build failures and sparse warnings in the
> OMAP cleanup-headers branch.  Intended for 3.8 cleanup.
> 
> Basic build, boot, and PM test logs are available from here:
> 
>     http://www.pwsan.com/omap/testlogs/cleanup-headers-compile-fixes-3.8/20121026132711/
> 
> Due to underlying problems in v3.7-rc2, several tests fail.  These
> failures are unrelated to these patches.

Thanks pulling into omap-for-v3.8/cleanup-headers.

Regards,

Tony
 
> ----------------------------------------------------------------
> Paul Walmsley (3):
>       ARM: OMAP2+: fix build breakage introduced by commit b7754452b3e27716347a528b47b0a1083af32520
>       ARM: OMAP1: fix build breakage introduced by commit 25c7d49ed48b4843da7dea56a81ae7f620211ee0
>       ARM: OMAP1: fix sparse warning added by commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3
> 
>  arch/arm/mach-omap1/fpga.c   |    1 +
>  arch/arm/mach-omap1/pm_bus.c |    2 ++
>  drivers/mtd/onenand/omap2.c  |   36 ++++++++++++++++++++++++------------
>  3 files changed, 27 insertions(+), 12 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
