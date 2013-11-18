From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] input: touchscreen: ti_am335x_tsc: warn about incorrect spelling
Date: Mon, 18 Nov 2013 09:29:01 -0600
Message-ID: <1384788541-16338-1-git-send-email-balbi@ti.com>
References: <20131118114029.GD30853@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab3KRP3l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 10:29:41 -0500
In-Reply-To: <20131118114029.GD30853@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dmitry.torokhov@gmail.com, rob.herring@calxeda.com, Pawel.Moll@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>

In the hopes that people run new kernels on
their devices, let's add a warning message
asking users to have their DTS file fixed.

The goal is that by Linux 4.0 we will be
able to remove support for the bogus version
of our touchscreen's DTS.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Here you go, I've added your Suggested-by Mark,
if you wish I can remove or change to something
else.

cheers

 drivers/input/touchscreen/ti_am335x_tsc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index b61df9d..91302cd 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -354,9 +354,12 @@ static int titsc_parse_dt(struct platform_device *pdev,
 	 */
 	err = of_property_read_u32(node, "ti,coordinate-readouts",
 			&ts_dev->coordinate_readouts);
-	if (err < 0)
+	if (err < 0) {
+		dev_warn(&pdev->dev, "please use 'ti,coordinate-readouts' instead\n");
 		err = of_property_read_u32(node, "ti,coordiante-readouts",
 				&ts_dev->coordinate_readouts);
+	}
+
 	if (err < 0)
 		return err;
 
-- 
1.8.4.GIT

