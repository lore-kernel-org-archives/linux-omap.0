From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Extend gpio label column width in omap_gpio debugfs file
Date: Wed, 12 Nov 2008 10:02:39 +0200
Message-ID: <1226476959-17093-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23655 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbYKLIDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 03:03:19 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAC82lpx021188
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 10:03:17 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

There are already various drivers having bigger label than 10 bytes. Most
of them fit well under 20 bytes but make column width exact so that
oversized labels don't mess up output alignment.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8bb4542..821100d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1820,7 +1820,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 				seq_printf(s, "MPUIO %2d ", j);
 			else
 				seq_printf(s, "GPIO %3d ", gpio);
-			seq_printf(s, "(%10s): %s %s",
+			seq_printf(s, "(%-20.20s): %s %s",
 					label,
 					is_in ? "in " : "out",
 					value ? "hi"  : "lo");
-- 
1.5.6.5

