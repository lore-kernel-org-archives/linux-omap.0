From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two omap dt regression fixes for v3.14-rc4
Date: Sun, 2 Mar 2014 15:04:48 -0800
Message-ID: <20140302230448.GB5000@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33324 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752278AbaCBXFC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 18:05:02 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 4b41636878ee32d4c45a49de7749abca9721bd6a:

  ARM: OMAP3: Fix pinctrl interrupts for core2 (2014-02-27 15:35:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-dt-rc4

for you to fetch changes up to ae41a3030ce8901853b3cfd5e118a4b0288aa068:

  ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid problems with booting (2014-03-02 09:44:45 -0800)

----------------------------------------------------------------
Two omap3430 vs 3630 device tree regression fixes for
issues booting 3430 based boards.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: omap3-igep: fix boot fail due wrong compatible match

Marek Belisko (1):
      ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid problems with booting

 arch/arm/boot/dts/omap3-gta04.dts    | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
 arch/arm/boot/dts/omap3-igep0030.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
