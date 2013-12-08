From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two regression fixes and two more omap dt fixes against v3.13-rc2
Date: Sun, 8 Dec 2013 15:09:40 -0800
Message-ID: <17087.957627564$1386544193@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65228 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755510Ab3LHXJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Dec 2013 18:09:45 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/yet-more-dt-regressions-take2

for you to fetch changes up to f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:

  ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)

----------------------------------------------------------------
A rather big fix for a regression where we have dropped omap4 hwmod
data earlier but are not initializing it from device tree. In addition
to this fix we eventually also be fix the issues in the .dts files
and drivers, but that's too intrusive for the -rc cycle and must be
done later on.

Also a fix for a regression where we now are wrongly trying to initialize
devices on secure omaps like n900 and n9* when booted using device tree.
We need to set aes, sham and timer12 to disabled mode for secure
devices as they are claimed by the firmware running in the secure mode.

And two more legacy booting vs device tree based booting fixes for
am3517 that I did not notice earlier until Nishant Menon reported
these to me few days ago. With these we're good to go having v3.13
working both for legacy booting and device tree based booting, and we
can then go ahed and drop the legacy booting for mach-omap2 for v3.14.

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP2+: Fix the machine entry for am3517

Tony Lindgren (3):
      ARM: OMAP2+: Fix overwriting hwmod data with data from device tree
      ARM: dts: Fix missing entries for am3517
      ARM: dts: Fix booting for secure omaps

 arch/arm/boot/dts/am3517-evm.dts     |  6 +--
 arch/arm/boot/dts/am3517.dtsi        | 63 +++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n900.dts     |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi |  2 +-
 arch/arm/boot/dts/omap34xx-hs.dtsi   | 16 ++++++
 arch/arm/boot/dts/omap36xx-hs.dtsi   | 16 ++++++
 arch/arm/mach-omap2/board-generic.c  | 18 +++++++
 arch/arm/mach-omap2/omap_hwmod.c     | 98 ++++++++++++++++++++++++++++--------
 8 files changed, 196 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517.dtsi
 create mode 100644 arch/arm/boot/dts/omap34xx-hs.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-hs.dtsi
