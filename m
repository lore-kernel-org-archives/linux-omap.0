From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [GIT PULL] omap mailbox: updates for 2.6.35
Date: Fri, 21 May 2010 16:39:52 +0300 (EEST)
Message-ID: <20100521.163952.116384006.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51909 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0EUNkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 09:40:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,

Here are the latest updates for omap mailbox modules.

The following changes since commit e40152ee1e1c7a63f4777791863215e3faa37a86:

  Linus 2.6.34 (2010-05-16 14:17:36 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git for-tony-mailbox

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
 arch/arm/plat-omap/mailbox.c              |  186 +++++++++++++++-------------
 4 files changed, 113 insertions(+), 89 deletions(-)
