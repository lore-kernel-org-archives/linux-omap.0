From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 0/7] OMAP: mailbox: removing static declarations
Date: Fri, 24 Jun 2011 20:17:36 -0500
Message-ID: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50836 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751588Ab1FYBSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 21:18:09 -0400
Received: by mail-yx0-f173.google.com with SMTP id 7so1688341yxs.4
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 18:18:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi,

This is the first attempt in making the omap mailbox framework generic
enough to support other mailbox drivers, in this series the way the mailbox
are defined and registered is changed to support requests of mailboxes through
an id. So far, the mailbox static declarations have been removed allowing
a dynamic mailbox configuration.

The next steps would involve removing omap references in the code and omap
specific fields (like "type" embedded in the operations structure) along with
a trivial cleanup.

The end goal would be moving the mailbox driver into drivers folder and also
converting other mailbox drivers to reuse this code, the first candidate being
ux-500 mailbox driver (arch/arm/mach-ux500/mbox-db5500.c).

Tested using one patch on top of Kevin Hilman mailbox loopback test, can be
found at: https://gitorious.org/~or.rmz/omap-test/mbox-test-clone

If accepted patches 5 to 7 should be a single patch, to avoid compilation issues.

I'll appreciate any comments or suggestions.

Omar Ramirez Luna (7):
  OMAP2+: hwmod_data: define number of mailboxes
  OMAP2+: devices: get the number of supported mailboxes
  OMAP: mailbox: use OMAP's naming convention for devices
  OMAP: mailbox: move framework functions under header file
  OMAP: mailbox: implement dynamic mailbox configuration
  OMAP1: mailbox: adapt to dynamic mailbox requests
  OMAP2+: mailbox: remove mailbox static declarations

 arch/arm/mach-omap1/mailbox.c              |   94 +++++----
 arch/arm/mach-omap2/devices.c              |    8 +-
 arch/arm/mach-omap2/mailbox.c              |  212 +++++---------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 +
 arch/arm/plat-omap/include/plat/mailbox.h  |   62 +++----
 arch/arm/plat-omap/mailbox.c               |  298 ++++++++++++++++++----------
 9 files changed, 364 insertions(+), 334 deletions(-)

Regards,

Omar
