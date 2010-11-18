From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v3 0/5] OMAP: mailbox: enhancements and fixes
Date: Thu, 18 Nov 2010 13:15:37 -0600
Message-ID: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab0KRTNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 14:13:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Hari Kanigeri <h-kanigeri2@ti.com>

Sending the patch set by seperating the clock related patch seperated
out based on Paul Walmsey's comment.
http://www.spinics.net/lists/arm-kernel/msg103692.html
The clock patch will be sent out as a seperate patch.

The previous versions of this patch set can be found here
http://www.spinics.net/lists/linux-omap/msg39988.html
http://www.spinics.net/lists/linux-omap/msg39931.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html

Fernando Guzman Lugo (1):
  OMAP: mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (4):
  OMAP: mailbox: fix rx interrupt disable in omap4
  OMAP: mailbox: fix checkpatch warnings
  OMAP: mailbox: send message in process context
  OMAP: mailbox: add notification support for multiple readers

 arch/arm/mach-omap2/mailbox.c             |    5 +-
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/mailbox.c              |  127 +++++++++++++++++------------
 3 files changed, 82 insertions(+), 58 deletions(-)

