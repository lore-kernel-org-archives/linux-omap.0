From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] clk: ti: changes for 5.6
Date: Tue, 21 Jan 2020 09:31:27 +0200
Message-ID: <71d3d7dd-115a-4584-e3d7-e13e7ea7934e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60984 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUHbg (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2020 02:31:36 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, "tony@atomide.com" <tony@atomide.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Stephen,

Please pull these TI clock changes towards v5.6. Tony, the same branch 
(for-5.6-ti-clk) can be considered immutable towards your DTS changes if 
you wish to sync them with this.

-Tero

---

The following changes since commit
e42617b825f8073569da76dc4510bfa019b1c35a:

   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux 
tags/ti-clk-for-5.6

for you to fetch changes up to 6c3090520554d535db04f807c313d9a4b81a285c:

   clk: ti: clkctrl: Fix hidden dependency to node name (2020-01-20 
12:29:27 +0200)

----------------------------------------------------------------
TI clock driver changes for v5.6

This pull contains following changes:

- cam, vpe and sgx clock support for dra7
- fix gmac main clock for dra7
- aess clock support for omap5
- move dra7-atl clock header to correct location
- fix hidden node name dependency on clkctrl clocks

----------------------------------------------------------------
Benoit Parrot (2):
       clk: ti: dra7: add cam clkctrl data
       clk: ti: dra7: add vpe clkctrl data

Grygorii Strashko (1):
       clk: ti: dra7: fix parent for gmac_clkctrl

Peter Ujfalusi (1):
       dt-bindings: clock: Move ti-dra7-atl.h to dt-bindings/clock

Tony Lindgren (3):
       clk: ti: omap5: Add missing AESS clock
       clk: ti: add clkctrl data dra7 sgx
       clk: ti: clkctrl: Fix hidden dependency to node name

  .../devicetree/bindings/clock/ti-clkctrl.txt       | 11 ++-
  .../devicetree/bindings/clock/ti/dra7-atl.txt      |  4 +-
  arch/arm/boot/dts/dra7-evm-common.dtsi             |  2 +-
  arch/arm/boot/dts/dra72-evm-common.dtsi            |  2 +-
  arch/arm/boot/dts/dra7xx-clocks.dtsi               | 14 ++++
  drivers/clk/ti/clk-54xx.c                          | 15 ++++
  drivers/clk/ti/clk-7xx.c                           | 62 +++++++++++++-
  drivers/clk/ti/clk.c                               |  4 +-
  drivers/clk/ti/clkctrl.c                           | 96 
+++++++++++++++++++---
  include/dt-bindings/clock/dra7.h                   | 23 ++++++
  include/dt-bindings/clock/omap5.h                  |  1 +
  include/dt-bindings/{clk => clock}/ti-dra7-atl.h   |  0
  12 files changed, 214 insertions(+), 20 deletions(-)
  rename include/dt-bindings/{clk => clock}/ti-dra7-atl.h (100%)
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
