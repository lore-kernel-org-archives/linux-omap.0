From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [RFC PATCH 0/4] Fix dmtimer parent clock setup
Date: Mon, 16 Jul 2018 19:21:41 -0400
Message-ID: <20180716192141.28269517.drivshin@awxrd.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: tony@atomide.com, daniel.lezcano@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com
List-Id: linux-omap@vger.kernel.org

On Mon, 16 Jul 2018 22:38:58 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> With the move to clocksource, the omap_dm_timer_of_set_source() broke
> because the "fclk" clock is now defined in the DT.
> The omap_dm_timer_of_set_source() was using the first clock declared in the
> timer node, but now this clock must be named as "src" and clk_get() use
> "src" as clock name to permit specifiying the parent clock of the timer "fclk".
> 
> The 3 first patches adds the "fck" clocks to all timer nodes of SoCs using
> the Clock Framework to pass this clock to the dmtimer driver.
> 
> Adam, David, can you check if this solves the issue reported at [1] ?

Thanks! Works on my AM335x board.
Patches 1 and 4:
 Tested-by: David Rivshin <drivshin@allworx.com>

If I might suggest also:
 Fixes: df54bfc5502a ("clk: ti: am33xx: add clkctrl clock data")
 Cc: <stable@vger.kernel.org> # 4.16+


> 
> [1] https://www.spinics.net/lists/linux-clk/msg27638.html
> 
> Neil Armstrong (4):
>   ARM: dts: am33xx: Add all fck timer clocks
>   ARM: dts: am4372: Add all fck timer clocks
>   ARM: dts: dm816x: Add all fck timer clocks
>   timer-ti-dm: Fix omap_dm_timer_of_set_source()
> 
>  arch/arm/boot/dts/am33xx.dtsi     | 10 ++++++++++
>  arch/arm/boot/dts/am4372.dtsi     | 18 ++++++++++++++++++
>  arch/arm/boot/dts/dm816x.dtsi     | 10 ++++++++++
>  drivers/clocksource/timer-ti-dm.c |  2 +-
>  4 files changed, 39 insertions(+), 1 deletion(-)
> 
