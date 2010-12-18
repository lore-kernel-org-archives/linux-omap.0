From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Misc omap board patches for v2.6.38 merge window
Date: Fri, 17 Dec 2010 19:05:15 -0800
Message-ID: <20101218030406.10251.73118.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48794 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab0LRDFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 22:05:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi,

The following set contains some patches for the v2.6.38 merge window.

Regards,

Tony

---

Hemanth V (2):
      omap4: Add platform changes for Ambient Light sensor
      omap4: Add platform changes for PWM LED

Laurent Pinchart (2):
      omap3: igepv2: Don't call gpio_set_value right aftergpio_direction_output
      omap3: igepv2: LED gpio-led:green:d1 is active low

Raghuveer Murthy (1):
      OMAP4: Pandaboard: Add omap_reserve functionality

Tony Lindgren (1):
      omap1: Fix innovator FPGA init for multi-omap


 arch/arm/mach-omap1/board-innovator.c  |    7 ++-----
 arch/arm/mach-omap1/fpga.c             |   10 ++++++----
 arch/arm/mach-omap2/board-4430sdp.c    |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-igep0020.c   |   21 +++++++++------------
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 arch/arm/plat-omap/include/plat/fpga.h |    4 ----
 6 files changed, 45 insertions(+), 25 deletions(-)

-- 
Signature
