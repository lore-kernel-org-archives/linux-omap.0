From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 0/10] omap mailbox driver update with omap3 support
Date: Tue, 25 Nov 2008 11:39:48 +0200
Message-ID: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34862 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYKYJkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:40:20 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9e175029701
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:40:18 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAP9dx9s001529
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:39:59 +0200
Received: from doyu by oreo.research.nokia.com with local (Exim 4.69)
	(envelope-from <doyu@nokia.com>)
	id 1L4uOk-0003We-VX
	for linux-omap@vger.kernel.org; Tue, 25 Nov 2008 11:39:58 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The followin patches are mainly for updating the mailbox driver with
omap3 support.

If there's no problem, please merge them into l-o.

The following changes since commit 3b7de4be879f1f4f55ae59882a5cbd80f6dcf0f0:
  Paul Walmsley (1):
        OMAP3 clock: disable DPLL autoidle while waiting for DPLL to lock

are available in the git repository at:

  http://git.gitorious.org/lk/mainline.git mailbox

Hiroshi DOYU (10):
      omap mailbox: cleanup omap2 register definition with macro
      omap mailbox: add initial omap3 support
      omap mailbox: print hardware revision at startup
      omap mailbox: fix empty struct device for omap_mbox
      omap mailbox: fix empty struct device for omap1
      omap mailbox: fix empty struct device for omap2
      omap mailbox: add save_/restore_ctx() for PM
      omap mailbox: move mailbox.h into mailbox.c
      omap mailbox: convert sequence bit checking to module paramter
      omap mailbox: remove unnecessary header file inclusion

 arch/arm/mach-omap1/devices.c              |    2 +-
 arch/arm/mach-omap1/mailbox.c              |   31 +++--
 arch/arm/mach-omap2/devices.c              |   26 +++-
 arch/arm/mach-omap2/mailbox.c              |  178 +++++++++++++++++-----------
 arch/arm/plat-omap/Kconfig                 |    2 +-
 arch/arm/plat-omap/include/mach/irqs.h     |    1 +
 arch/arm/plat-omap/include/mach/mailbox.h  |   10 ++-
 arch/arm/plat-omap/include/mach/omap34xx.h |    2 +-
 arch/arm/plat-omap/mailbox.c               |  170 ++++++++++++++++++++------
 arch/arm/plat-omap/mailbox.h               |  100 ----------------
 10 files changed, 288 insertions(+), 234 deletions(-)
 delete mode 100644 arch/arm/plat-omap/mailbox.h


