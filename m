From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/15] omap: mailbox: reorganize init
Date: Thu, 13 May 2010 20:47:21 +0300
Message-ID: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:11171 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0EMRsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2624632fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

The main purpose of this patch series is to be able to compile mach platform
data as built-in. Otherwise, client modules such as bridgedriver will load the
platform code, but not the mach code when mailbox is built as a module.

Unfortunately, there's no easy way to do that since plat and mach code are
deepely interrelated. So the first patches try to separate the mailbox
registering through a defined omap_mbox_platform_data.

Also, it's worth noting that mailboxes are not a one-to-one mapping to
resources; that is, some resources belong to multiple mboxes. So it's best to
think of mailboxes as fake devices. That is why custom platform_data is required.

Finally, a bunch of cleaning up is done in the very first patches, specially for
OMAP1.

The initial RFC included comments from Felipe Balbi, and this proposal includes
comments from Tony Lindgren.

Tested on OMAP3 (beagleboard), and compiled-tested for OMAP1.

Felipe Contreras (15):
  omap: mailbox: trivial cleanups
  omap: mailbox: reorganize structures
  omap: mailbox: 2420 should be detected at run-time
  omap: mailbox: use correct config for omap1
  omap: mailbox: update omap1 probing
  omap: mailbox: reorganize registering
  omap: mailbox: only compile for configured archs
  omap: mailbox: reorganize omap platform_device
  omap: mailbox: move more stuff to omap_mbox_init()
  omap: mailbox: trivial sync between omap1 and 2
  omap: mailbox: split platform driver
  omap: mailbox: always built-in platform data
  omap: mailbox: reorganize headers
  omap: mailbox: don't export unecessary symbols
  omap: mailbox: mark some resources as __initdata

 arch/arm/mach-omap1/Makefile              |    6 +-
 arch/arm/mach-omap1/devices.c             |   40 -----
 arch/arm/mach-omap1/mailbox.c             |  114 ++++++++-----
 arch/arm/mach-omap2/Makefile              |    5 +-
 arch/arm/mach-omap2/devices.c             |   74 --------
 arch/arm/mach-omap2/mailbox.c             |  259 ++++++++++++++++-------------
 arch/arm/plat-omap/include/plat/mailbox.h |    7 +-
 arch/arm/plat-omap/mailbox.c              |   53 +++++-
 8 files changed, 275 insertions(+), 283 deletions(-)

