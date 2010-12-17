From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] omap: rx51: Remove extra tlv320aic3x.h inclusion
Date: Fri, 17 Dec 2010 21:18:24 +0200
Message-ID: <1292613505-10113-2-git-send-email-jhnikula@gmail.com>
References: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:53601 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0LQTQx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 14:16:53 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so521061ewy.4
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 11:16:52 -0800 (PST)
In-Reply-To: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Remove second tlv320aic3x.h inclusion that came along the commit f0fba2a
"ASoC: multi-component - ASoC Multi-Component Support".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
Clearly for 2.6.38 as harmless issue.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index cde6847..6114e47 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,7 +23,6 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
-#include <sound/tlv320aic3x.h>
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
-- 
1.7.2.3

