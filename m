From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 00/10] omap mailbox: Paches for -next
Date: Thu,  3 Jun 2010 09:34:08 +0300
Message-ID: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35464 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933389Ab0FCGf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:35:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi,

The following patches are for -next for omap mailbox module.

Fernando Guzman Lugo (4):
  Mailbox: free mailbox interrupt before freeing blk queue
  Mailbox: flush pending deferred works before freeing blk queue
  Mailbox: Check valid registered callback before calling
  Mailbox: disable mailbox interrupt when request queue

Hiroshi DOYU (2):
  Mailbox: new mutext lock for h/w mailbox configuration
  omap mailbox: Set a device in logical mbox instance for traceability

Ohad Ben-Cohen (4):
  omap: mailbox: convert rwlocks to spinlock
  omap: mailbox cleanup: split MODULE_AUTHOR line
  omap: mailbox: remove (un)likely macros from cold paths
  omap: mailbox: convert block api to kfifo

 arch/arm/mach-omap2/mailbox.c             |    3 +-
 arch/arm/plat-omap/Kconfig                |    9 ++
 arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
 arch/arm/plat-omap/mailbox.c              |  182 ++++++++++++++++-------------
 4 files changed, 111 insertions(+), 87 deletions(-)

