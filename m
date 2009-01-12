From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] ARM: OMAP: Fix compile for various McBSP
Date: Mon, 12 Jan 2009 16:38:25 +0200
Message-ID: <20090112143825.24205.47044.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57030 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZALOi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:38:29 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Include irqs.h or cpu.h directly as needed to fix
omap builds.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mcbsp.c |    1 +
 arch/arm/mach-omap2/mcbsp.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 4474da7..ca7a0cc 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index acdc709..e20023c 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>

