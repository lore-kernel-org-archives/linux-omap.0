From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some clock/hwmod patches for v3.19
Date: Fri, 14 Nov 2014 10:47:20 -0800
Message-ID: <20141114184719.GA7046@atomide.com>
References: <alpine.DEB.2.02.1411132249550.17030@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21613 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161282AbaKNSrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2014 13:47:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1411132249550.17030@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [141113 14:52]:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19/omap-a
> 
> for you to fetch changes up to 79005fbd3e1d671d08c45c9140ee9826efdc367c:
> 
>   ARM: OMAP2+: hwmod: drop unnecessary list initialization (2014-11-13 09:36:55 -0700)
> 
> ----------------------------------------------------------------
> Some OMAP clock/hwmod patches for v3.19.
> 
> Most of the patches are clock-related.  The DPLL implementation is
> changed to better align to the common clock framework.
> There is also a patch that removes a few lines from the hwmod code -
> this patch should have no functional effect.
> 
> Basic build, boot, and PM test logs for these patches can be found here:
> 
> http://www.pwsan.com/omap/testlogs/omap-a-for-v3.19/20141113094101/

Pulling into omap-for-v3.19/soc thanks. FYI, looks like there are
few more open hwmod related threads you may want to look at:

[PATCH v2 0/3] Add support for ADC on am437x-gp and am43x-epos-evm
[RFC PATCH 0/6] ARM: OMAP4+: hwmod: fixing omap4+ DSS hwmods
[PATCH] ARM: DRA7: hwmod data: Add missing UART hwmod data

Regards,

Tony
