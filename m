From: Jon Hunter <jon-hunter@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: Timer build warnings fixes for v3.8-rc
Date: Fri, 14 Dec 2012 10:45:31 -0600
Message-ID: <50CB57AB.8080503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60397 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542Ab2LNQpe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 11:45:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

The following changes since commit 698d601224824bc1a5bf17f3d86be902e2aabff0:

  Merge tag 'drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-12-13 10:59:11 -0800)

are available in the git repository at:


  git://github.com/jonhunter/linux.git fixes-timer-build

for you to fetch changes up to bf85f205d95eb223e849914101e0db1a5a576a3c:

  ARM: OMAP2+: Fix sparse warnings in timer.c (2012-12-14 10:14:55 -0600)

----------------------------------------------------------------
Fixes for a few timer warnings observed with different kernel
configurations for OMAP2+ devices.

I have dropped the patch to fix a build error for OMAP4 in the
timer code as Olof already has this fix merged.
----------------------------------------------------------------

Jon Hunter (2):
      ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
      ARM: AM335x: Fix warning in timer.c

Vaibhav Hiremath (1):
      ARM: OMAP2+: Fix sparse warnings in timer.c

 arch/arm/mach-omap2/Kconfig |    3 ++-
 arch/arm/mach-omap2/timer.c |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)
