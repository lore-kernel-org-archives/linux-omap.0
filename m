From: Kevin Hilman <khilman@ti.com>
Subject: OMAP PM fixes for 2.6.38-rc3
Date: Mon, 31 Jan 2011 13:12:22 -0800
Message-ID: <87aaig93rd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44051 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840Ab1AaVMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 16:12:30 -0500
Received: by mail-yx0-f179.google.com with SMTP id 7so2193464yxs.10
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 13:12:25 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Please pull the following small set of PM-related fixes for 2.6.38-rc.

Kevin

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.38/pm-fixes

Aaro Koskinen (1):
      arm: mach-omap2: voltage: debugfs: fix memory leak

Julia Lawall (1):
      OMAP: PM: SmartReflex: Add missing IS_ERR test

Kevin Hilman (1):
      OMAP3: PM: fix save secure RAM to restore MPU power state

Stefan Weil (2):
      OMAP: PM: SmartReflex: Fix possible memory leak
      OMAP: PM: SmartReflex: Fix possible null pointer read access

 arch/arm/mach-omap2/pm34xx.c      |    7 ++++---
 arch/arm/mach-omap2/smartreflex.c |   11 +++++------
 arch/arm/mach-omap2/voltage.c     |    1 +
 3 files changed, 10 insertions(+), 9 deletions(-)
