From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
Date: Tue, 26 May 2015 09:05:58 -0700
Message-ID: <20150526160557.GD16525@atomide.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53976 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856AbbEZQGA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2015 12:06:00 -0400
Content-Disposition: inline
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150525 08:01]:
> Hi,
> 
> As requested, posting v3 with somewhat changed diff parameters and
> diffstat attached. Just some minor Makefile changes compared to v2,
> these were discussed under that set.
> 
> Set has been pushed to:
> - tree: https://github.com/t-kristo/linux-pm.git
> - branch: for-4.2/ti-clk-move

Looks like this causes a build error for at least omap2 only .config:

drivers/clk/ti/dpll3xxx.o:(.rodata+0x1c): multiple definition of `clkhwops_omap3_dpll'
drivers/clk/ti/dpll.o:(.rodata+0x0): first defined here

You may want to create a file selecting ARCH_OMAP2PLUS=y, then point
KCONFIG_ALLCONFIG to that file for make randconfig. Then just build
randconfigs :) Usually the issues like this are exposed within few
randconfig builds, some take longer if the options have dependencies.

Regards,

Tony
