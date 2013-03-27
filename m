From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clkdev flags removal for 3.10 cleanup
Date: Wed, 27 Mar 2013 10:51:48 -0700
Message-ID: <20130327175148.GA10155@atomide.com>
References: <alpine.DEB.2.00.1303191645030.20326@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34847 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752307Ab3C0Rvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 13:51:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1303191645030.20326@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130319 09:50]:
> Hi Tony
> 
> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> 
>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.10
> 
> for you to fetch changes up to 78e52e026d288aad88b46bff0d94b05e145c4583:
> 
>   ARM: OMAP2+: clock data: Remove CK_* flags (2013-03-18 09:57:39 -0600)
> 
> ----------------------------------------------------------------
> In the OMAP2+ clock data, replace the flags that determine whether a
> clock should be registered on a given SoC with per-SoC lists.
> 
> Basic build, boot, and power management test results are available at:
> 
> http://www.pwsan.com/omap/testlogs/jk_clock_flags_cleanup_3.10/20130318100504/

Thanks I've pulled this into omap-for-v3.10/cleanup.

Regards,

Tony
