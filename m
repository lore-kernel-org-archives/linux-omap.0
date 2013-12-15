From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
Date: Sat, 14 Dec 2013 16:51:07 -0800
Message-ID: <20131215005107.26321.50455@quantum>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:57804 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3LOAvK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Dec 2013 19:51:10 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so2683202yho.24
        for <linux-omap@vger.kernel.org>; Sat, 14 Dec 2013 16:51:10 -0800 (PST)
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Quoting Tero Kristo (2013-11-26 00:05:41)
> Hi,
> 
> Changes compared to v9:
> - rebased on top of 3.13-rc1
> - modified the low level clk register API to provide SoC specific clk_readl
>   and clk_writel support which can be registered during boot, TI SoC variant
>   uses regmap on low level
> - dropped regmap parameter from clock init calls, instead a helper is used
>   for getting regmap index along with the register offset from DT
> - dropped regmap parameter from clock structs, instead platform specific
>   clk_readl / clk_writel are used to parse reg parameter according to
>   platform, for TI SoC:s, this is encoded as:
>   struct clk_omap_reg {
>     u16 offset; /* register offset */
>     u16 index; /* regmap index */
>   }
> - Nishanth's comments to v9 mostly addressed, except for the CLK_OF_DECLARE
>   tweak which I would actually want some feedback upon, basically the problem
>   is I need to return status from the clk init functions so I can see if
>   -EAGAIN is passed, in which case init will be retried later, maybe some of
>   this can be made generic, like converting all the CLK_OF_DECLARE type
>   functions to return status
> 
> Testing done:
> - omap3-beagle : boot + suspend/resume
> - omap3-beagle-xm : boot (thanks to Nishanth)
> - omap4-panda-es : boot + suspend/resume

A quick note in testing: trace_clk_div_ck ends up as an orphan clock on
my Panda ES.

Regards,
Mike

> - omap5-uevm : boot
> - dra7-evm : boot
> - am335x-bone : boot
> 
> Separate branches available at https://github.com/t-kristo/linux-pm.git
> 
> - full: 3.13-rc1-dt-clks-v10 (should be merged last, contains everything)
> - clk driver only: 3.13-rc1-dt-clks-v10-for-mike
> - DT data only: 3.13-rc1-dt-clks-v10-for-benoit
> 
> -Tero
> 
