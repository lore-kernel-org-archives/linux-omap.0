From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/4] mmc: omap_hsmmc: Additional cleanups / features
Date: Mon, 9 Apr 2012 12:08:31 +0530
Message-ID: <1333953515-31925-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35606 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab2DIGjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 02:39:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, Venkatraman S <svenkatr@ti.com>

Hi Chris,
  As discussed previously [1], I've rebased the previous 2 patches
that you decided to queue for 3.5, plus 2 additional cleanups.

Best regards,
Venkat.

[1] http://marc.info/?l=linux-mmc&m=133336030703924&w=2

The following changes since commit 3bdc9ba892d6a294d16e9e6e0c4041926aa3d58c:

  mmc: use really long write timeout to deal with crappy cards (2012-04-05 20:32:34 -0400)

are available in the git repository at:

  git://github.com/svenkatr/linux.git mmc-omap_hsmmc-next

for you to fetch changes up to 11c6cb1453f55b21e50fd891b3981a98a572d314:

  mmc: omap_hsmmc: Cleanup use of cpu_is_* for debounce_clock (2012-04-09 11:58:22 +0530)

----------------------------------------------------------------
Balaji T K (2):
      mmc: omap_hsmmc: Enable Auto CMD12
      mmc: omap_hsmmc: add DDR support to omap_hsmmc

Rajendra Nayak (1):
      mmc: omap_hsmmc: Cleanup use of cpu_is_* for debounce_clock

Venkatraman S (1):
      mmc: omap_hsmmc: use spinlock IRQ safe variant

 drivers/mmc/host/omap_hsmmc.c |   78 +++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

-- 
1.7.10.rc2

