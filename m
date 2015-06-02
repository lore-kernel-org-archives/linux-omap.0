From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap device tree changes for v4.2, part 2
Date: Tue,  2 Jun 2015 10:22:15 -0700
Message-ID: <2234.4340141446$1433265767@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from erouter8.ore.mailhop.org ([54.187.218.212]:27898 "HELO
	outbound3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754035AbbFBRWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 13:22:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 52dfcbfc94833b0192d439127ee9ff46023cdbb2:

  ARM: dts: am335x-evm: add mmc3 and wlan definitions to dts (2015-05-21 12:05:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/dt-pt2

for you to fetch changes up to 8584d4fcab2222e2501e1c95b4d063cd4a76891d:

  ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support. (2015-05-28 09:49:50 -0700)

----------------------------------------------------------------
Few more omap device tree changes for v4.2 merge window:

- Add dm9000 Ethernet support to omap3-devkit8000

- Add Toby-Churchill SL50 board support

- Add vendor prefix for Toby Churchill Ltd

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: dts: omap3-devkit8000: Add dm9000 support

Enric Balletbo i Serra (2):
      of: Add vendor prefix for Toby Churchill Ltd.
      ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sl50.dts                  | 482 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-devkit8000.dts             |  41 ++
 4 files changed, 525 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sl50.dts
