From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
Date: Tue, 19 May 2015 18:20:53 -0700
Message-ID: <20150520012053.GC31054@codeaurora.org>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39881 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbbETBUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 21:20:55 -0400
Content-Disposition: inline
In-Reply-To: <1431334493-24455-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 05/11, Tero Kristo wrote:
> With the legacy clock data now gone, we can start moving OMAP clock
> type implementations under clock driver. Start this with moving the
> generic OMAP DPLL clock type under TI clock driver.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

How much of the code is the same from the original copy? Can you
generate these patches with -M -C so that we can see?

>  arch/arm/mach-omap2/Makefile    |    2 +-
>  arch/arm/mach-omap2/clkt_dpll.c |  370 ---------------------------------------
>  drivers/clk/ti/Makefile         |    3 +-
>  drivers/clk/ti/clkt_dpll.c      |  369 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/ti/clock.h          |    2 +
>  include/linux/clk/ti.h          |    1 -
>  6 files changed, 374 insertions(+), 373 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/clkt_dpll.c
>  create mode 100644 drivers/clk/ti/clkt_dpll.c

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
