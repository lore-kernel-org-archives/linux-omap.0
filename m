From: Christopher Harvey <charvey@matrox.com>
Subject: [PATCH 0/1] 16 bit NAND fix, request for testers
Date: Fri, 19 Oct 2012 13:19:34 -0400
Message-ID: <20121019171934.GA7594@harvey-pc.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtxmxout3.matrox.com ([138.11.2.93]:40459 "EHLO
	mtxmxout3.matrox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab2JSRtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 13:49:12 -0400
Received: from venus.matrox.com (venus.matrox.com [192.168.1.30])
	by mtxmxout3.matrox.com (Postfix) with ESMTP id D54381A5F1F
	for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 13:16:18 -0400 (EDT)
Received: (from ssmsp@localhost)
	by venus.matrox.com (8.14.4/8.13.2) id q9JHGIif003844
	for linux-omap@vger.kernel.org; Fri, 19 Oct 2012 13:16:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by venus.matrox.com (Postfix) with ESMTP id 96561F4DB6
	for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 13:16:18 -0400 (EDT)
Received: from pluton.matrox.com (pluton.matrox.com [192.168.8.7])
	by venus.matrox.com (Postfix) with ESMTP id 78EDBF4DB5
	for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 13:16:18 -0400 (EDT)
Received: from harvey-pc.matrox.com (dyn-152-224.matrox.com [192.168.152.224])
	by pluton.matrox.com (Postfix) with ESMTP id 63A507F45A
	for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 13:16:18 -0400 (EDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

just a small patch to access NAND registers with 16 bits when the NAND
is in 16 bit mode. I tested this on a 2.6.37 kernel, and noticed it
was still unpatched in the latest kernel. I don't have the hardware
setup or defconfigs to test this patch out, and even if I did I don't
have the logic analyzer setup to completely reproduce it on other
hardware with the latest kernel. It would be nice to get a tested-by
on this patch.

Thanks.

Christopher Harvey (1):
  mtd: omap: nand: Remove 0xFF's that prefixed 16bit NAND commands

 drivers/mtd/nand/omap2.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

-- 
1.7.8.6
