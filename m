From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] omap fixes for v2.6.37-rc1
Date: Thu, 11 Nov 2010 17:03:20 -0800
Message-ID: <20101112010245.3827.75329.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50223 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab0KLBD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 20:03:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few fixes for review.

Regards,

Tony

---

Felipe Balbi (1):
      arm: omap1: devices: need to return with a value

Janusz Krzysztofik (1):
      OMAP1: camera.h: add missing include

Mathias Nyman (1):
      omap: dma: Add read-back to DMA interrupt handler to avoid spuriousinterrupts

Thomas Weber (1):
      OMAP2: Devkit8000: Fix mmc regulator failure


 arch/arm/mach-omap1/devices.c             |    5 ++---
 arch/arm/mach-omap1/include/mach/camera.h |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c    |    3 ---
 arch/arm/plat-omap/dma.c                  |    2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
Signature
