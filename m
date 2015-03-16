From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] mfd: twl6040: match wait_for_completion_timeout return type
Date: Mon, 16 Mar 2015 04:17:02 -0400
Message-ID: <1426493822-10331-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:47828 "EHLO www.osadl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbbCPIVg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 04:21:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

Return type of wait_for_completion_timeout is unsigned long not int. As
time_left is exclusively used for wait_for_completion_timeout here its
type is simply changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was compile tested with x86_64_defconfig + CONFIG_TWL6040_CORE=y

Patch is against 4.0-rc3 (localversion-next is -next-20150316)

 drivers/mfd/twl6040.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f71ee3d..d6f9761 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -259,7 +259,7 @@ static irqreturn_t twl6040_thint_handler(int irq, void *data)
 
 static int twl6040_power_up_automatic(struct twl6040 *twl6040)
 {
-	int time_left;
+	unsigned long time_left;
 
 	gpio_set_value(twl6040->audpwron, 1);
 
-- 
1.7.10.4

