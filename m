From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.17-rc3
Date: Thu, 4 Sep 2014 16:07:37 -0700
Message-ID: <20140904230737.GA7319@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56297 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaIDXHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2014 19:07:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-against-v3.17-rc3

for you to fetch changes up to c7cc9ba11f8c09a4d12af0fc4aa9f9b026cdd354:

  ARM: dts: dra7-evm: Add vtt regulator support (2014-09-04 12:49:22 -0700)

----------------------------------------------------------------
Few fixes for omaps mostly for various devices to get them working
properly on the new am437x and dra7 hardware for several devices
such as I2C, NAND, DDR3 and USB. There's also a clock fix for omap3.

And also included are two minor cosmetic fixes that are not
stictly fixes for the new hardware support added recently to
downgrade a GPMC warning into a debug statement, and fix the
confusing comments for dra7-evm spi1 mux.

Note that these are all .dts changes except for a GPMC change.

----------------------------------------------------------------
Felipe Balbi (1):
      ARM: dts: am4372: fix USB regs size

Lokesh Vutla (1):
      ARM: dts: dra7-evm: Add vtt regulator support

Nishanth Menon (2):
      ARM: dts: am437x-gp: switch i2c0 to 100KHz
      ARM: dts: dra7-evm: Fix spi1 mux documentation

Roger Quadros (8):
      ARM: dts: dra7-evm: Fix i2c3 pinmux and frequency
      ARM: dts: dra7-evm: Fix 8th NAND partition's name
      ARM: dts: am43x-epos-evm: Use BCH16 ECC scheme instead of BCH8
      ARM: dts: am437x-gp-evm: Use BCH16 ECC scheme instead of BCH8
      ARM: dts: am437x-gp-evm: Don't use read/write wait monitoring
      ARM: dts: am43xx-epos-evm: Don't use read/write wait monitoring
      ARM: OMAP2+: gpmc: Don't complain if wait pin is used without r/w monitoring
      ARM: dts: am43x-epos-evm: Disable QSPI to prevent conflict with GPMC-NAND

Stefan Herbrechtsmeier (1):
      ARM: dts: set 'ti,set-rate-parent' for dpll4_m5x2 clock

Tony Lindgren (1):
      Merge branch 'for-v3.17-rc/ti-clk-dt' of github.com:t-kristo/linux-pm into fixes-rc3

 arch/arm/boot/dts/am4372.dtsi          |  4 +--
 arch/arm/boot/dts/am437x-gp-evm.dts    |  6 ++---
 arch/arm/boot/dts/am43x-epos-evm.dts   |  9 +++----
 arch/arm/boot/dts/dra7-evm.dts         | 47 ++++++++++++++++++++++++++--------
 arch/arm/boot/dts/omap3xxx-clocks.dtsi |  1 +
 arch/arm/mach-omap2/gpmc.c             |  7 +++--
 6 files changed, 48 insertions(+), 26 deletions(-)
