From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/5] omap: mailbox: hwmod support and dependent cleanup patches
Date: Tue, 26 Oct 2010 16:52:59 -0500
Message-ID: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab0JZWDN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 18:03:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

HWMOD support for omap2 and omap3 chips, plus cleanups.

1. omap: mailbox: initial hwmod support for omap3
Changes were made to:
- Rebase to latest code.
- Detect the hwmod by filling prcm union for omap2, without
  this it was unable to build the hwmod at runtime.
- Replace magic number for defines.
- Use ioremap again instead of relying on the one made by hwmod,
  as noted in http://patchwork.kernel.org/patch/101661/

Tested on 3430 and 3630

2. omap: mailbox: initial hwmod support for omap2
Was only compiled tested!! Unfortunately I don't have the HW for it.

4. omap: mailbox: fix detection for previously supported chips
Original patch was using features framework, but when compiled as a module
it was breaking, this patch uses cpu_is_omap34xx macro instead.

This is meant as a short term solution until proper cleanup is done, as suggested in:

http://marc.info/?l=linux-arm-kernel&m=128534253231481&w=2

Felipe Contreras (2):
  omap: mailbox: initial hwmod support for omap3
  omap: mailbox: add omap_device latency information

Omar Ramirez Luna (4):
  omap: mailbox: initial hwmod support for omap2
  omap: mailbox: fix detection for previously supported chips
  omap: mailbox: remove unreachable return

 arch/arm/mach-omap2/devices.c              |  104 +++++++---------------------
 arch/arm/mach-omap2/mailbox.c              |   40 +++++-----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   55 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   54 ++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   54 ++++++++++++++
 arch/arm/plat-omap/include/plat/mailbox.h  |    6 ++
 6 files changed, 213 insertions(+), 100 deletions(-)

