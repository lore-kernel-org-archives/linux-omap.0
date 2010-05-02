From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 0/4] omap: mailbox: cleanup & simplify
Date: Sun,  2 May 2010 18:44:27 +0300
Message-ID: <1272815071-2827-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61422 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0EBPov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 11:44:51 -0400
Received: by bwz19 with SMTP id 19so900064bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 08:44:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

This series include comments from Hiroshi and Hari (thanks!).

Changes since v1:
- add mbox_kfifo_size module parameter
- WARN_ON kfifo anomalies
- remove redundant blkdev.h file
- fix rwlocks->spinlock conversion

Thanks,
Ohad.

---
If you want, you can also reach me at < ohadb at ti dot com >.

Ohad Ben-Cohen (4):
  omap: mailbox: convert rwlocks to spinlock
  omap: mailbox cleanup: split MODULE_AUTHOR line
  omap: mailbox: fix reverse likeliness
  omap: mailbox: convert block api to kfifo

 arch/arm/mach-omap2/mailbox.c             |    3 +-
 arch/arm/plat-omap/Kconfig                |    9 ++
 arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
 arch/arm/plat-omap/mailbox.c              |  144 +++++++++++++----------------
 4 files changed, 79 insertions(+), 81 deletions(-)

