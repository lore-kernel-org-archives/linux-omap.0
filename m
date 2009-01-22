From: Kalle Valo <kalle.valo@nokia.com>
Subject: [PATCH 1/3] n800-bt: include board-nokia.h
Date: Thu, 22 Jan 2009 15:19:06 +0200
Message-ID: <20090122131906.18315.2861.stgit@tikku>
References: <20090122131602.18315.84862.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19476 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZAVNTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 08:19:49 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0MDIJtM025264
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 07:19:46 -0600
Received: from [127.0.1.1] (essapo-nirac252253.europe.nokia.com [10.162.252.253])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0MDJ7hA005017
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 15:19:07 +0200
In-Reply-To: <20090122131602.18315.84862.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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

