From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/29] ARM: OMAP2+: Make id.h local
Date: Wed, 19 Sep 2012 14:05:47 -0700
Message-ID: <20120919210547.28074.54796.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42438 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967Ab2ISVFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:05:48 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 arch/arm/mach-omap2/id.c               |    2 +-
 arch/arm/mach-omap2/id.h               |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/id.h => id.h} (100%)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 3435cc5..d9ddb66 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -32,7 +32,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
-#include <mach/id.h>
+#include "id.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 6b98a17..cf2362c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -23,7 +23,7 @@
 
 #include "common.h"
 
-#include <mach/id.h>
+#include "id.h"
 
 #include "soc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/include/mach/id.h b/arch/arm/mach-omap2/id.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/id.h
rename to arch/arm/mach-omap2/id.h

