From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: OMAP2+: sparse & PRCM fixes for v3.8-rc1
Date: Thu, 3 Jan 2013 11:33:49 -0800
Message-ID: <20130103193349.GG25633@atomide.com>
References: <alpine.DEB.2.00.1301021931430.17366@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42194 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753017Ab3ACTdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 14:33:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301021931430.17366@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130102 11:41]:
> Hi Tony,
> 
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a2-for-v3.8-rc
> 
> for you to fetch changes up to 7e7fff8254e318cede06a1a8c55b0d86dd4d8c5b:
> 
>   ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values (2013-01-02 12:07:16 -0700)
> 
> ----------------------------------------------------------------
> Some OMAP PRCM and sparse fixes against v3.8-rc1.  A basic set of test
> logs are available here:
> 
>     http://www.pwsan.com/omap/testlogs/prcm_fixes_b_3.8-rc/20130102120724/
> 
> The 3730 Beagle XM here has an intermittent failure mounting SD root,
> but the suspicion right now is that this is due to a failing SD card,
> rather than any change introduced by these patches.
> 
> This second version includes a few changes requested by Tony Lindgren.

Thanks pulling into omap-for-v3.8-rc2/fixes.

Tony
