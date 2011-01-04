From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] ARM IRQ Changes
Date: Tue,  4 Jan 2011 14:02:53 +0200
Message-ID: <1294142577-28772-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59872 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100Ab1ADMDB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 07:03:01 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so6357443yxt.5
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 04:03:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>

Hi all,

a few patches to enable sparse IRQ numbering on OMAP.
Also a few cleanups to arch/arm/Kconfig.

for convenience patches are also available from [1]:

[1] git://gitorious.org/usb/usb.git irq

Felipe Balbi (4):
  arm: omap: gpio: don't access irq_desc array directly
  arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
  arm: Kconfig: remove duplicated SPARSE_IRQ entry
  arm: Kconfig: allow OMAP to use sparse IRQ numbering

 arch/arm/Kconfig          |   22 ++++------------------
 arch/arm/plat-omap/gpio.c |   10 +++++++---
 2 files changed, 11 insertions(+), 21 deletions(-)

-- 
1.7.3.4.598.g85356

