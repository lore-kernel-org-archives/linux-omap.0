From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/3] arm: omap: hwmod: add a new addr space in otg for writing to control module
Date: Tue, 11 Sep 2012 14:39:38 +0530
Message-ID: <1347354580-5895-2-git-send-email-kishon@ti.com>
References: <1347354580-5895-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347354580-5895-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The mailbox register for usb otg in omap is present in control module.
On detection of any events VBUS or ID, this register should be written
to send the notification to musb core.

Till we have a separate control module driver to write to control module,
omap2430 will handle the register writes to control module by itself. So
a new address space to represent this control module register is added
to usb_otg_hs.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..3c19120 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5890,6 +5890,12 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
 		.pa_end		= 0x4a0ab003,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		/* XXX: Remove this once control module driver is in place */
+		.pa_start	= 0x4a00233c,
+		.pa_end		= 0x4a00233f,
+		.flags		= ADDR_TYPE_RT
+	},
 	{ }
 };
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
