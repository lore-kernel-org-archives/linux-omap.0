From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] OMAP Mailbox cleanups for 4.19
Date: Wed, 11 Jul 2018 18:42:10 -0500
Message-ID: <20180711234212.7756-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Jassi,

The following series includes couple of cleanup patches on
the OMAP Mailbox driver. Please pick them for 4.19.

The first patch switches the licensing to use the SPDX license
identifier. The second patch is some code cleanup in preparing
the driver to be built against a 64-bit platform in K3 AM654 SoC
(support for that in OMAP Mailbox driver will be added once the
base K3 AM654 pieces are part of mainline).

regards
Suman

Suman Anna (2):
  mailbox/omap: switch to SPDX license identifier
  mailbox/omap: use of_device_get_match_data() to get match data

 drivers/mailbox/omap-mailbox.c | 31 +++++++++++++++----------------
 include/linux/omap-mailbox.h   |  5 +----
 2 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.17.1
