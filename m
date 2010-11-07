From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Sun,  7 Nov 2010 23:43:24 +0200
Message-ID: <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab0KGVoC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:44:02 -0500
Received: by fxm16 with SMTP id 16so3600214fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:44:01 -0800 (PST)
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

Paul already sent these, but I did some minor modifications, mostly to minimize
the amount of changes.

Also, I'm re-sending my memblock patch so that the driver can actually be
compiled.

With these, and reverting the iommu patches[1], the driver should be working. I
don't see a more straight-forward way to achieve that.

Cheers.

Felipe Contreras (1):
  omap: dsp: remove shm from normal memory

Paul Walmsley (4):
  omap: control: add functions for DSP boot
  omap: pm: use control functions in DSP reset code
  omap: dsp: add boot control functions
  staging: tidspbridge: use boot control functions

 arch/arm/mach-omap2/control.c                 |   49 +++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h                 |   10 +++---
 arch/arm/mach-omap2/dsp.c                     |    4 ++
 arch/arm/mach-omap2/pm34xx.c                  |    6 ++--
 arch/arm/plat-omap/devices.c                  |    4 ++-
 arch/arm/plat-omap/include/plat/dsp.h         |   10 +++++
 drivers/staging/tidspbridge/core/tiomap3430.c |   13 +++----
 7 files changed, 80 insertions(+), 16 deletions(-)

[1] git://gitorious.org/~felipec/linux-omap/felipec.git fc-dsp-iommu-revert-v37-rc1

-- 
1.7.3.2.3.gf8529

