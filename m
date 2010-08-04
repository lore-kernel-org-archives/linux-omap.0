From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [GIT PULL] omap mailbox: for-next for v2.6.35
Date: Wed, 04 Aug 2010 15:57:13 +0300 (EEST)
Message-ID: <20100804.155713.186330427.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32419 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738Ab0HDM5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 08:57:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

The following changes since commit 9fe6206f400646a2322096b56c59891d530e8d51:

  Linux 2.6.35 (2010-08-01 15:11:14 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git v2.6.35-omap-mailbox-for-next

Felipe Contreras (13):
      omap: mailbox: trivial cleanups
      omap: mailbox: reorganize structures
      omap: mailbox: 2420 should be detected at run-time
      omap: mailbox: use correct config for omap1
      omap: mailbox: update omap1 probing
      omap: mailbox: don't export unecessary symbols
      omap: mailbox: remove unecessary fields
      omap: mailbox: add IRQ names
      omap: mailbox: reorganize registering
      omap: mailbox: simplify omap_mbox_register()
      omap: mailbox: only compile for configured archs
      omap: mailbox: standarize on 'omap-mailbox'
      omap: mailbox: reorganize headers

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

 arch/arm/mach-omap1/devices.c             |   11 +-
 arch/arm/mach-omap1/mailbox.c             |   55 +++----
 arch/arm/mach-omap2/devices.c             |    6 +-
 arch/arm/mach-omap2/mailbox.c             |  182 ++++++++++------------
 arch/arm/plat-omap/Kconfig                |    9 +
 arch/arm/plat-omap/include/plat/mailbox.h |   20 +--
 arch/arm/plat-omap/mailbox.c              |  248 ++++++++++++++---------------
 7 files changed, 246 insertions(+), 285 deletions(-)
