From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] Trivial series
Date: Tue, 19 Oct 2010 10:30:53 +0300
Message-ID: <1287473455-25773-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36880 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0JSHbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:31:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Hi Tony,

found these while compiling n770_defconfig. Probably
worth sending to mainline anyway ?

Felipe Balbi (2):
  arm: omap1: devices: need to return with a value
  arm: omap1: remove unused variables

 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |    1 -
 arch/arm/mach-omap1/pm_bus.c  |    1 -
 3 files changed, 1 insertions(+), 3 deletions(-)

-- 
1.7.3.rc0.35.g8ac8c

