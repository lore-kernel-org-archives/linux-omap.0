From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/4] OMAP Mailbox legacy platform device support removal
Date: Wed, 6 Apr 2016 12:37:36 -0500
Message-ID: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Jassi,

This series cleans up the OMAP Mailbox driver dropping the
support for legacy non-DT platform devices. The infrastructure
for creating any such devices has all been cleaned up from the
mach-omap2 layers.

The removal from the driver is accomplished in patch 1, while the
remaining patches do some minor checkpatch fixes.

Patches baselined on 4.6-rc2.

regards
Suman

Suman Anna (4):
  mailbox/omap: drop legacy platform device support
  mailbox/omap: use variable name for sizeof() operator
  mailbox/omap: remove FSF mailing address paragraph
  mailbox/omap: add blank lines after declarations

 drivers/mailbox/omap-mailbox.c             | 116 ++++++++++++-----------------
 include/linux/platform_data/mailbox-omap.h |  58 ---------------
 2 files changed, 48 insertions(+), 126 deletions(-)
 delete mode 100644 include/linux/platform_data/mailbox-omap.h

-- 
2.7.4
