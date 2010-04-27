From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 0/4] omap: mailbox: cleanup & simplify
Date: Tue, 27 Apr 2010 20:56:18 +0300
Message-ID: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33549 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab0D0R6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:58:36 -0400
Received: by bwz19 with SMTP id 19so19497bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:58:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

A few simple patches that cleanup and simplifies mailbox.
The last patch is the most interesting -
It converts mailbox to use kfifo as the underlying
queueing implementation instead of using the block API.
There're also additional performance patches on the way, we
are internally testing them now.

Please review and let me know your comments.

Thanks,

Ohad Ben-Cohen (4):
  omap: mailbox cleanup: convert rwlocks to spinlock
  omap: mailbox cleanup: split MODULE_AUTHOR line
  omap: mailbox: fix reverse likeliness
  omap: mailbox: convert block api to kfifo

 arch/arm/mach-omap2/mailbox.c             |    3 +-
 arch/arm/plat-omap/include/plat/mailbox.h |    5 +-
 arch/arm/plat-omap/mailbox.c              |  135 +++++++++++++----------------
 3 files changed, 68 insertions(+), 75 deletions(-)

