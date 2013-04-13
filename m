From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] omap: mux: add AM/DM37x gpios
Date: Sat, 13 Apr 2013 19:30:25 +0200
Message-ID: <1365874225.3812.53.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:56951 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3DMRaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Apr 2013 13:30:30 -0400
Received: by mail-bk0-f52.google.com with SMTP id it16so1750999bkc.25
        for <linux-omap@vger.kernel.org>; Sat, 13 Apr 2013 10:30:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

This patch adds GPIO pins found on AM/DM37x.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/mach-omap2/mux34xx.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
index 6543ebf..3f26d29 100644
--- a/arch/arm/mach-omap2/mux34xx.h
+++ b/arch/arm/mach-omap2/mux34xx.h
@@ -393,6 +393,10 @@
 #define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET		0xa1c
 #define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET			0xa1e
 #define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET			0xa20
+#define OMAP3_CONTROL_PADCONF_GPIO_127				0xa24
+#define OMAP3_CONTROL_PADCONF_GPIO_126				0xa26
+#define OMAP3_CONTROL_PADCONF_GPIO_128				0xa28
+#define OMAP3_CONTROL_PADCONF_GPIO_129				0xa2a
 
 #define OMAP3_CONTROL_PADCONF_MUX_SIZE				\
-		(OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)
+		(OMAP3_CONTROL_PADCONF_GPIO_129 + 0x2)
-- 
1.7.10.4



