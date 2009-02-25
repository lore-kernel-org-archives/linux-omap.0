From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 2/2] OMAP3430SDP: Get rid of checkpatch.pl warnings with
 includes
Date: Wed, 25 Feb 2009 16:02:37 -0600
Message-ID: <A24693684029E5489D1D202277BE89442DF8399B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57958 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758075AbZBYWCp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 17:02:45 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1PM2cQD026383
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:02:43 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1PM2cA2008842
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:02:38 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>

>From bd4df7db454add3f679456a1e7f4c814f297cc71 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 25 Feb 2009 15:55:56 -0600
Subject: [PATCH 2/2] OMAP3430SDP: Get rid of checkpatch.pl warnings with includes

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ab0aa7d..867f5f6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/regulator/machine.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -39,8 +40,6 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 
-#include <asm/io.h>
-#include <asm/delay.h>
 #include <mach/control.h>
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
-- 
1.5.6.5

