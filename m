From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] ARM: OMAP: PM cleanups for v3.4
Date: Mon, 05 Mar 2012 16:53:29 -0800
Message-ID: <87mx7uh7na.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:39518 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932593Ab2CFAxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 19:53:31 -0500
Received: by mail-pw0-f50.google.com with SMTP id xa12so487143pbc.9
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 16:53:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>

Tony,

Please pull the following PM related cleanups for v3.4.

Note that due to conflicts with changes from both your cleanup branch
and your hsmmc branch, I created a merge base by starting at 'cleanup'
and merging hsmmc, and basing this series on top.

Let me know if you want some other baseline for this series.

Kevin


The following changes since commit 015f1e4297ad32f83251f3f4cee2389ce5516e9e:

  Merge remote-tracking branch 'omap/hsmmc' into for_3.4/cleanup/pm-base (2012-03-05 15:37:04 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/pm

for you to fetch changes up to 1416408d31236dc2a80d269aa23ffa93aa01e833:

  ARM: OMAP2+: PM: share some suspend-related functions across OMAP2, 3, 4 (2012-03-05 16:01:19 -0800)

----------------------------------------------------------------
Jean Pihet (1):
      ARM: OMAP2+: PM debug: fix the use of debugfs_create_* API

Kevin Hilman (1):
      ARM: OMAP: omap_device: remove omap_device_parent

Paul Walmsley (5):
      ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
      ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
      ARM: OMAP2+: PM: share clkdms_setup() across OMAP2, 3, 4
      ARM: OMAP2+: omap_device: call all suspend, resume callbacks when OMAP_DEVICE_NO_IDLE_ON_SUSPEND is set
      ARM: OMAP2+: PM: share some suspend-related functions across OMAP2, 3, 4

 arch/arm/mach-omap2/omap-mpuss-lowpower.c     |    2 -
 arch/arm/mach-omap2/pm-debug.c                |    6 +-
 arch/arm/mach-omap2/pm.c                      |  113 ++++++++++++++++++++-----
 arch/arm/mach-omap2/pm.h                      |    2 +
 arch/arm/mach-omap2/pm24xx.c                  |   75 ++--------------
 arch/arm/mach-omap2/pm34xx.c                  |   74 +---------------
 arch/arm/mach-omap2/pm44xx.c                  |   57 +------------
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |    2 +-
 arch/arm/plat-omap/omap_device.c              |   24 ++----
 10 files changed, 118 insertions(+), 239 deletions(-)
