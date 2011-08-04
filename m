From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v2 0/2] I2C: OMAP: misc. PM-related cleanups
Date: Thu,  4 Aug 2011 07:57:34 -0700
Message-ID: <1312469856-13276-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57982 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560Ab1HDO5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 10:57:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Do some PM-related cleanup on this driver and make the runtime PM
usage more standard.

Series applies on Andy's I2C cleanup series (for_3.1/i2c-andy-2 branch
in my tree[1]) plus the misc. i2c fixes queued for v3.1-rc
(for_3.1/i2c-fixes branch) and are available in the
for_3.2/i2c-cleanup branch of my tree.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin Hilman (2):
  I2C: OMAP: remove unneccesary use of pdev
  I2C: OMAP: remove dev->idle, use usage counting provided by runtime
    PM

 drivers/i2c/busses/i2c-omap.c |   77 +++++++++++++++++++++++-----------------
 1 files changed, 44 insertions(+), 33 deletions(-)

-- 
1.7.6

