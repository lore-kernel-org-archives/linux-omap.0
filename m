From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/6 v2] omap: musb: Adding support for ti81xx
Date: Wed, 7 Sep 2011 22:32:21 +0530
Message-ID: <1315414945-19829-3-git-send-email-ajay.gupta@ti.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315414945-19829-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>

Added musb support for ti81xx platform which has two instances of musb
interface and uses CPPI4.1 DMA. The current patch set adds support for
single instance and in PIO mode only.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
