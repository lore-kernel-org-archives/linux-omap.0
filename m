From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: [PATCH] OMAP: Store switch state for OUTPUT gpio-switches
Date: Mon, 30 Jun 2008 16:32:54 +0300
Message-ID: <1214832774-24114-1-git-send-email-mikko.k.ylinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21258 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758322AbYF3NdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 09:33:00 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5UDWeJV022857
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 16:32:58 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Mikko Ylinen <mikko.k.ylinen@nokia.com>
---
 arch/arm/plat-omap/gpio-switch.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index cd96c00..7a61d0e 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -131,11 +131,12 @@ static ssize_t gpio_sw_state_store(struct device *dev,
 
 	str = get_sw_str(sw);
 	if (strcmp(state, str[0]) == 0)
-		enable = 0;
+		sw->state = enable = 0;
 	else if (strcmp(state, str[1]) == 0)
-		enable = 1;
+		sw->state = enable = 1;
 	else
 		return -EINVAL;
+
 	if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
 		enable = !enable;
 	omap_set_gpio_dataout(sw->gpio, enable);
-- 
1.5.5.2

