From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2: add AM43xx hwmod and PRCM support
Date: Thu, 17 Oct 2013 11:01:30 -0700
Message-ID: <20131017180129.GD15154@atomide.com>
References: <alpine.DEB.2.02.1310162145180.6538@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53101 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365Ab3JQSBd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Oct 2013 14:01:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1310162145180.6538@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131016 14:46]:
> Hi Tony,
> 
> The following changes since commit ace1e3ec4a2540c783e65884bb7be9cd45a0a295:
> 
>   ARM: AM33xx: hwmod: Add RNG module data (2013-10-09 09:02:51 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/am43xx-support
> 
> for you to fetch changes up to 70b0d5f5838e0c9dfecabefe4ff43b5a2e7c1e8b:
> 
>   ARM: OMAP2: hwmod: Add qspi data for am437x. (2013-10-15 23:49:43 -0600)
> 
> ----------------------------------------------------------------
> Add hwmod and PRCM data for the TI AM43xx family of SoCs.
> 
> Under normal circumstances, these patches would not be merged.
> The hwmod and PRCM data should be moved out either to DT data or
> to drivers/.  Also, the current implementation trades off lines
> of diff by dynamically rewriting static data at runtime, which is
> a bad practice - it causes future maintenance headaches.
> However, after speaking with my upstream, it sounds like it's
> better to merge these patches in their current state, due to long
> term considerations.
> 
> Basic test logs are here:
> 
> http://www.pwsan.com/omap/testlogs/am43xx_support_v3.13/20131015213706/
> 
> Due to the lack of an AM43xx board and any available public
> documentation, it's impossible for me to review or test that
> platform in any meaningful way.  But at least the tests above
> verify that the patches don't affect existing platforms -
> particularly AM33xx.

Thanks, I've pulled this into omap-for-v3.13/hwmod.

Regards,

Tony
