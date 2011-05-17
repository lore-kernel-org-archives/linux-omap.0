From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] I2C: OMAP: clean up runtime PM usage
Date: Tue, 17 May 2011 16:31:36 +0200
Message-ID: <1305642698-15338-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47557 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754769Ab1EQObo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 10:31:44 -0400
Received: by mail-wy0-f179.google.com with SMTP id 36so539686wyg.24
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 07:31:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Current usage of runtime PM is not quite correct.  The actual
idle/unidle of the I2C hardware should not happen until the runtime PM
callbacks are called.

Clean up by using runtime PM callbacks to call idle/unidle functions
and also replace usage of dev->idle check by pm_runtime_suspended() check.

Kevin Hilman (2):
  I2C: OMAP: remove unneccesary use of pdev
  I2C: OMAP: remove dev->idle, use usage counting provided by runtime
    PM

 drivers/i2c/busses/i2c-omap.c |   70 +++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 34 deletions(-)

-- 
1.7.3.4

