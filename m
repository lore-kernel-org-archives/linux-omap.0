From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.1, urgent fix to avoid potential
 hardware damage
Date: Mon, 1 Jun 2015 13:59:53 -0700
Message-ID: <20150601205952.GF30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55219 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbbFAU7z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 16:59:55 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Here's a pull request to fix potential hardware breaking configuration
on BeagleBones. For the other fixes, apologies for these coming in so
late, seems that people have been busy finding regressions.

Regards,

Tony


The following changes since commit f25bf74c8862efdc30453d16d60cf22958a4873e:

  ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK (2015-05-20 10:00:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc6

for you to fetch changes up to 7a6cb0abe1aa63334f3ded6d2b6c8eca80e72302:

  ARM: dts: am335x-boneblack: disable RTC-only sleep to avoid hardware damage (2015-06-01 12:48:23 -0700)

----------------------------------------------------------------
Omap fixes for the -rc cycle, including a fix for potential hardware
breakage on BeagleBones:

- BeagleBones don't support RTC-only mode, it can cause hardware
  damage if system-power-controller is specified without
  ti,pmic-shutdown-controller

- Fix a recent regression to am3517 SoCs caused by the recent clock
  move that was not noticed until now despite automated boot
  testing

- Fix a regression for n900 touchscreen triggered by recent
  recent input changes

- Fix compatible property for dm816x USB to avoid errors with
  USB Ethernet

- Fix oops for omap3 when built with CONFIG_THUMB2_KERNEL

----------------------------------------------------------------
Matthijs van Duin (1):
      ARM: dts: am335x-boneblack: disable RTC-only sleep to avoid hardware damage

Pavel Machek (1):
      ARM: dts: Fix n900 dts file to work around 4.1 touchscreen regression on n900

Tero Kristo (1):
      ARM: dts: AM35xx: fix system control module clocks

Tony Lindgren (2):
      ARM: OMAP3: Fix booting with thumb2 kernel
      ARM: dts: Fix dm816x to use right compatible flag for MUSB

 .../bindings/input/touchscreen/tsc2005.txt         |  4 ++--
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 19 +++++++++++++++++++
 arch/arm/boot/dts/am35xx-clocks.dtsi               | 14 +++++++-------
 arch/arm/boot/dts/dm816x.dtsi                      |  4 ++--
 arch/arm/boot/dts/omap3-n900.dts                   |  4 ++--
 arch/arm/mach-omap2/sleep34xx.S                    | 22 ++--------------------
 6 files changed, 34 insertions(+), 33 deletions(-)
