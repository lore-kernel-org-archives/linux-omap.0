From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/2] omapfb: option to use coherent dma mem
Date: Mon, 30 Dec 2013 15:19:08 +0200
Message-ID: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab3L3NUD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Dec 2013 08:20:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <freemangordon@abv.bg>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This is a bit refined version from the patch sent by Ivaylo.

So Ivaylo asked for an exclusive memory area for omapfb, so that the
allocations would not fail, and Vaibhav asked for reserving the fb at a
specified physical address, so that the bootloader can pass the fb to the
kernel. Those are a bit linked issues, and these patches try to accomplish
both.

This series is somewhat experimental, as I'm not so familiar with the dma api,
but, well, this seemed to work for the tests I did.

 Tomi

Tomi Valkeinen (2):
  ARM: omapfb: add coherent dma memory support
  omapfb: add support to reserve fb at specified phys address

 arch/arm/mach-omap2/common.c             |  1 +
 arch/arm/mach-omap2/common.h             |  2 +
 arch/arm/mach-omap2/fb.c                 | 77 +++++++++++++++++++++++++++++++-
 drivers/video/omap2/omapfb/omapfb-main.c | 36 +++++++++++----
 drivers/video/omap2/omapfb/omapfb.h      |  1 +
 5 files changed, 107 insertions(+), 10 deletions(-)

-- 
1.8.3.2

