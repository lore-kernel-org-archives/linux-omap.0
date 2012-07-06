From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] gpio/omap: final fixes for v3.5
Date: Fri, 06 Jul 2012 16:38:22 -0700
Message-ID: <87vci08npt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:53612 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753008Ab2GFXiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 19:38:09 -0400
Received: by yenl1 with SMTP id l1so10453843yen.32
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 16:38:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Grant,

Here's a couple (hopefully) final OMAP GPIO fixes for v3.5-rc.

Thanks,

Kevin


The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/gpio-3

for you to fetch changes up to 7b86cef34afceeecf57d4d07f3cfab06f8b60b13:

  gpio/omap: fix invalid context restore of gpio bank-0 (2012-07-03 09:41:39 -0700)

----------------------------------------------------------------
Grazvydas Ignotas (1):
      gpio/omap: fix irq loss while in idle with debounce on

Jon Hunter (1):
      gpio/omap: fix invalid context restore of gpio bank-0

 drivers/gpio/gpio-omap.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)
