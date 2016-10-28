From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Thu, 27 Oct 2016 17:53:41 -0700
Message-ID: <20161028005341.GR26139@codeaurora.org>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/18, Tero Kristo wrote:
> Hi,
> 
> As a recap, this series is part of the ongoing work to get rid of the
> hwmod database under mach-omap2 folder. This series converts the
> existing clock related functionality to a new clock type, which will
> allow removing all the .clkctrl related items from hwmod database.
> This series adds sample solution for OMAP4 only, rest of the SoCs can
> be converted automatically once the approach is acceptable.
> 
> v4 has the following high level changes compared to v3:
> - Clock data is now statically built-in to the driver
> - Adds clockdomain provider support, which can be used to fetch
>   clocks based on clockdomain relation. Only clockdomains need to be
>   registered within DT.
> - Added some automatic clock alias generation support to the TI clock
>   drivers, if this is not acceptable, I can change this to add all the
>   aliases under the individual drivers/clk/ti/clk-xyz.c files

Is there a plan to get rid of the aliases entirely? Or we can't
do that because DT is not fully supported on these platforms? I'm
mostly wondering how long that sort of code is going to stick
around and if it's better to fully compartmentalize it to the
SoCs that are affected or if it should be a core feature of TI
driver.

> - As a sample, only omap4 clock data is available with this set
> 
> After this series, the clock data can be dropped from the hwmod database
> for OMAP4, I have working patches for this for anybody interested. Also,
> the DT files require some modifications to add proper support for
> clockdomain providers, and drop some unnecessary clock nodes.

Can this be shared as a git tree on the web? Hopefully I can see
the resulting DTS and understand what's going on better.

> 
> Boot + simple PM test seems to be working on OMAP4 with this set, and
> boot test with other boards I have access to don't seem to cause any
> issues. Applies on top of 4.9-rc1.
> 

Awesome!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
