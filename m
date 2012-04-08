From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND] omap1: mux: add missing include
Date: Sun,  8 Apr 2012 23:23:30 +0300
Message-ID: <1333916610-7451-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40770 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab2DHUXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Apr 2012 16:23:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jarkko.nikula@bitmer.com

Fix the following build breakage in v3.4-rc2:

arch/arm/mach-omap1/mux.c:89:1: error: 'FUNC_MUX_CTRL_9' undeclared here (not in a function)
arch/arm/mach-omap1/mux.c:89:1: error: 'PULL_DWN_CTRL_2' undeclared here (not in a function)
arch/arm/mach-omap1/mux.c:93:1: error: 'FUNC_MUX_CTRL_C' undeclared here (not in a function)

etc.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/mux.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 087dba0..e9cc52d 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
+#include <mach/hardware.h>
 
 #include <plat/mux.h>
 
-- 
1.7.2.5

