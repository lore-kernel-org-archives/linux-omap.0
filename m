From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.13 merge window
Date: Fri, 15 Nov 2013 11:36:40 -0800
Message-ID: <23060.6344216087$1384544215@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30939 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751220Ab3KOTgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 14:36:46 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 10d0c9705e80bbd3d587c5fad24599aabaca6688:

  Merge tag 'devicetree-for-3.13' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2013-11-12 16:52:17 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-for-merge-window-take2

for you to fetch changes up to 26273e02a0cf18eb72416559310d3294390a9024:

  ARM: OMAP2+: Fix build for dra7xx without omap4 and 5 (2013-11-15 08:27:29 -0800)

----------------------------------------------------------------
Few clock fixes, a runtime PM fix, and pinctrl-single fix along
with few other fixes that popped up during the merge window.

----------------------------------------------------------------
Eric Witcher (1):
      ARM: OMAP: devicetree: fix SPI node compatible property syntax items

Joel Fernandes (1):
      doc: devicetree: Add bindings documentation for omap-des driver

Lokesh Vutla (1):
      ARM: dts: doc: Document missing compatible property for omap-sham driver

Nishanth Menon (1):
      ARM: OMAP2+: omap_device: maintain sane runtime pm status around suspend/resume

Roger Quadros (1):
      pinctrl: single: call pcs_soc->rearm() whenever IRQ mask is changed

Tomi Valkeinen (3):
      ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
      ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
      ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers

Tony Lindgren (2):
      Merge tag 'for-v3.13/clock-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into xxx-dt
      ARM: OMAP2+: Fix build for dra7xx without omap4 and 5

Wei Yongjun (2):
      ARM: OMAP2+: smsc911x: fix return value check in gpmc_smsc911x_init()
      ARM: OMAP3: Beagle: fix return value check in beagle_opp_init()

 .../devicetree/bindings/crypto/omap-des.txt        | 30 +++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       |  2 +-
 Documentation/devicetree/bindings/spi/omap-spi.txt |  4 +-
 arch/arm/mach-omap2/Makefile                       |  2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |  2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c              | 58 ++++++++++++++++++----
 arch/arm/mach-omap2/cclock44xx_data.c              |  3 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c                |  2 +-
 arch/arm/mach-omap2/omap_device.c                  | 13 ++++-
 arch/arm/mach-omap2/prm44xx_54xx.h                 |  3 +-
 drivers/pinctrl/pinctrl-single.c                   | 10 ++--
 11 files changed, 103 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-des.txt
