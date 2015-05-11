From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: first set of hwmod fixes for v4.1-rc
Date: Mon, 11 May 2015 13:24:50 -0700
Message-ID: <20150511202449.GF15563@atomide.com>
References: <alpine.DEB.2.02.1505082043110.19833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50396 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbbEKUYw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 16:24:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1505082043110.19833@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150508 13:44]:
> Hi Tony,
> 
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.1-rc/omap-fixes-a
> 
> for you to fetch changes up to a5bf00cd735fbc293da8a9bada589c02861c8132:
> 
>   ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality (2015-05-08 13:05:19 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: first set of hwmod fixes for v4.1-rc
> 
> Fix a few AM43xx problems: add the VPFE hwmod data, which removes some
> warnings; and fix the IP block hardreset implementation.
> 
> Basic build, boot, and PM test results are here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.1-rc/20150508130543/
> 
> Note that I do not have an AM43xx board in the testbed, and thus
> cannot test on that platform.

Thanks pulling into omap-for-v4.1/fixes.

Tony
 
> ----------------------------------------------------------------
> Benoit Parrot (1):
>       ARM: AM43xx: hwmod: add VPFE hwmod entries
> 
> Tero Kristo (2):
>       ARM: OMAP4+: PRM: add support for passing status register/bit info to reset
>       ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality
> 
>  arch/arm/mach-omap2/omap_hwmod.c           | 68 ++++++-----------------------
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 70 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |  3 +-
>  arch/arm/mach-omap2/prminst44xx.c          | 20 +++------
>  4 files changed, 93 insertions(+), 68 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
