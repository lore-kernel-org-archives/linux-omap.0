From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock fixes for v3.13
Date: Thu, 14 Nov 2013 10:39:56 -0800
Message-ID: <20131114183956.GO10317@atomide.com>
References: <alpine.DEB.2.02.1310241550050.10391@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24849 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3KNSj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 13:39:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1310241550050.10391@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [131024 09:01]:
> Hi Tony,
> 
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
> 
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/clock-fixes-a
> 
> for you to fetch changes up to 4ff7e3b65c8e1d8062365296b738fd262cfc2e9c:
> 
>   ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers (2013-10-24 09:07:23 -0600)
> 
> ----------------------------------------------------------------
> Several OMAP2+ DSS-related clock fixes for v3.13 from Tomi Valkeinen.
> 
> Basic test logs at:
> 
>    http://www.pwsan.com/omap/testlogs/clock_fixes_v3.13/20131024090906/

Thanks pulling into omap-for-v3.13/fixes.

Tony
 
> ----------------------------------------------------------------
> Tomi Valkeinen (3):
>       ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
>       ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
>       ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
> 
>  arch/arm/mach-omap2/cclock3xxx_data.c | 58 +++++++++++++++++++++++++++++------
>  arch/arm/mach-omap2/cclock44xx_data.c |  3 +-
>  2 files changed, 51 insertions(+), 10 deletions(-)
