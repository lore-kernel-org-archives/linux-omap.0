From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/1] mtd: OneNAND: fix bufferram management.
Date: Sat, 23 Oct 2010 15:43:53 +0200
Message-ID: <1287841434-3349-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64773 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912Ab0JWNoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 09:44:11 -0400
Received: by wyf28 with SMTP id 28so1848142wyf.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 06:44:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, kyungmin.park@samsung.com, dwmw2@infradead.org, Artem.Bityutskiy@nokia.com, adrian.hunter@nokia.com, m.szyprowski@samsung.com


Hello,

Have a look at this patch, I've some problems with latest kernel from mainline
and a JFFS2 filesystem, the kernel reports various errors like

Header CRC failed on REF_PRISTINE node at 0x1e81315c: Read 0x000000e0, calculated 0x564fc9e8

Applying this patch solves the issue, but I  only have tested on IGEP v2 board with
a OneNAND from Numonyx. Please test with other OneNAND devices and point me if I'm
in the correct way to solve this issue. Thanks.

Cheers,
  Enric

$ git diff --stat origin/master
 drivers/mtd/onenand/onenand_base.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
