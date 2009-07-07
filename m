From: Kalpesh Rathod <kalpeshrathod@gmail.com>
Subject: MMC host controller driver query
Date: Tue, 7 Jul 2009 14:22:14 +0530
Message-ID: <cee4bbc90907070152y7c2c40c1wb927864c4591daa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f193.google.com ([209.85.221.193]:36858 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZGGIwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 04:52:12 -0400
Received: by qyk31 with SMTP id 31so4570837qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2009 01:52:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am trying to make my SDIO wifi card work on beagleboard.
When the driver tries to read or write SDIO function register , it is
generally 1 or 4 byte read/write. And buffer used is mostly on stack.
So, the kernel crashes while doing dma_map_sg on that buffer. Using
kmalloc ed buffer in SDIO read/write avoids this problem.

I am using 2.6.28-omap1. Will upgrading to recent kernel allow the
buffer on stack to be used in SDIO read/write functions.?
sdio_readl/sdio_writel uses its own DMA ble buffer. But for some
reasons I want to avoid it.

I noticed some commits related to scatter-gather emulation.
Is it related to the problem?

thanks in advance.

Regards,
Kalpesh
