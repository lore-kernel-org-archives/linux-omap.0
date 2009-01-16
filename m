From: Kalle Valo <kalle.valo@nokia.com>
Subject: [PATCH] n800-bt: include board-nokia.h
Date: Fri, 16 Jan 2009 21:11:01 +0200
Message-ID: <20090116191100.17814.16519.stgit@tikku>
References: <87bpu7m6iq.fsf@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19487 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937136AbZAPTLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 14:11:13 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0GJAxcZ013290
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 21:11:09 +0200
In-Reply-To: <87bpu7m6iq.fsf@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ville.tervo@nokia.com

Fixes compilation error:

arch/arm/mach-omap2/board-n800-bt.c: In function 'n800_bt_init':
arch/arm/mach-omap2/board-n800-bt.c:36: error: 'OMAP_TAG_NOKIA_BT' undeclared (first use in this function)
arch/arm/mach-omap2/board-n800-bt.c:36: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/board-n800-bt.c:36: error: for each function it appears in.)
arch/arm/mach-omap2/board-n800-bt.c:36: error: invalid application of 'sizeof' to incomplete type 'struct omap_bluetooth_config'

Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
---

 arch/arm/mach-omap2/board-n800-bt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-bt.c b/arch/arm/mach-omap2/board-n800-bt.c
index 61afd2b..da3a7bb 100644
--- a/arch/arm/mach-omap2/board-n800-bt.c
+++ b/arch/arm/mach-omap2/board-n800-bt.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <mach/board.h>
+#include <mach/board-nokia.h>
 
 static struct platform_device n800_bt_device = {
 	.name           = "hci_h4p",

