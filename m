From: Christopher Harvey <charvey@matrox.com>
Subject: [PATCH v2] 16 bit NAND fix, request for testers
Date: Fri, 26 Oct 2012 15:34:10 -0400
Message-ID: <20121026193410.GA21474@harvey-pc.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtxmxout1.matrox.com ([138.11.2.91]:50559 "EHLO
	mtxmxout1.matrox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966136Ab2JZTbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 15:31:01 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org

just a small patch to access GPMC NAND registers with 16 bits when the
NAND is in 16 bit mode. I tested this on a 2.6.37 kernel, and noticed
it was still unpatched in the latest kernel. I don't have the hardware
setup or defconfigs to test this patch out, and even if I did I don't
have the logic analyzer setup to completely reproduce it on other
hardware with the latest kernel. It would be nice to get a tested-by
on this patch.

(CC'd mtd list this time)

Thanks.


Christopher Harvey (1):
  mtd: omap: nand: Remove 0xFF's that prefixed 16bit NAND commands

 drivers/mtd/nand/omap2.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

-- 
1.7.8.6
