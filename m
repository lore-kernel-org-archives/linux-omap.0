From: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Subject: [PATCH 1/5] Make am35x helper function declarations accessible
Date: Fri, 23 Oct 2015 17:44:30 +0200
Message-ID: <562A55DE.8010906@imms.de>
References: <562A557B.4090501@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A557B.4090501-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

To be able to call these four helper functions from the M-USB AM35xx
glue code, their declarations need to be moved to a header file in the
kernels include hierarchy.

Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
---
 arch/arm/mach-omap2/usb.h              | 5 -----
 include/linux/platform_data/usb-omap.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
index 3395365..8b0cdf5 100644
--- a/arch/arm/mach-omap2/usb.h
+++ b/arch/arm/mach-omap2/usb.h
@@ -63,8 +63,3 @@ struct usbhs_phy_data {
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
 extern void usbhs_init(struct usbhs_omap_platform_data *pdata);
 extern int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys);
