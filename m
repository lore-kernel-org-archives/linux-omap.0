From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Two omap fixes for v3.18 merge window
Date: Fri, 10 Oct 2014 13:49:45 -0700
Message-ID: <20141010204945.GI10014@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21961 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751661AbaJJUuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 16:50:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit f86dc4b04dd5292cae3708c16ca6e46dbb5c95fa:

  Merge tag 'defconfig-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2014-10-08 17:38:52 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-for-v3.18-merge-window

for you to fetch changes up to b16ccfe02313acd829debfccac45531f45d797cd:

  ARM: dts: Disable smc91x on n900 until bootloader dependency is removed (2014-10-09 11:28:34 -0700)

----------------------------------------------------------------
Two omap fixes for issues noticed during the merge window:

- We need to enable ARM errata 430973 for omap3

- The smc91x on some early n900 boards need to be disabled
  for now until the dependencies to specific a bootloader
  version are fixed

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: omap2plus_defconfig: Enable ARM erratum 430973 for omap3
      ARM: dts: Disable smc91x on n900 until bootloader dependency is removed

 arch/arm/boot/dts/omap3-n900.dts     | 3 +++
 arch/arm/configs/omap2plus_defconfig | 1 +
 2 files changed, 4 insertions(+)
