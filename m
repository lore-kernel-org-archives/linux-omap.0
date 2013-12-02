From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] more omap dt fixes against v3.13-rc1
Date: Mon, 2 Dec 2013 13:40:45 -0800
Message-ID: <9424.02487057752$1386020479@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18492 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3LBVlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 16:41:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 9cb238c00ba5c1ddfff2c2ed6aa66c15b962e4c3:

  mmc: omap: Fix I2C dependency and make driver usable with device tree (2013-11-26 15:51:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/more-dt-regressions

for you to fetch changes up to ac46bf3933421bde881399d9ad3d165064862cc3:

  ARM: dts: Fix the name of supplies for smsc911x shared by OMAP (2013-12-02 11:38:15 -0800)

----------------------------------------------------------------
Few more legacy booting vs device tree booting fixes that people
have noticed while booting things with device tree for things like
omap4 WLAN, smsc911x, and beagle audio. Hopefully this will be it
for the legacy booting vs device tree fixes for this -rc cycle.

----------------------------------------------------------------
Balaji T K (2):
      ARM: dts: omap4-panda-common: Fix pin muxing for wl12xx
      ARM: dts: omap4-sdp: Fix pin muxing for wl12xx

Florian Vaussard (1):
      ARM: dts: Fix the name of supplies for smsc911x shared by OMAP

Jarkko Nikula (1):
      ARM: dts: omap3-beagle: Add omap-twl4030 audio support

Rajendra Nayak (1):
      ARM: OMAP2+: Powerdomain: Fix unchecked dereference of arch_pwrdm

 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi |  4 ++--
 arch/arm/boot/dts/omap3-beagle.dts        | 14 ++++++++++++++
 arch/arm/boot/dts/omap4-panda-common.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/omap4-sdp.dts           | 12 ++++++------
 arch/arm/mach-omap2/powerdomain.c         |  3 ++-
 5 files changed, 34 insertions(+), 19 deletions(-)
