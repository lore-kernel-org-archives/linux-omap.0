From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/6] ARM: OMAP4: core retention support
Date: Thu, 23 Feb 2012 15:21:54 +0200
Message-ID: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49771 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab2BWNWQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:22:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set adds core retention support on top of mainline. The set
also adds IO CHAIN wakeup capability for OMAP4, which is a nice feature
to have while trying suspend / resume with CSWR as it is quite difficult
to wake up the device without this.

Patch 6 might cause some stir, but this is needed as omap4 PRCM chain
handler currently does not work without SPARSE_IRQ. Enabling the
SPARSE_IRQ causes a WARN from gic during boot for omap4, and attempting
to fix this creates some spam from interrupt handling code which seems to
originate from GPMC/GPIO. Also, omap3 boot breaks completely,
thus it is impossible to enable this option as of now.

Tested on OMAP4 blaze board, with OMAP4430 EMU chip. Suspend / resume
works nicely, and wakeup with UART3 works. The powerdomain state info
under pm-debug appears to be somewhat bogus right after boot, but fixes
itself during suspend. This should be addressed separately. Also
verified that suspend / resume with OMAP3 beagle is okay.

-Tero

