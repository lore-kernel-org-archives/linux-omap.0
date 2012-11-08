From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] pinctrl: pinctrl-single: Fix the pins debug output
Date: Thu, 8 Nov 2012 18:44:00 +0100
Message-ID: <509BEF60.1030805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45939 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab2KHRoL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 12:44:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hilman >> Kevin Hilman" <khilman@ti.com>

The offset parameter is in fact the pin index. The printed
value is then most of the time wrong.
Multiply that value by the width to get the proper offset.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---

Hi Tony,

I guess that should probably go for 3.7-rc.

Regards,
Benoit

 drivers/pinctrl/pinctrl-single.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 726a729..aeca3bd 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -251,7 +251,7 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	val = pcs->read(pcs->base + offset);
+	val = pcs->read(pcs->base + offset * (pcs->width / BITS_PER_BYTE));
 	val &= pcs->fmask;
 
 	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
-- 
1.7.0.4
