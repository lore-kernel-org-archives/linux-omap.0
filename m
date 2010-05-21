From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 00/17] omap: mailbox:
Date: Sat, 22 May 2010 00:44:32 +0300
Message-ID: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0EUVoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:44:55 -0400
Received: by bwz7 with SMTP id 7so202277bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:44:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Hi,

The main purpose of this patch series is to be able to compile mailbox
mach platform data as built-in.

[no changes since the last v2, just rebased on top of the latest
git://gitorious.org/~doyu/lk/mainline.git for-tony-mailbox]

Currently, the code is split into three places:
1) mach-omapX/devices.c: for platform_device_register() the resources
2) mach-omapX/mailbox.c: do platform_driver_register(), fetch the resources,
   and register logical mailboxes with omap_mbox_register()
3) plat-omap/mailbox.c: implement omap_mbox_register() to add the mbox
   to an internal linked list (static struct omap_mbox *mboxes)

So, obviously 1) is always built-in, but 2) can't be because of the
dependency of omap_mbox_register(), which is in 3) and cannot be taken
out.

Users of mailbox will load 3) due to omap_mbox_get(), but not 2),
therefore, no mailboxes will be registered.

Hiroshi DOYU claims that udev would handle the loading of 2), but that
doesn't help machines without udev.

The easiest way to solve this problem for everybody is to always built-in
2), which this patch attempts.


This approach brings a number of reorganizing options:
a) mach-omapX/mailbox.c can do platform_device_register() directly,
   removing the need to do so in mach-omapX/devices.c
b) since omap_mbox_register()/omap_mbox_unregister() are used only in
   plat-omap/mailbox.c, there's no need to export them

Another option that I haven't explored yet:
c) plat-omap/mailbox.c can remove all the custom linked list code in
   order to dynamically register and unregister mailboxes: the list
   would be statically defined

In order to achieve this, the dependency on omap_mbox_register() should be
removed, and in order to do that, I'm adding a custom platform_data that
stores the mailboxes.

Also, if you are wondering if each mailbox should be a
platform_device... No; mailboxes are not a one-to-one mapping to
resources; that is, some resources belong to multiple mboxes. So it's
best to think of mailboxes as logic (fake) devices. That is why custom
platform_data is required in order to define them.

Finally, a bunch of cleaning up is done in the very first patches, specially for
OMAP1.

The initial RFC included comments from Felipe Balbi, and this proposal includes
comments from Tony Lindgren.

v2:
 * Rebased on top of Hiroshi's v2.6.34-rc7.mailbox
 * A bit more extra cleanups

Tested on OMAP3 (beagleboard), and compiled-tested for OMAP1.

Felipe Contreras (17):
  omap: mailbox: trivial whitespace cleanups
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
  omap: mailbox: don't export register/unregister

 arch/arm/mach-omap1/Makefile              |    6 +-
 arch/arm/mach-omap1/devices.c             |   40 -----
 arch/arm/mach-omap1/mailbox.c             |  118 ++++++++------
 arch/arm/mach-omap2/Makefile              |    5 +-
 arch/arm/mach-omap2/devices.c             |   92 -----------
 arch/arm/mach-omap2/mailbox.c             |  254 ++++++++++++++++-------------
 arch/arm/plat-omap/include/plat/mailbox.h |   10 +-
 arch/arm/plat-omap/mailbox.c              |   89 +++++++---
 8 files changed, 290 insertions(+), 324 deletions(-)

