From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Tue, 18 Oct 2016 18:45:53 +0300
Message-ID: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

As a recap, this series is part of the ongoing work to get rid of the
hwmod database under mach-omap2 folder. This series converts the
existing clock related functionality to a new clock type, which will
allow removing all the .clkctrl related items from hwmod database.
This series adds sample solution for OMAP4 only, rest of the SoCs can
be converted automatically once the approach is acceptable.

v4 has the following high level changes compared to v3:
- Clock data is now statically built-in to the driver
- Adds clockdomain provider support, which can be used to fetch
  clocks based on clockdomain relation. Only clockdomains need to be
  registered within DT.
- Added some automatic clock alias generation support to the TI clock
  drivers, if this is not acceptable, I can change this to add all the
  aliases under the individual drivers/clk/ti/clk-xyz.c files
- As a sample, only omap4 clock data is available with this set

After this series, the clock data can be dropped from the hwmod database
for OMAP4, I have working patches for this for anybody interested. Also,
the DT files require some modifications to add proper support for
clockdomain providers, and drop some unnecessary clock nodes.

Boot + simple PM test seems to be working on OMAP4 with this set, and
boot test with other boards I have access to don't seem to cause any
issues. Applies on top of 4.9-rc1.

-Tero

