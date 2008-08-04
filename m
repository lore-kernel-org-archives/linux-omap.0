From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 0/3 v2] OMAP3 Beagle: Enable nand support
Date: Mon, 04 Aug 2008 17:57:53 +0200
Message-ID: <48972701.2080006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:19323 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757498AbYHDP54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 11:57:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1022490fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 04 Aug 2008 08:57:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Steve Sakoman <sakoman@gmail.com>

This series of patches adds NAND support to the BeagleBoard.

The first patch in the series builds on work by Teerth Reddy 
<teerth@ti.com> and Steve Sakoman <sakoman@gmail.com> to extend the 
omap2 nand driver to work with both omap2 and omap3 architectures (as 
well as adding/clarifying comments).

The second patch adds the beagle nand support, and the final patch 
enables the nand driver and jffs2 support in the beagle defconfig.

The patch set was reviewed by Khasim Syed Mohammed <khasim@ti.com> 
prior to this submission.  It was tested on Rev A and B BeagleBoards.

This v2 replaces http://marc.info/?l=linux-omap&m=121230229625544&w=2

Changes in v2:

- Apply cleanly to recent git (defconfig, drivers/mtd/nand/omap2.c)
- Beagle has only NAND. This results in small config. Move 
configuration to board-omap3beagle.c and don't create a new file 
board-omap3beagle-flash.c for it.
