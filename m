From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.1-rc4
Date: Wed, 20 May 2015 14:03:09 -0700
Message-ID: <20150520210309.GA18439@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52629 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055AbbETVDM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 17:03:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit e60a8fe1792dcd3aacda0959e0f4865bfefb7bb5:

  Merge tag 'for-v4.1-rc/omap-fixes-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.1/fixes (2015-05-11 13:23:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc4

for you to fetch changes up to f25bf74c8862efdc30453d16d60cf22958a4873e:

  ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK (2015-05-20 10:00:10 -0700)

----------------------------------------------------------------
Few minimal omap device tree fixes for v4.1-rc series:

- Disable BeagleBone black RTC-only sleep mode because of hardare
  related issues

- Fix NAND on Devkit8000

- Fix WLAN interrupt line on AM335x EVM-SK

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: dts: omap3-devkit8000: Fix NAND DT node

Robert Nelson (1):
      ARM: dts: am335x-boneblack: disable RTC-only sleep

Romain Izard (1):
      ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK

 arch/arm/boot/dts/am335x-boneblack.dts | 4 ----
 arch/arm/boot/dts/am335x-evmsk.dts     | 2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts | 2 ++
 3 files changed, 3 insertions(+), 5 deletions(-)
