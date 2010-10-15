From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/7] omap:mailbox-enhancements and fixes
Date: Thu, 14 Oct 2010 20:13:15 -0500
Message-ID: <1287105202-31861-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43301 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653Ab0JOBNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 21:13:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>

Resending the patch set copying linux arm mailing list.
please ignore the previous patchset.
[http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37214.html]

This patch set includes following mailbox enhancements and fixes.
        
- Fix in RX interrupt disable mechanism for OMAP4
- Fix checkpatch warnings
- Resolve multiple receiver problem in OMAP4 where there is
  only one interrupt line shared between Ducati and Tesla.
- Protect the Mailbox's internal callback function pointer from being
  set directly by Users. Added option for multiple listeners on a
  mailbox instance.
- Send Mailbox message in Process context to avoid the latency
  involved in scheduling Tasklet for every Mailbox message. Schedule
  Tasklet only when the mailbox fifo is full
- There is no explicit mailbox configuration register to enable mailbox
  clocks. Define a dummy clock for mailbox to avoid addign cpu check for
  omap4 in mailbox driver.
- The patch from Fernando was sent to LO, but looks like it
  didn't get merged, resending the patch after revising and rebasing.
  https://patchwork.kernel.org/patch/105650/

Fernando Guzman Lugo (1):
  mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (6):
  omap:mailbox: fix rx interrupt disable in omap4
  omap:mailbox-fix checkpatch warnings
  omap:mailbox-send message in process context
  omap:mailbox-resolve multiple receiver problem
  omap:mailbox-add notification support for multiple readers
  omap:clocks44x-add dummy clock for mailbox

 arch/arm/mach-omap2/clock44xx_data.c      |    1 +
 arch/arm/mach-omap2/mailbox.c             |    5 +-
 arch/arm/plat-omap/include/plat/mailbox.h |   10 ++-
 arch/arm/plat-omap/mailbox.c              |  148 +++++++++++++++++------------
 4 files changed, 98 insertions(+), 66 deletions(-)

