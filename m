From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] ARM: OMAP: CPUfreq fixes for v3.7-rc
Date: Mon, 08 Oct 2012 15:22:46 -0700
Message-ID: <878vbg8uyx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48390 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2JHWWr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 18:22:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4417226pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 15:22:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

The following changes since commit 16642a2e7be23bbda013fc32d8f6c68982eab603:

  Merge tag 'pm-for-3.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2012-10-02 18:32:35 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-fixes-cpufreq

for you to fetch changes up to 24d7b40a60cf19008334bcbcbd98da374d4d9c64:

  ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS (2012-10-08 14:59:04 -0700)

----------------------------------------------------------------
This series a couple bug fixes and a couple fixes that make this
driver support recently added OMAP-based SoCs.

The 'get_cpu_device' patch is needed due to a change in the OMAP
OMAP PM core code which enforces use of get_cpu_device() instead of
a deprecated OMAP-specific API.

The usage of plat/*.h headers breaks single zImage, so platforms are
cleaning up and/or removing plat/*.h so the driver needs to be fixed
accordingly.

This series is based on the merge of Rafael's pm-for-3.7-rc1 tag into
Linus' master branch: commit 16642a2e7be23bbda013fc32d8f6c68982eab603.

----------------------------------------------------------------
Kevin Hilman (4):
      cpufreq: OMAP: ensure valid clock rate before scaling
      cpufreq: OMAP: remove unused <plat/omap-pm.h>
      cpufreq: OMAP: use get_cpu_device() instead of omap_device API
      ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS

Paul Walmsley (1):
      cpufreq: OMAP: fix clock usage to be SoC independent, remove plat/ includes

 arch/arm/mach-omap2/opp.c        |   23 +++++++++++++++++------
 arch/arm/mach-omap2/pm.c         |   11 ++++++++++-
 arch/arm/mach-omap2/twl-common.c |    2 +-
 drivers/cpufreq/omap-cpufreq.c   |   36 ++++++++++++------------------------
 4 files changed, 40 insertions(+), 32 deletions(-)
