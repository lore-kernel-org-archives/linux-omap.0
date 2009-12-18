From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/8] OMAP2: remove duplicated #include
Date: Thu, 17 Dec 2009 21:20:15 -0700
Message-ID: <20091218042014.27280.91017.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40391 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbZLREVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 23:21:49 -0500
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Huang Weiyi <weiyi.huang@gmail.com>

From: Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  arch/arm/mach-omap2/clock34xx.c
  arch/arm/mach-omap2/io.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |    1 -
 arch/arm/mach-omap2/io.c        |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ded3236..d4217b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -34,7 +34,6 @@
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include <plat/sdrc.h>
 #include "clock.h"
 #include "clock34xx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a8749e8..ac9ea60 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -33,7 +33,6 @@
 #include <plat/sdrc.h>
 #include <plat/gpmc.h>
 #include <plat/serial.h>
-#include <plat/mux.h>
 #include <plat/vram.h>
 
 #include "clock.h"


