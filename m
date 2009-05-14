From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] ARM: OMAP3: Fix number of GPIO lines for 34xx
Date: Thu, 14 May 2009 10:51:16 -0700
Message-ID: <20090514175116.12080.12871.stgit@localhost>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53549 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbZENRvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:51:25 -0400
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Tom Rix <Tom.Rix@windriver.com>

From: Tony Lindgren <Pandita>

As per 3430 TRM, there are 6 banks [0 to 191]

Signed-off-by: Tom Rix <Tom.Rix@windriver.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 17d7afe..ee0b21f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -307,7 +307,7 @@ static inline int gpio_valid(int gpio)
 		return 0;
 	if (cpu_is_omap24xx() && gpio < 128)
 		return 0;
-	if (cpu_is_omap34xx() && gpio < 160)
+	if (cpu_is_omap34xx() && gpio < 192)
 		return 0;
 	return -1;
 }

