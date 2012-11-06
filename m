From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] OMAP: PM: SmartReflex updates for v3.8
Date: Tue, 06 Nov 2012 15:50:46 -0800
Message-ID: <87r4o61eax.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49840 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2KFXus (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 18:50:48 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so701020pad.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 15:50:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>

Tony,

Here's some minor platform_data related updates for SR for v3.8.

Kevin


The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-pm-sr

for you to fetch changes up to 98aed08e16c5f18d0c31fc07127bc163ccd0d04c:

  ARM: OMAP: SmartReflex: pass device dependent data via platform data (2012-10-15 15:22:24 -0700)

----------------------------------------------------------------
OMAP: SmartReflex: pass device-independent data via platform_data

----------------------------------------------------------------
Jean Pihet (2):
      ARM: OMAP: hwmod: align the SmartReflex fck names
      ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/clock33xx_data.c       | 12 +++----
 arch/arm/mach-omap2/clock3xxx_data.c       | 12 +++----
 arch/arm/mach-omap2/clock44xx_data.c       |  6 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  8 ++---
 arch/arm/mach-omap2/sr_device.c            | 13 +++++++
 drivers/power/avs/smartreflex.c            | 54 ++++++++++--------------------
 include/linux/power/smartreflex.h          | 14 ++++++--
 7 files changed, 61 insertions(+), 58 deletions(-)
