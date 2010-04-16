From: Mike Turquette <mturquette@gmail.com>
Subject: [PATCH 0/4] OMAP: PM: introduce Adaptive Body-Bias LDO
Date: Fri, 16 Apr 2010 16:33:20 -0500
Message-ID: <1271453603-21929-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41890 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480Ab0DPVeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 17:34:03 -0400
Received: by gwaa18 with SMTP id a18so1558486gwa.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 14:34:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Thara Gopinath <thara@ti.com>, Shweta Gulati <shweta.gulati@ti.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

This patch series introduces Forward Body-Bias (FBB), which is one
technique possible using the Adaptive Body-Bias (ABB) LDO.  FBB boosts
voltage on VDD1 PMOS back gates which helps cold devices with weak
silicon characteristics sustain voltage at high OPPs.

All OMAP devices built on the 45nm process have ABB as a part of
SmartReflex2.  This patchset introduces it for OMAP 3630 and OMAP 4 will
make use of ABB in the future.

Patch series is based on pm-wip-sr and tested on Zoom3.  Please note
that the final patch in the series is a total hack and only meant for
those wishing to test this new feature.

 arch/arm/mach-omap2/cpufreq34xx.c         |    8 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h    |   22 +++++
 arch/arm/mach-omap2/prm.h                 |    6 ++
 arch/arm/mach-omap2/voltage.c             |  130 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/control.h |    4 +
 5 files changed, 163 insertions(+), 7 deletions(-)

