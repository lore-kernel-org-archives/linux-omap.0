From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] IRQ-related changes
Date: Tue,  4 Jan 2011 11:39:24 +0200
Message-ID: <1294133966-20279-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52450 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170Ab1ADJjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 04:39:32 -0500
Received: by mail-gw0-f45.google.com with SMTP id 23so6713281gwj.32
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 01:39:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi,

The following two patches are enabling SPARSE_IRQ
numbering scheme on OMAP. I lightly tested on a pandaboard
and seems to be working fine so far:

# cat /proc/interrupts
           CPU0       CPU1
 39:          1          0         GIC  TWL6030-PIH
 44:       1758          0         GIC  DMA
 69:       7615          0         GIC  gp timer
 88:        195          0         GIC  i2c_omap
 89:          0          0         GIC  i2c_omap
 93:          0          0         GIC  i2c_omap
 94:          0          0         GIC  i2c_omap
102:          0          0         GIC  serial idle
104:          0          0         GIC  serial idle
105:          0          0         GIC  serial idle
106:        743          0         GIC  serial idle, OMAP UART2
115:       2356          0         GIC  mmc0
160:          0          0        GPIO  mmc0
376:          0          0     twl6030  twl4030_pwrbutton
379:          0          0     twl6030  rtc0
IPI:       1111       9537
LOC:          0          0 
Err:          0

The first patch just removes the direct access to irq_desc
array and converts it to irq_to_desc(). Second patch simply
selects HAVE_GENERIC_HARDIRQS and HAVE_SPARSE_IRQ. I boot
tested with and without enabling:

 -> General setup
  -> IRQ subsystem
   -> SPARSE_IRQ

and both kernels boot fine.

Felipe Balbi (2):
  arm: omap: gpio: don't access irq_desc array directly
  arm: omap: select HAVE_SPARSE_IRQ

 arch/arm/Kconfig          |    2 ++
 arch/arm/plat-omap/gpio.c |   10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
1.7.3.4.598.g85356

