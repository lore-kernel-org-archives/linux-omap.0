From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 1/3] [OMAPZOOM] INPUT: Add flag to allow gpio-key input auto repeat.
Date: Mon, 20 Oct 2008 14:46:04 -0500
Message-ID: <200810201446.04719.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34776 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYJTTqL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 15:46:11 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9KJk5dO005199
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 14:46:10 -0500
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m9KJk4J3025082
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 14:46:04 -0500 (CDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds a flag to the gpio-keys driver to enable the input subsystems
auto repeat function. Feature is turned on in board file.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 drivers/input/keyboard/gpio_keys.c |    4 ++++
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c 
b/drivers/input/keyboard/gpio_keys.c
index ec96b36..935d2e3 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -108,6 +108,10 @@ static int __devinit gpio_keys_probe(struct 
platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		set_bit(EV_REP, input->evbit);
+
 	ddata->input = input;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ec6ecd7..1289fa7 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -15,6 +15,7 @@ struct gpio_keys_button {
 struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
+	unsigned int rep:1;		/* enable input subsystem auto repeat */
 };
 
 #endif
-- 
1.5.4.1

