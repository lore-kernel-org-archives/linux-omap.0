From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Omap fixes for 2.6.30-rc5
Date: Thu, 14 May 2009 10:41:49 -0700
Message-ID: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65445 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZENRlz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:41:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are some omap fixes for 2.6.30-rc5 for review.

Regards,

Tony

---

Jarkko Nikula (2):
      ARM: OMAP2: Fix SPI driver failure on 2420 when running multi-omap config
      ARM: OMAP2: Fix tusb6010 init error and compilation warning

Kalle Jokiniemi (1):
      ARM: OMAP3: Fix HW SAVEANDRESTORE shift define

Paul Walmsley (1):
      ARM: OMAP: GPIO de-bounce clocks don't affect module idle state

Tomi Valkeinen (1):
      ARM: OMAP: Fix printing of reserved memory for frambuffer

Tony Lindgren (3):
      ARM: OMAP3: Fix number of GPIO lines for 34xx
      ARM: OMAP2/3: Change omapfb to use clkdev for dispc and rfbi
      ARM: OMAP2/3: Add name for musb clocks


 arch/arm/mach-omap2/clock24xx.c        |   10 +++++-----
 arch/arm/mach-omap2/clock34xx.c        |   12 ++++++------
 arch/arm/mach-omap2/clock34xx.h        |   12 ++++++------
 arch/arm/mach-omap2/devices.c          |    6 ++++--
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
 arch/arm/mach-omap2/usb-tusb6010.c     |    2 +-
 arch/arm/plat-omap/fb.c                |    5 +++--
 arch/arm/plat-omap/gpio.c              |    2 +-
 drivers/video/omap/dispc.c             |   16 +++++++++-------
 drivers/video/omap/rfbi.c              |    8 +++++---
 10 files changed, 41 insertions(+), 34 deletions(-)

-- 
Signature
