From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] gpio/omap: minor cleanups for v3.2
Date: Tue, 06 Sep 2011 15:57:42 -0700
Message-ID: <8739g91dp5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:51725 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851Ab1IFW5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 18:57:49 -0400
Received: by mail-gx0-f182.google.com with SMTP id 28so4802534gxk.41
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 15:57:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Grant,

Please pull the following OMAP GPIO cleanups for v3.2.

Just a heads up: we're also working on another large series of cleanup
for this driver that we'll be trying to merge for v3.2.

Kevin


The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://gitorious.org/khilman/linux-omap-pm.git for_3.2/gpio-cleanup

Kevin Hilman (1):
      gpio/omap: replace MOD_REG_BIT macro with static inline

Todd Poynor (1):
      gpio/omap: check return value from irq_alloc_generic_chip

 drivers/gpio/gpio-omap.c |   59 ++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 25 deletions(-)
