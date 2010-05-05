From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 0/4] omap: mailbox: cleanup & simplify
Date: Wed,  5 May 2010 18:33:05 +0300
Message-ID: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41950 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569Ab0EEPdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:33:33 -0400
Received: by fxm10 with SMTP id 10so4345399fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 08:33:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

This series includes comments from Hiroshi and Tony (thanks!).

Changes since v2:
- add mbox_kfifo_size module parameter sanity checks
- remove (un)likely macros from cold mailbox paths

Thanks,
Ohad.

---
If you want, you can also reach me at < ohadb at ti dot com >.

Ohad Ben-Cohen (4):
  omap: mailbox: convert rwlocks to spinlock
  omap: mailbox cleanup: split MODULE_AUTHOR line
  omap: mailbox: remove (un)likely macros from cold paths
  omap: mailbox: convert block api to kfifo

 arch/arm/mach-omap2/mailbox.c             |    3 +-
 arch/arm/plat-omap/Kconfig                |    9 ++
 arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
 arch/arm/plat-omap/mailbox.c              |  155 ++++++++++++++---------------
 4 files changed, 87 insertions(+), 84 deletions(-)

