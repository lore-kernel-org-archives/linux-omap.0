From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 0/2] OMAP1: drop AMS_DELTA_FIQ config option
Date: Fri, 5 Nov 2010 01:26:00 +0100
Message-ID: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:60870 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab0KEA0f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Nov 2010 20:26:35 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jkrzyszt@tis.icnet.pl, Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This set of patches removes a config option that was used to select a FIQ 
handler to be build for Amstrad Delta, as required by the on-board serio 
interface driver. Not having any problem reports received since it was 
introduced in 2.6.35, the FIQ handler can now be built by default, thus 
reqiring no extra config option.

1/2: serio: Amstrad Delta: no longer select AMS_DELTA_FIQ from serio Kconfig
2/2: OMAP1: Amstrad Delta: always build with FIQ handler linked in

 arch/arm/mach-omap1/Kconfig           |   11 +----------
 arch/arm/mach-omap1/Makefile          |    4 ++--
 arch/arm/mach-omap1/board-ams-delta.c |    2 --
 drivers/input/serio/Kconfig           |    1 -
 4 files changed, 3 insertions(+), 15 deletions(-)
