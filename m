From: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>
Subject: [PATCH] OMAP34xx: Add padconfig offsets for GPIOs 126-129
Date: Fri, 01 Apr 2011 22:23:30 +0200
Message-ID: <4D963442.1020106@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mxvs2.esa.t-systems.com ([81.7.202.143]:5903 "EHLO
	mxvs2.esa.t-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab1DAUet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 16:34:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Add OMAP3_CONTROL_PADCONF_GPIOxxx_OFFSET constants for GPIOs 126-129

Signed-off-by: Matthias Kaehlcke <matthias@tomtom.com>
---
  arch/arm/mach-omap2/mux34xx.h |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
index 6543ebf..70d2b8d 100644
--- a/arch/arm/mach-omap2/mux34xx.h
+++ b/arch/arm/mach-omap2/mux34xx.h
@@ -393,6 +393,10 @@
  #define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET		0xa1c
  #define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET			0xa1e
  #define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET			0xa20
+#define OMAP3_CONTROL_PADCONF_GPIO127_OFFSET			0xa24
+#define OMAP3_CONTROL_PADCONF_GPIO126_OFFSET			0xa26
+#define OMAP3_CONTROL_PADCONF_GPIO128_OFFSET			0xa28
+#define OMAP3_CONTROL_PADCONF_GPIO129_OFFSET			0xa2a

  #define OMAP3_CONTROL_PADCONF_MUX_SIZE				\
  		(OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)
-- 
1.7.1

