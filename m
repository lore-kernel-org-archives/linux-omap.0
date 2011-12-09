From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: minor PM cleanups for v3.3
Date: Fri, 09 Dec 2011 09:47:04 -0800
Message-ID: <87pqfxhc2v.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49284 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361Ab1LIRrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 12:47:09 -0500
Received: by mail-gx0-f169.google.com with SMTP id i2so3440768ggn.28
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 09:47:07 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the following minor PM cleanups for v3.3.

Thanks,

Kevin


The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/cleanup/pm

Abhilash K V (1):
      ARM: OMAP2+: voltage: add check for missing PMIC info in VP init

Kevin Hilman (2):
      ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
      ARM: OMAP: voltage: cleanup VC/VP error messages

Ohad Ben-Cohen (1):
      ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}

 arch/arm/mach-omap2/pm.c                      |    6 ++----
 arch/arm/mach-omap2/twl-common.c              |   11 +++++++++++
 arch/arm/mach-omap2/twl-common.h              |    3 +++
 arch/arm/mach-omap2/vc.c                      |    5 ++---
 arch/arm/mach-omap2/vp.c                      |    6 ++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    7 +++++++
 arch/arm/plat-omap/omap_device.c              |   13 +++----------
 7 files changed, 34 insertions(+), 17 deletions(-)
