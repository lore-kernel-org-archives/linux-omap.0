From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] ARM: OMAP: omap_device updates for v3.7
Date: Wed, 12 Sep 2012 13:21:26 -0700
Message-ID: <87oblbvvp4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:45021 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752680Ab2ILUV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 16:21:28 -0400
Received: by obbuo13 with SMTP id uo13so3302210obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 13:21:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the following omap_device changes for v3.7.  This was a
collaboration between myself and Paul.

Thanks,

Kevin

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-omap_device

for you to fetch changes up to 9634c8dd6a729406e89aed4e29470e3ffb3cd060:

  ARM: OMAP: omap_device: idle devices with no driver bound (2012-09-12 10:52:03 -0700)

----------------------------------------------------------------
Updates for omap_device layer for v3.7.

Allows omap_device layer to keep track of driver bound status in order
to make more intelligent decisions about idling unused devices.

----------------------------------------------------------------
Kevin Hilman (3):
      ARM: OMAP: omap_device: keep track of driver bound status
      ARM: OMAP: omap_device: don't attempt late suspend if no driver bound
      ARM: OMAP: omap_device: idle devices with no driver bound

 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   56 ++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)
