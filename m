From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.0-rc cycle
Date: Thu, 19 Mar 2015 13:49:23 -0700
Message-ID: <20150319204922.GV5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38734 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbbCSUyD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 16:54:03 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 5b7610f235627878617648a99dd1442997f1=
c889:

  ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot (2015-03-0=
6 10:37:34 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
fixes-v4.0-rc4

for you to fetch changes up to 599c376c49323127c9bdbb0fa61a3d4743819bc2=
:

  ARM: dts: Fix gpio interrupts for dm816x (2015-03-18 13:41:34 -0700)

----------------------------------------------------------------
=46ixes for omaps for the -rc cycle:

- Fix a device tree based booting vs legacy booting regression for
  omap3 crypto hardware by adding the missing DMA channels.

- Fix /sys/bus/soc/devices/soc0/family for am33xx devices.

- Fix two timer issues that can cause hangs if the timer related
  hwmod data is missing like it often initially is for new SoCs.

- Remove pcie hwmods entry from dts as that causes runtime PM to
  fail for the PHYs.

- A paper bag type dts configuration fix for dm816x GPIO
  interrupts that I just noticed. This is most of the changes
  diffstat wise, but as it's a basic feature for connecting
  devices and things work otherwise, it should be fixed.

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: dts: dra7: remove ti,hwmod property from pcie phy

Pali Roh=C3=A1r (1):
      ARM: dts: omap3: Add missing dmas for crypto

Suman Anna (3):
      ARM: OMAP2+: Fix socbus family info for AM33xx devices
      ARM: OMAP: dmtimer: check for pm_runtime_get_sync() failure
      ARM: OMAP: dmtimer: disable pm runtime on remove

Tony Lindgren (1):
      ARM: dts: Fix gpio interrupts for dm816x

 arch/arm/boot/dts/dm8168-evm.dts | 19 +++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi    | 18 ++++++++++++++----
 arch/arm/boot/dts/dra7.dtsi      |  2 --
 arch/arm/boot/dts/omap3.dtsi     |  4 ++++
 arch/arm/mach-omap2/id.c         |  2 ++
 arch/arm/plat-omap/dmtimer.c     | 15 ++++++++++++++-
 6 files changed, 53 insertions(+), 7 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
