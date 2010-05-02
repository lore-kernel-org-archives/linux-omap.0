From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/8] omap: mailbox: split platform_driver
Date: Mon,  3 May 2010 02:59:50 +0300
Message-ID: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64079 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0ECAAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:00:16 -0400
Received: by bwz19 with SMTP id 19so1032679bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:00:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

It seems it's not possible to compile 'mailbox_mach' as built-in due to
interdependencies.

This proposal tries to avoid mbox_register() in 'mach' and store all the
required information in platform_device data so that the 'plat' mailbox can do
the mbox_register().

Also, some other goodies such as cleanups, and true multi-omap support.

I tested these on a bleagleboard.

Felipe Contreras (8):
  omap: mailbox: trivial cleanups
  omap: mailbox: reorganize structures
  omap: mailbox: 2420 should be detected at run-time
  omap: mailbox: reorganize omap2 registering
  omap: mailbox: reorganize omap2 platform_device
  omap: mailbox: more more stuff to omap2_mbox_init
  omap: mailbox: split platform_driver
  omap: mailbox: always built-in omap2 platform data

 arch/arm/mach-omap2/Makefile              |    5 +-
 arch/arm/mach-omap2/devices.c             |   74 ---------
 arch/arm/mach-omap2/mailbox.c             |  237 +++++++++++++++--------------
 arch/arm/plat-omap/include/plat/mailbox.h |    5 +
 arch/arm/plat-omap/mailbox.c              |   45 +++++-
 5 files changed, 176 insertions(+), 190 deletions(-)

