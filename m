From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/6] arm: boot: dts: am437x-sk: DTS pinmux fixes
Date: Thu, 4 Dec 2014 11:01:53 -0600
Message-ID: <1417712519-4615-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36387 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaLDRCV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 12:02:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Here's a small series of non-critical fixes and improvements
for AM437x Starter Kit DTS.

Basically I'm removing unnecessary pulls and adding explicit
pinmux for a couple interfaces which were missing.

All patches tested on top of commit 1ca7c60 (Add linux-next
specific files for 20141204). Boot logs will be attached as
a reply here.

Felipe Balbi (6):
  arm: boot: dts: am437x-sk: remove internal pulls from QSPI
  arm: boot: dts: am437x-sk: add explicit MMC0 pinmux
  arm: boot: dts: am437x-sk: remove ethernet pulls
  arm: boot: dts: am437x-sk: add explicit pinmux for both USB instances
  arm: boot: dts: am437x-sk: remove internal i2c pullups
  arm: boot: dts: am437x-sk: remove DSS pulls

 arch/arm/boot/dts/am437x-sk-evm.dts | 150 +++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 64 deletions(-)

-- 
2.1.0.GIT

