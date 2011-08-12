From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH v2 1/4] mfd: twl4030-madc: copy the device pointer
Date: Thu, 11 Aug 2011 22:33:12 -0500
Message-ID: <1313119995-15382-2-git-send-email-kyle@kylemanna.com>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
 <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:44876 "EHLO
	homiemail-a72.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752751Ab1HLDeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 23:34:01 -0400
In-Reply-To: <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kyle Manna <kyle@kylemanna.com>

Worst case this fixes the following error:
[   72.086212] (NULL device *): conversion timeout!

Best case it prevents a crash

Signed-off-by: Kyle Manna <kyle@kylemanna.com>
---
 drivers/mfd/twl4030-madc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index b5d598c..cb44b53 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -706,6 +706,8 @@ static int __devinit twl4030_madc_probe(struct platform_device *pdev)
 	if (!madc)
 		return -ENOMEM;
 
+	madc->dev = &pdev->dev;
+
 	/*
 	 * Phoenix provides 2 interrupt lines. The first one is connected to
 	 * the OMAP. The other one can be connected to the other processor such
-- 
1.7.4.1

