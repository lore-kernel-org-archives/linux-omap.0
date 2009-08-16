From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH] ARM: OMAP3: Overo: fix merge error
Date: Sun, 16 Aug 2009 13:56:55 -0700
Message-ID: <5e088bd90908161356j4d78fa1dn5e0f82f62bdd180d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:40235 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZHPU4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 16:56:54 -0400
Received: by qyk34 with SMTP id 34so1904784qyk.33
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 13:56:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Missing definition for OVERO_GPIO_PENDOWN

Signed-off-by: Steve Sakoman <steve@sakoman.com>

---
 arch/arm/mach-omap2/board-overo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 3fd614e..65bf008 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -51,6 +51,7 @@

 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_PENDOWN	114
 #define OVERO_GPIO_BT_NRESET	164
 #define OVERO_GPIO_USBH_CPEN	168
 #define OVERO_GPIO_USBH_NRESET	183
-- 
1.6.0.4
