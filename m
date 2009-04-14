From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] ARM: OMAP3: remove duplicated #include
Date: Tue, 14 Apr 2009 14:59:46 -0700
Message-ID: <20090414215946.9878.13276.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53968 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZDNV7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:59:49 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

From: Huang Weiyi <weiyi.huang@gmail.com>

Removed duplicated #include in arch/arm/mach-omap2/board-rx51.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 3a0daac..374ff63 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -15,7 +15,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/delay.h>
 #include <linux/gpio.h>
 
 #include <mach/hardware.h>

