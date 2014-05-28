From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dt fixes and and clocks for v3.16 merge window
Date: Wed, 28 May 2014 10:58:39 -0700
Message-ID: <20140528175838.GA4707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14208 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaE1R6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 13:58:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit d712ff63b18309c939396f593510fbcccbafb9e4:

  ARM: dts: Enable mcpdm and mcbsp1 on DuoVero (2014-05-19 17:20:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/dt-part3

for you to fetch changes up to 43369f0fe81044427f6b1eedeb16bf8c74c86d48:

  Merge branch 'for-v3.16/clk-dt' of https://github.com/t-kristo/linux-pm into omap-for-v3.16/dt-v2 (2014-05-28 10:14:48 -0700)

----------------------------------------------------------------

Most likely the last pull request from me for omap changes for
v3.16 that's dts fixes for clocks and enabling few features
that were still being discussed earlier:

- A bunch of omap clock related dts fixes queued by Tero Kristo.

- Enable parallel nand on am437x that was not merged earlier as
  I requested more information about the muxing for it. And
  we need to also enable ecc hardware support for am43xx.

- Enable the modem support for n900 that was dropped earlier
  because we had to fix the related hwmod entry first with patch
  ARM: OMAP2+: Fix ssi hwmod entry to allow idling.

- And finally, add the omap2 clock dts files. These will allow
  us to enable the dt clocks and drop the legacy clocks for omap2
  with a follow-up patch once the related clock driver binding
  changes are merged.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: dts: AM4372: clk: efuse based crystal frequency detect

Christoph Fritz (2):
      ARM: dts: omap3: set mcbsp2 status
      ARM: dts: omap3 a83x: fix duplicate usb pin config

Dave Gerlach (1):
      ARM: dts: am43xx-clocks: use ti, fixed-factor-clock for dpll_per_clkdcoldo

Gilles Chanteperdrix (1):
      ARM: dts: omap4: add twd clock to DT

Laurent Pinchart (2):
      ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
      ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path

Pekon Gupta (2):
      ARM: OMAP2+: gpmc: enable BCH_HW ecc-scheme for AM43xx platforms
      ARM: dts: am437x-gp-evm: add support for parallel NAND flash

Peter Ujfalusi (2):
      ARM: dts: omap54xx-clocks: remove the autoidle properties for clock nodes
      ARM: dts: omap54xx-clocks: Correct abe_iclk clock node

Poddar, Sourav (2):
      ARM: dts: am33xx-clock: Fix ehrpwm tbclk data
      ARM: dts: am43x-clock: add tbclk data for ehrpwm

Sebastian Reichel (2):
      ARM: dts: omap3-n900: Add SSI support
      ARM: dts: omap3-n900: Add modem support

Tero Kristo (1):
      ARM: dts: omap2 clock data

Tomi Valkeinen (2):
      ARM: dts: omap5-clocks.dtsi: add ti, set-rate-parent to dss_dss_clk
      ARM: dts: am43xx-clocks.dtsi: add ti, set-rate-parent to display clock path

Tony Lindgren (2):
      ARM: OMAP2+: Fix ssi hwmod entry to allow idling
      Merge branch 'for-v3.16/clk-dt' of https://github.com/t-kristo/linux-pm into omap-for-v3.16/dt-v2

 arch/arm/boot/dts/am33xx-clocks.dtsi       |   30 +-
 arch/arm/boot/dts/am437x-gp-evm.dts        |  108 +++
 arch/arm/boot/dts/am43xx-clocks.dtsi       |   75 +-
 arch/arm/boot/dts/omap2420-clocks.dtsi     |  270 ++++++
 arch/arm/boot/dts/omap2420.dtsi            |   26 +
 arch/arm/boot/dts/omap2430-clocks.dtsi     |  344 ++++++++
 arch/arm/boot/dts/omap2430.dtsi            |   26 +
 arch/arm/boot/dts/omap24xx-clocks.dtsi     | 1244 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi    |    7 +-
 arch/arm/boot/dts/omap3-n900.dts           |   65 ++
 arch/arm/boot/dts/omap3.dtsi               |   45 +
 arch/arm/boot/dts/omap34xx.dtsi            |   11 +
 arch/arm/boot/dts/omap36xx-clocks.dtsi     |    2 +-
 arch/arm/boot/dts/omap36xx.dtsi            |   11 +
 arch/arm/boot/dts/omap3xxx-clocks.dtsi     |    7 +-
 arch/arm/boot/dts/omap4.dtsi               |    1 +
 arch/arm/boot/dts/omap54xx-clocks.dtsi     |   58 +-
 arch/arm/mach-omap2/gpmc-nand.c            |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +-
 drivers/clk/ti/clk-43xx.c                  |    6 +
 20 files changed, 2254 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap24xx-clocks.dtsi
