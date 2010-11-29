From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v5 0/4] OMAP: mailbox: fixes and enhancements
Date: Mon, 29 Nov 2010 14:24:10 -0600
Message-ID: <1291062254-9057-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab0K2UWJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 15:22:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Charulatha Varadarajan <charu@ti.com>, Omar Ramirez <omar.ramirez@ti.com>, Fernando Guzman <fernando.lugo@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Here is the revised set taking into account comments received on previous
patch set
========================

- Dropped the "OMAP: mailbox: fix rx interrupt disable in omap4" patch. This
  patch will be sent along with mailbox hwmod changes.
- Fixed the typo kifo to kfifo in "OMAP: mailbox: send message in process
  context" patch.

References:
http://marc.info/?l=linux-omap&m=129069379825760&w=2
http://marc.info/?l=linux-omap&m=129060518315342&w=2

The previous versions of this patch set can be found here
=======================
http://www.spinics.net/lists/linux-omap/msg40714.html
http://www.spinics.net/lists/arm-kernel/msg104544.html
http://www.spinics.net/lists/linux-omap/msg39988.html
http://www.spinics.net/lists/linux-omap/msg39931.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html

Fernando Guzman Lugo (1):
  OMAP: mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (3):
  OMAP: mailbox: fix checkpatch warnings
  OMAP: mailbox: send message in process context
  OMAP: mailbox: add notification support for multiple readers

 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/mailbox.c              |  130 +++++++++++++++++------------
 2 files changed, 81 insertions(+), 57 deletions(-)

