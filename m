From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 0/3][NAND][OMAP]: fixing omap nand driver issues
Date: Wed, 6 Jan 2010 19:28:38 +0530
Message-ID: <ce9ab5791001060558u362f17baj5ee90e9b4adb72a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44364 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0AFN7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 08:59:00 -0500
Received: by bwz27 with SMTP id 27so10682241bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 05:58:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>
Cc: linux-omap@vger.kernel.org

>From 3700088e8da8c890d9e4c6eb626e18287d149b97 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 5 Jan 2010 16:43:08 +0530
Subject: [PATCH] fixing omap nand driver issues

fixing omap nand driver issues.

Vimal Singh (3):
  Fixing compilation warning for 'nand/omap2.c'
  NAND: OMAP: correct 'info' pointer in 'omap_nand_remove'
  NAND: OMAP: Fixing issue in oamp nand driver in prefetch mode read

 drivers/mtd/nand/omap2.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)
