From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/6] [v2] omap:mailbox-enhancements and fixes
Date: Wed, 10 Nov 2010 06:45:15 -0600
Message-ID: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36423 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809Ab0KJMpL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 07:45:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Hari Kanigeri <h-kanigeri2@ti.com>

Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial patch
set.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html

The patch set addresses the following review comments from Rene and Omar.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37626.html
https://patchwork.kernel.org/patch/255091/
https://patchwork.kernel.org/patch/255081/

Following patches are changed because of above review comments:
omap:mailbox-send message in process context
omap:mailbox-add notification support for multiple readers

Following patch is dropped from initial patch set
omap:mailbox-resolve multiple receiver problem

The patch set is tested on omap4 SDP board.

Fernando Guzman Lugo (1):
  mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (5):
  omap:mailbox: fix rx interrupt disable in omap4
  omap:mailbox-fix checkpatch warnings
  omap:mailbox-send message in process context
  omap:mailbox-add notification support for multiple readers
  omap:clocks44x-add dummy clock for mailbox

 arch/arm/mach-omap2/clock44xx_data.c      |    1 +
 arch/arm/mach-omap2/mailbox.c             |    5 +-
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/mailbox.c              |  127 +++++++++++++++++------------
 4 files changed, 83 insertions(+), 58 deletions(-)

