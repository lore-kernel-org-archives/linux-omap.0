From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP clock: new platform prep + AM35xx clock definitions
Date: Mon, 14 Dec 2009 13:16:35 -0700
Message-ID: <20091214201431.370.35496.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46355 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178AbZLNUTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:19:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Ranjith Lohithakshan <ranjithl@ti.com>

This series adds clkdev-OMAP platform flags for the AM35xx and OMAP36xx
chips, and marks AM35xx platform clocks.


- Paul

---

size:
   text	   data	    bss	    dec	    hex	filename
3615944	 197312	 105168	3918424	 3bca58	vmlinux.beagle.orig
3615944	 197312	 105168	3918424	 3bca58	vmlinux.beagle


Paul Walmsley (1):
      OMAP3 clock: reorganize CK_* platform flags

Ranjith Lohithakshan (1):
      AM35xx: Clock table updates for AM3505/17


 arch/arm/mach-omap2/clock34xx_data.c          |  359 +++++++++++++------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   26 +-
 2 files changed, 200 insertions(+), 185 deletions(-)

