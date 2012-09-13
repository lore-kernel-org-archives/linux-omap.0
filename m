From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some Makefile cleanup for 3.7
Date: Wed, 12 Sep 2012 22:04:04 -0700
Message-ID: <20120913050403.GA4521@atomide.com>
References: <alpine.DEB.2.00.1209120911110.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11260 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752745Ab2IMFEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 01:04:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209120911110.17903@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120912 02:13]:
> Hi Tony,
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.7
> 
> for you to fetch changes up to df47adb825c221ff45126fd54e531f01ea490334:
> 
>   ARM: OMAP2+: clean up PRCM sections of the Makefile (2012-09-11 19:09:15 -0600)
> 
> - Paul
> 
> ----------------------------------------------------------------
> Clean up and standardize several parts of
> arch/arm/mach-omap2/Makefile.  Beyond readability and diffstat
> improvements, the series should reduce the risk of conflicts during
> future cleanups by ensuring related lines are in the same section of the
> Makefile.

Thanks pulling into cleanup-makefile-sparse.

Regards,

Tony
