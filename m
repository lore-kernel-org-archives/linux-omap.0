From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 24/27] cbus: tahvo: allocate tahvo-pwm child
Date: Thu, 13 Oct 2011 11:34:59 +0300
Message-ID: <1318494902-13093-24-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52020 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753920Ab1JMIf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:56 -0400
Received: by mail-bw0-f54.google.com with SMTP id zs8so1522315bkb.41
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:55 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

this will serve as a backlight driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 1540042..623dacb 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -301,6 +301,10 @@ static int tahvo_allocate_children(struct device *parent, int irq_base)
 	if (!child)
 		return -ENOMEM;
 
+	child = tahvo_allocate_child("tahvo-pwm", parent, -1);
+	if (!child)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
1.7.6.396.ge0613

