From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH 0/2] Remove omap serial tags
Date: Fri, 07 Aug 2009 08:16:37 +0300
Message-ID: <20090807051516.4787.36125.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:47787 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZHGF0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 01:26:14 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 61BF6C7CA7
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 08:16:38 +0300 (EEST)
Received: from [127.0.1.1] (a91-155-131-184.elisa-laajakaista.fi [91.155.131.184])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 52E4D27D88
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 08:16:37 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here are patches which remove OMAP_TAG_SERIAL_CONSOLE and
OMAP_TAG_UART. The patches are based on linus' tree commit 90bc1a658.
If I need to rebase it some other tree, please let me know.

Please review.

---

Kalle Valo (2):
      OMAP: remove OMAP_TAG_UART
      OMAP: remove OMAP_TAG_SERIAL_CONSOLE


 arch/arm/mach-omap1/board-ams-delta.c    |    5 +--
 arch/arm/mach-omap1/board-fsample.c      |    5 +--
 arch/arm/mach-omap1/board-generic.c      |    5 +--
 arch/arm/mach-omap1/board-h2.c           |    5 +--
 arch/arm/mach-omap1/board-h3.c           |    5 +--
 arch/arm/mach-omap1/board-innovator.c    |    5 +--
 arch/arm/mach-omap1/board-nokia770.c     |    5 +++
 arch/arm/mach-omap1/board-osk.c          |    5 +--
 arch/arm/mach-omap1/board-palmte.c       |    5 +--
 arch/arm/mach-omap1/board-palmtt.c       |    5 +--
 arch/arm/mach-omap1/board-palmz71.c      |    5 +--
 arch/arm/mach-omap1/board-perseus2.c     |    5 +--
 arch/arm/mach-omap1/board-sx1.c          |    5 +--
 arch/arm/mach-omap1/board-voiceblue.c    |    5 +--
 arch/arm/mach-omap1/serial.c             |    8 ++---
 arch/arm/mach-omap2/board-2430sdp.c      |    5 +--
 arch/arm/mach-omap2/board-3430sdp.c      |    5 +--
 arch/arm/mach-omap2/board-4430sdp.c      |    5 +--
 arch/arm/mach-omap2/board-apollon.c      |    5 +--
 arch/arm/mach-omap2/board-generic.c      |    5 +--
 arch/arm/mach-omap2/board-h4.c           |    5 +--
 arch/arm/mach-omap2/board-ldp.c          |    5 +--
 arch/arm/mach-omap2/board-omap3beagle.c  |    5 +--
 arch/arm/mach-omap2/board-omap3evm.c     |    5 +--
 arch/arm/mach-omap2/board-omap3pandora.c |    5 +--
 arch/arm/mach-omap2/board-overo.c        |    5 +--
 arch/arm/mach-omap2/board-rx51.c         |    5 +--
 arch/arm/mach-omap2/board-zoom2.c        |    5 +--
 arch/arm/mach-omap2/serial.c             |    9 ++----
 arch/arm/plat-omap/common.c              |   44 ------------------------------
 arch/arm/plat-omap/include/mach/board.h  |    4 +--
 arch/arm/plat-omap/include/mach/serial.h |    4 ++-
 32 files changed, 66 insertions(+), 138 deletions(-)

