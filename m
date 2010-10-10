From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] staging: tidspbridge: fix ioremap() usage
Date: Sun, 10 Oct 2010 20:40:37 +0300
Message-ID: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63650 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab0JJRky (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 13:40:54 -0400
Received: by bwz15 with SMTP id 15so1272773bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 10:40:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Now we truly reserve the memory so that the kernel doesn't map it.

Unfortunately, the ARM architecture code doesn't provide a good way to do this,
so I had to modify it a bit.

Felipe Contreras (3):
  arm: mm: allow boards to fiddle with meminfo
  omap: dsp: fix ioremap() usage
  staging: tidspbridge: remove memory consistency from TODO list

 arch/arm/include/asm/mach/arch.h         |    2 +-
 arch/arm/mm/init.c                       |    7 +++--
 arch/arm/plat-omap/common.c              |   43 +++++++++++++++++++++++++++--
 arch/arm/plat-omap/devices.c             |   30 ---------------------
 arch/arm/plat-omap/include/plat/common.h |    3 +-
 arch/arm/plat-omap/include/plat/dsp.h    |    6 ----
 drivers/staging/tidspbridge/TODO         |    1 -
 7 files changed, 47 insertions(+), 45 deletions(-)

-- 
1.7.3.1.2.g7fe2b

