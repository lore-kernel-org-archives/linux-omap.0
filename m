From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/6 v3] omap: musb: Adding support for ti81xx
Date: Fri, 9 Sep 2011 19:17:46 +0530
Message-ID: <1315576070-7618-3-git-send-email-ajay.gupta@ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55062 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759132Ab1IINr7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 09:47:59 -0400
In-Reply-To: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi Babu <ravibabu@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Ravi Babu <ravibabu@ti.com>

Added musb support for ti81xx platform which has two instances of musb
interface and uses CPPI4.1 DMA. The current patch set adds support for
single instance and in PIO mode only.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a65145b..8bceeca 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -143,6 +143,9 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
+	} else if (cpu_is_ti81xx()) {
+		oh_name = "usb_otg_hs";
+		name = "musb-ti81xx";
 	} else {
 		oh_name = "usb_otg_hs";
 		name = "musb-omap2430";
-- 
1.6.2.4

