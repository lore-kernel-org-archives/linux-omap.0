From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/27] clk: ti: clkctrl fixes and support for additional SoCs
Date: Mon, 30 Oct 2017 15:04:18 +0200
Message-ID: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi,

This series contains a few cleanups/fixes and clkctrl support for
am33xx, am43xx, dra7, dm81x and omap5 SoCs. This series can be
applied independently of any other upcoming clkctrl related
changes (mach-omap2 and dts.)

The way forward with hwmod cleanup will look something like following:
- this series + related mach-omap2 changes merged
- dts changes merged
- introduction of the interconnect driver
- removal of clkctrl related data from hwmod data
- removal of the temporary clkctrl clock aliases from TI clock driver
  (these are only needed as long as hwmod is still in charge of business)

Boot testing done on all boards I have access to, and Tony has done
some extra testing on dm81x boards which I don't have. Applied on top
of 4.14-rc1, but I would say this is 4.16 material. The posting of
this series has been delayed due to some nasty email issues I've been
having, sorry about that.

Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.14-rc1-clkctrl-driver

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
