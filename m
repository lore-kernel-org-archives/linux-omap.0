From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 0/9] ARM: OMAP4: hwmod clkctrl conversion to DT + clock driver
Date: Fri, 18 Dec 2015 15:58:52 +0200
Message-ID: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds support for hwmod gate clock type, and changes OMAP4
as an example to use the new clock type, converting the existing
hwmod_data clkctrl definitions to clock nodes under device tree.
Some additional magic is required for handling timer clocks, as the
clock driver assumes it can do mux operations on the hwmod main clock,
the mux-mod clock type variants are for this purpose.

The data files have been automatically converted by scripting, so doing
the same conversion for any AMxyz / OMAP4+ SoC should be relatively
easy to do.

Boot tested on OMAP4 panda ES board, also tried that suspend-resume /
cpuidle works fine. Testing done on top of 4.4-rc3.

This series is one part of the work to get rid of hwmod data from kernel.

-Tero

