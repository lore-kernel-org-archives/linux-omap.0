From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/33] ARM: OMAP: clock conversion to DT
Date: Tue, 23 Jul 2013 11:24:31 +0300
Message-ID: <51EE3DBF.9060101@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32864 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab3GWIY6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 04:24:58 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hrmph,

Seems like the old devicetree list was terminated yesterday, so if you 
reply to this you will get some bounces. Sorry about that.

-Tero

On 07/23/2013 10:19 AM, Tero Kristo wrote:
> Hi,
>
> Changes compared to previous version:
>
> - Clock init files moved from mach-omap2/ to drivers/clk/omap/
> - AM33xx support added [patches 15-20]
> - OMAP3 support added [patches 21-29]
> - DRA7 APLL support added (thanks Keerthy) [patches 30-33]
>
> Test branch on top of 3.11-rc1 available here:
>
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.11-rc1-omap-dt-clks
>
> Testing done:
>
> - boot + suspend tested on OMAP3 beagle C4 (omap3530)
> - boot + suspend tested on OMAP4 panda ES (omap4460)
> - boot tested on beagle bone (am335x)
>
> A boot test was also executed for DRA7 and OMAP5 on a separate branch
> (mainline does not have OMAP5 / DRA7 support so far.)
>
> TODO:
> - Add AM35xx support (OMAP3 derivative, AM35xx only clock nodes missing)
>
> Overall diffstat added just for fun:
>
>   arch/arm/boot/dts/am33xx-clocks.dtsi               |  663 ++++
>   arch/arm/boot/dts/am33xx.dtsi                      |    7 +
>   arch/arm/boot/dts/dra7xx-clocks.dtsi               | 2113 ++++++++++++
>   arch/arm/boot/dts/omap3.dtsi                       |    7 +
>   arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  166 +
>   arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi    |  240 ++
>   arch/arm/boot/dts/omap34xx.dtsi                    |    9 +
>   .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  214 ++
>   arch/arm/boot/dts/omap36xx-clocks.dtsi             |   97 +
>   .../boot/dts/omap36xx-omap3430es2plus-clocks.dtsi  |  185 +
>   arch/arm/boot/dts/omap36xx.dtsi                    |   10 +
>   arch/arm/boot/dts/omap3xxx-clocks.dtsi             | 1594 +++++++++
>   arch/arm/boot/dts/omap443x-clocks.dtsi             |   17 +
>   arch/arm/boot/dts/omap443x.dtsi                    |    8 +
>   arch/arm/boot/dts/omap4460.dtsi                    |    8 +
>   arch/arm/boot/dts/omap446x-clocks.dtsi             |   27 +
>   arch/arm/boot/dts/omap44xx-clocks.dtsi             | 1654 +++++++++
>   arch/arm/boot/dts/omap54xx-clocks.dtsi             | 1416 ++++++++
>   arch/arm/mach-omap2/Makefile                       |    5 +-
>   arch/arm/mach-omap2/cclock33xx_data.c              | 1059 ------
>   arch/arm/mach-omap2/cclock3xxx_data.c              | 3641 --------------------
>   arch/arm/mach-omap2/cclock44xx_data.c              | 1730 ----------
>   arch/arm/mach-omap2/clock.c                        |    6 +
>   arch/arm/mach-omap2/clock.h                        |  163 +-
>   arch/arm/mach-omap2/clock3xxx.h                    |    7 +-
>   arch/arm/mach-omap2/io.c                           |    7 +-
>   arch/arm/mach-omap2/omap_hwmod.c                   |    5 +-
>   drivers/clk/Makefile                               |    1 +
>   drivers/clk/clk-divider.c                          |    6 +-
>   drivers/clk/clk-fixed-factor.c                     |    6 +-
>   drivers/clk/clk-gate.c                             |    8 +-
>   drivers/clk/clk-mux.c                              |    6 +-
>   drivers/clk/clkdev.c                               |   32 +
>   drivers/clk/omap/Makefile                          |    4 +
>   drivers/clk/omap/apll.c                            |  213 ++
>   drivers/clk/omap/autoidle.c                        |  130 +
>   drivers/clk/omap/clk-33xx.c                        |   85 +
>   drivers/clk/omap/clk-3xxx.c                        |  171 +
>   drivers/clk/omap/clk-44xx.c                        |  118 +
>   drivers/clk/omap/clk-54xx.c                        |   58 +
>   drivers/clk/omap/clk-7xx.c                         |   67 +
>   drivers/clk/omap/clk.c                             |   84 +
>   drivers/clk/omap/dpll.c                            |  387 +++
>   drivers/clk/omap/gate.c                            |  166 +
>   drivers/clk/omap/interface.c                       |  110 +
>   include/linux/clk/omap.h                           |  223 ++
>   46 files changed, 10327 insertions(+), 6606 deletions(-)
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

