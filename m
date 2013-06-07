From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/clock: more fixes for v3.10-rc
Date: Fri, 7 Jun 2013 15:06:37 -0700
Message-ID: <20130607220636.GN3331@atomide.com>
References: <alpine.DEB.2.02.1306061746150.5152@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24635 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756072Ab3FGWGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 18:06:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306061746150.5152@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [130606 10:54]:
> Hi Tony
> 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-3.10-rc
> 
> for you to fetch changes up to a93d8a1cea0899982993e9a93404c6f78b123697:
> 
>   ARM: omap3: clock: fix wrong container_of in clock36xx.c (2013-06-06 08:48:07 -0600)
> 
> ----------------------------------------------------------------
> More OMAP hwmod and clock fixes for v3.10-rc.  Fixes the AM33xx UART2.
> Also fixes some CCF-related breakage on OMAP36xx/37xx, affecting DSS
> at the very least.
> 
> Basic test logs for this branch are here:
> 
> http://www.pwsan.com/omap/testlogs/fixes_b_v3.10-rc/20130606093449/

Thanks pulling into omap-for-v3.10/fixes.

Tony
