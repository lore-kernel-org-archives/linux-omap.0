From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM fixes for 2.6.38-rc
Date: Tue, 01 Mar 2011 15:14:35 -0800
Message-ID: <87pqqae8mc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41939 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756997Ab1CAXOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 18:14:40 -0500
Received: by mail-yw0-f43.google.com with SMTP id 6so2239449ywi.16
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 15:14:37 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Here's a final batch of PM fixes for the 2.6.38-rc cycle.

Kevin

The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.38/pm-fixes

Aaro Koskinen (1):
      arm: mach-omap2: smartreflex: fix another memory leak

Shweta Gulati (1):
      OMAP2+: PM: SmartReflex: fix memory leaks in Smartreflex driver

Vasiliy Kulikov (3):
      mach-omap2: mux: world-writable debugfs files
      mach-omap2: pm: world-writable debugfs timer files
      mach-omap2: smartreflex: world-writable debugfs voltage files

 arch/arm/mach-omap2/mux.c         |    2 +-
 arch/arm/mach-omap2/pm-debug.c    |    8 ++++----
 arch/arm/mach-omap2/smartreflex.c |   37 +++++++++++++++++--------------------
 3 files changed, 22 insertions(+), 25 deletions(-)

