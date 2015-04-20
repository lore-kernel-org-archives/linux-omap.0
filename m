From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] urgent omap boot fix for v4.1 if MFD_SYSCON is not set
Date: Mon, 20 Apr 2015 11:58:16 -0700
Message-ID: <20150420185816.GI5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:45891 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbbDTTBU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Apr 2015 15:01:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/prcm-dts-mfd-syscon-fix

for you to fetch changes up to da4d81453cf1eedfcd8b2cd1e7bfab230084bd87:

  ARM: OMAP2+: Fix booting with configs that don't have MFD_SYSCON (2015-04-20 10:36:31 -0700)

----------------------------------------------------------------
Urgent pull request for v4.1 to booting for custom kernel
.config files that do not have MFD_SYSCON set.

Omaps now have a dependency to MFD_SYSCON for system control
module generic register area and some clocks with the changes
done in omap-for-v4.1/prcm-dts branch.

This can be pulled on top of omap-for-v4.1/prcm-dts, or into
fixes for v4.1.

We already do have a slight MFD_SYSCON dependency for
REGULATOR_PBIAS for dual voltage MMC cards on the first MMC
bus for many devices, so from that point of view this can
also be merged separately from omap-for-v4.1/prcm-dts.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: OMAP2+: Fix booting with configs that don't have MFD_SYSCON

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)
