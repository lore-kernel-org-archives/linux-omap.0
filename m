From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] ARM: OMAP: remove duplicated #include's
Date: Mon, 12 Jan 2009 16:46:11 +0200
Message-ID: <20090112144611.24205.23449.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65383 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbZALOqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:46:15 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

From: Huang Weiyi <weiyi.huang@gmail.com>

Removed duplicated #include's in arch/arm/mach-omap1/board-voiceblue.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-voiceblue.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index c224f3c..a765354 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -22,7 +22,6 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
-#include <linux/irq.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>

