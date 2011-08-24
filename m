From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] I2C: OMAP: misc. cleanup for v3.2
Date: Tue, 23 Aug 2011 17:10:36 -0700
Message-ID: <871uwbhdoj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54258 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755344Ab1HXAKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 20:10:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-i2c@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Ben,

Here's one more I2C cleanup series for v3.2.

It applies on top of my for_3.2/i2c-fixes branch just submitted.

Please pull into your tree for linux-next.

Thanks,

Kevin


The following changes since commit f3cb1e11c4e54f4dc7e60f9513d43ffa0bbebc25:

  Revert "i2c-omap: fix static suspend vs. runtime suspend" (2011-08-23 10:51:58 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/i2c-cleanup

Kevin Hilman (3):
      I2C: OMAP: remove unneccesary use of pdev
      I2C: OMAP: remove dev->idle, use usage counting provided by runtime PM
      I2C: OMAP: remove unused function pointers from pdata

 drivers/i2c/busses/i2c-omap.c |   77 +++++++++++++++++++++++-----------------
 include/linux/i2c-omap.h      |    3 --
 2 files changed, 44 insertions(+), 36 deletions(-)
