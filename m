From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6 00/34] ARM: OMAP2+: PRCM+SCM cleanup against 4.0-rc1
Date: Wed, 1 Apr 2015 12:29:03 -0700
Message-ID: <20150401192902.GS10805@atomide.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41312 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbbDATdF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2015 15:33:05 -0400
Content-Disposition: inline
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150331 12:15]:
> Hi,
> 
> Decided to post a new version because of the number of minor changes
> compared to v5, just to avoid any misunderstandings:
> 
> - dropped patch #1 ("clk: ti: fix ti_clk_get_reg_addr..."), this has been merged
>   through clock tree now
> - fixed scm_conf area size issues on am33xx/am43xx
> - fixed scm area size issue on am43xx
> - fixed size issues on omap3_pmx_core (was 8 bytes short)
> - added warnings on omap2_clk_readl/writel in case legacy access is attempted
> - fixed omap3 legacy boot
> - fixed boot time warning on omap4+ where scm_conf does not contain clocks node
>   yet (these may be added to DT later if support is required)
> - fixed some randconfig warnings
> 
> Testing done:
>  1: am335x-evm      : boot
>  2: am335x-evmsk    : boot
>  3: am3517-evm      : boot
>  4: am43x-epos-evm  : boot
>  5: am437x-gp-evm   : boot
>  6: omap3-beagle-xm : boot
>  7: omap3-beagle    : boot, cpuidle (ret/off), suspend (ret/off), legacy boot
>  8: am335x-boneblack: boot
>  9: am335x-bone     : boot
> 10: dra7xx-evm      : boot
> 11: omap3-n900      : boot
> 12: omap5-uevm      : boot
> 13: omap4-panda-es  : boot, cpuidle (ret), suspend (ret)
> 14: omap4-panda     : boot
> 15: omap2430-sdp    : boot
> 16: omap3430-sdp    : boot
> 17: omap4-sdp-es23plus: boot
> 
> New branch also pushed:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 4.0-rc1-prcm-cleanup-v6

OK great, this version seems to work for me. I'll merge this into
omap-for-v4.1/prcm-cleanup and will send a pull request probably
on Thursday or Friday to arm-soc. Note that it's getting late for
v4.1 (except for fixes), so no guarantees this will still get in.

Regards,

Tony
