From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 0/3] NAND: OMAP: Fix and clean NAND driver
Date: Fri, 30 Oct 2009 14:12:11 +0530
Message-ID: <ce9ab5790910300142q6062c47p935ae967955f89f@mail.gmail.com>
References: <ce9ab5790910292320x2eef0550pdc3fde5d616ea361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53316 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351AbZJ3Im1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 04:42:27 -0400
Received: by bwz27 with SMTP id 27so3265936bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 01:42:31 -0700 (PDT)
In-Reply-To: <ce9ab5790910292320x2eef0550pdc3fde5d616ea361@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

Looping Linux-omap mailing list.


From: Vimal Singh <vimalsingh@ti.com>
Date: Fri, 30 Oct 2009 11:34:14 +0530
Subject: [PATCH 0/3] NAND: OMAP: Fix and clean NAND driver

This patch series addresses some of the issues in omap nand driver.

Vimal Singh (3):
 Fixing compilation warning for 'nand/omap2.c'
 NAND: OMAP: Fixing omap nand driver, compiled as module
 NAND: OMAP: Simplifying HWECC and removing unnecessary macros

 drivers/mtd/nand/omap2.c |  315 ++++++++++++++++------------------------------
 1 files changed, 108 insertions(+), 207 deletions(-)

--
Regards,
Vimal Singh
