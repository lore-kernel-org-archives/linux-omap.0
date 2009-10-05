From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/4] omap_udc fixes for omap7xx
Date: Mon, 5 Oct 2009 07:48:32 -0700
Message-ID: <6cb013310910050748o748d008ch60a85ef504029d9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:38789 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZJEOt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 10:49:28 -0400
Received: by gxk4 with SMTP id 4so3860971gxk.8
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 07:48:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The following four patches patch the OMAP UDC subsystem to allow
omap7xx-based systems to operate with USB in client mode.

Cory Maccarrone (4):
  [OMAP] Clocks: Add omap7xx-specific USB clock configuration
  [OMAP] omap_udc: Updates for omap7xx IRQs and config
  [OMAP] omap_udc: Add clocking and disable vbus sense for omap7xx
  [OMAP1] Make ARCH_OMAP850 select ARCH_OMAP_OTG

 arch/arm/mach-omap1/Kconfig   |    1 +
 arch/arm/mach-omap1/clock.c   |    3 ++-
 arch/arm/mach-omap1/clock.h   |   10 ++++++++++
 arch/arm/plat-omap/usb.c      |   20 ++++++++++++++------
 drivers/usb/gadget/omap_udc.c |   19 +++++++++++++++++--
 5 files changed, 44 insertions(+), 9 deletions(-)
