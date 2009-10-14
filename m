From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] omap: Fix Unlikely(x) < y
Date: Tue, 13 Oct 2009 17:13:41 -0700
Message-ID: <20091014001341.6116.47622.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58760 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761580AbZJNAOX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 20:14:23 -0400
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

From: Roel Kluin <roel.kluin@gmail.com>

The closing parenthesis was not on the right location.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 71ebd7f..7c345b7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -373,7 +373,7 @@ static inline int gpio_valid(int gpio)
 
 static int check_gpio(int gpio)
 {
-	if (unlikely(gpio_valid(gpio)) < 0) {
+	if (unlikely(gpio_valid(gpio) < 0)) {
 		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
 		dump_stack();
 		return -1;

