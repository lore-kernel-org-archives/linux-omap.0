From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.18-rc4
Date: Tue, 11 Nov 2014 08:53:58 -0800
Message-ID: <20141111165357.GB26481@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18407 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751152AbaKKQym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2014 11:54:42 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 4b91f7f3c8b20e073b7bfc098625b37f99789508:

  ARM: OMAP2+: Warn about deprecated legacy booting mode (2014-10-29 12:19:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-against-v3.18-rc4

for you to fetch changes up to 73b3a6657a88ef5348a0d69c9a8107d6f01ae862:

  pinctrl: dra: dt-bindings: Fix output pull up/down (2014-11-10 14:29:20 -0800)

----------------------------------------------------------------
Few omap fixes for hangs and wrong pinctrl defines, and update
MAINTAINERS file to avoid missing PMIC and SoC related patches:

- Fix random hangs on am437x because of incorrect default
  value for the DDR regulator

- Fix wrong partition name for NAND on am335x-evm

- Fix wrong pinctrl defines for dra7xx

- Update maintainers entries for PMICs and SoCs

----------------------------------------------------------------
Felipe Balbi (1):
      MAINTAINERS: add more files under OMAP SUPPORT

Keerthy (3):
      ARM: dts: AM43x-EPOS-EVM: Fix DCDC3 voltage
      ARM: dts: AM437x-GP-EVM: Fix DCDC3 voltage
      ARM: dts: AM437x-SK-EVM: Fix DCDC3 voltage

Nishanth Menon (1):
      MAINTAINERS: Update entry for omap related .dts files to cover new SoCs

Roger Quadros (2):
      ARM: dts: am335x-evm: Fix 5th NAND partition's name
      pinctrl: dra: dt-bindings: Fix output pull up/down

 MAINTAINERS                          | 20 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts     |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts  |  4 ++--
 arch/arm/boot/dts/am437x-sk-evm.dts  |  4 ++--
 arch/arm/boot/dts/am43x-epos-evm.dts |  4 ++--
 include/dt-bindings/pinctrl/dra.h    |  4 ++--
 6 files changed, 29 insertions(+), 9 deletions(-)
