From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
Date: Thu, 17 Feb 2011 11:24:41 +0100
Message-ID: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41538 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab1BQKZA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 05:25:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, David Lambert <dlambert@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

All, 

Due to the important number of modifications recently done on the
OMAP4 data compared to the original and the total absence of explanation
in the changelog, I re-submit the data before the driver series in order
to maintain the integrity of the original file and to avoid a huge pain
during the merge.

Govind, Tarun and Kishon, 
Please note that I cannot include here the dev_attr or rev field for
McSPI, McBSP and timer since it requires some modification in the device
header.
You will have to update your series accordingly.

A couple of extra hwmod are added as well to avoid the future drivers
series to include them.
The various USB OMAP4 hwmods data will be send soon.

Regards,
Benoit

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Charulatha V <charu@ti.com>
Cc: David Lambert <dlambert@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

are available in the git repository at:

  git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data

Benoit Cousson (8):
  OMAP4: hwmod data: Add hwspinlock
  OMAP4: hwmod data: Add McSPI
  OMAP4: hwmod data: Add timer
  OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI and VENC
  OMAP4: hwmod data: Add mailbox
  OMAP4: hwmod data: Add DMIC
  OMAP4: hwmod data: Add McBSP
  OMAP4: hwmod data: Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 3023 +++++++++++++++++++++++++++-
 1 files changed, 2977 insertions(+), 46 deletions(-)

