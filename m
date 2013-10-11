From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod changes for v3.13
Date: Fri, 11 Oct 2013 15:26:34 -0700
Message-ID: <20131011222634.GB29913@atomide.com>
References: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47621 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3JKW0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 18:26:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131011 10:08]:
> Hi Tony,
> 
> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
> 
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/hwmod
> 
> for you to fetch changes up to ace1e3ec4a2540c783e65884bb7be9cd45a0a295:
> 
>   ARM: AM33xx: hwmod: Add RNG module data (2013-10-09 09:02:51 -0600)
> 
> ----------------------------------------------------------------
> Some OMAP hwmod changes for 3.13.  Significant changes here include:
> 
> - support for moving some of the hwmod flags to DT data
> 
> - support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
>   blocks for various OMAPs
> 
> - a fix that again decouples hwmod data changes from unrelated DT data
>   patchsets
> 
> Basic test logs are available at:
> 
> http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
> 
> The summary reports that the 4460varsomom boots are failing, but this looks
> incorrect - it's probably a bug in the validation scripts here.

OK I'll do a test on my panda es before sending out the branches
and will apply that one hwmod patch Benoit had queued on top
of this. So pulling into omap-for-v3.13/hwmod.

Regards,

Tony
