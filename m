From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] ARM: OMAP: UART: cleanups for v3.4
Date: Tue, 06 Mar 2012 16:15:47 -0800
Message-ID: <877gyxb70s.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:56155 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031620Ab2CGAPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Mar 2012 19:15:50 -0500
Received: by mail-tul01m020-f171.google.com with SMTP id x4so8412220obh.2
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 16:15:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Here are a couple minor cleanups in the serial init code for v3.4.

Kevin


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/uart

for you to fetch changes up to 7cb034f8179dfc2889c1f2341566ee68f648a324:

  ARM: OMAP2+: remove some orphan function declarations. (2012-02-21 11:13:11 -0800)

----------------------------------------------------------------
NeilBrown (2):
      ARM: OMAP2+: UART: remove unused fields in omap_uart_state.
      ARM: OMAP2+: remove some orphan function declarations.

 arch/arm/mach-omap2/pm.h                 |    1 -
 arch/arm/mach-omap2/serial.c             |    4 ----
 arch/arm/plat-omap/include/plat/serial.h |    1 -
 3 files changed, 6 deletions(-)
