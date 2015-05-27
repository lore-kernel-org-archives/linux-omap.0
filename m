From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
Date: Wed, 27 May 2015 16:15:36 -0700
Message-ID: <20150527231536.GD30984@atomide.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <20150526160557.GD16525@atomide.com>
 <20150526163216.GF16525@atomide.com>
 <20150526163931.GO26599@saruman.tx.rr.com>
 <55660D5B.8020607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54225 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbbE0XPj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2015 19:15:39 -0400
Content-Disposition: inline
In-Reply-To: <55660D5B.8020607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: balbi@ti.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150527 11:32]:
> On 05/26/2015 07:39 PM, Felipe Balbi wrote:
> >On Tue, May 26, 2015 at 09:32:16AM -0700, Tony Lindgren wrote:
> >>* Tony Lindgren <tony@atomide.com> [150526 09:08]:
> >>>* Tero Kristo <t-kristo@ti.com> [150525 08:01]:
> >>>>Hi,
> >>>>
> >>>>As requested, posting v3 with somewhat changed diff parameters and
> >>>>diffstat attached. Just some minor Makefile changes compared to v2,
> >>>>these were discussed under that set.
> >>>>
> >>>>Set has been pushed to:
> >>>>- tree: https://github.com/t-kristo/linux-pm.git
> >>>>- branch: for-4.2/ti-clk-move
> >>>
> >>>Looks like this causes a build error for at least omap2 only .config:
> >>>
> >>>drivers/clk/ti/dpll3xxx.o:(.rodata+0x1c): multiple definition of `clkhwops_omap3_dpll'
> >>>drivers/clk/ti/dpll.o:(.rodata+0x0): first defined here
> >>>
> >>>You may want to create a file selecting ARCH_OMAP2PLUS=y, then point
> >>>KCONFIG_ALLCONFIG to that file for make randconfig. Then just build
> >>>randconfigs :) Usually the issues like this are exposed within few
> >>>randconfig builds, some take longer if the options have dependencies.
> >
> >alternatively, just clone the repository at [1] and use the example
> >script provided in README.md.
> >
> >[1] https://github.com/felipebalbi/omap-seeds
> >
> 
> Ok, I pushed an updated branch named: for-4.2/ti-clk-move-v4
> 
> This definitely compiles with OMAP2 / OMAP3 / OMAP4 / OMAP5 / DRA7 / AM33xx
> / AM43xx only setups (tried it out.)

Thanks yeah seems to work for me now.

Regards,

Tony
