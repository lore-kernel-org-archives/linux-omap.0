From: Matt Porter <mporter@ti.com>
Subject: [PATCH 0/2] omap: fix omap2plus defaults for am35xx parts
Date: Thu,  9 Feb 2012 15:16:24 -0500
Message-ID: <1328818586-7104-1-git-send-email-mporter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34447 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab2BIUQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 15:16:29 -0500
Received: by iacb35 with SMTP id b35so2991128iac.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 12:16:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

This series enables all current am35xx boards and the on-chip Ethernet
driver in omap2plus_defconfig. It will help users of these boards to
have a working defconfig out of the box.

Matt Porter (2):
  omap: enable davinci_emac in omap2plus_defconfig for am35xx
  omap: build am3517crane board support by default

 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/Kconfig          |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

-- 
1.7.5.4

