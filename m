From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 07/10] ARM: OMAP2+: Avoid mailbox legacy device creation for DT-boot
Date: Fri, 11 Jul 2014 16:44:40 -0500
Message-ID: <1405115083-52977-8-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51012 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbaGKVpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jul 2014 17:45:53 -0400
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The legacy platform device for mailbox should not be created for
a DT boot, so adjust the platform device initialization logic
appropriately.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 592ba0a..708eb7d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -460,9 +460,9 @@ static int __init omap2_init_devices(void)
 	omap_init_audio();
 	omap_init_camera();
 	omap_init_hdmi_audio();
-	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
+		omap_init_mbox();
 		omap_init_mcspi();
 		omap_init_sham();
 		omap_init_aes();
-- 
2.0.0

