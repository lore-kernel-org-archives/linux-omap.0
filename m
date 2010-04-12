From: <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: [PATCH] select ARCH_OMAP_OTG for OMAP2430 SDP
Date: Mon, 12 Apr 2010 10:01:59 +0530
Message-ID: <1271046719-10506-1-git-send-email-viral.mehta@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>

Configuration for OMAP2430 should select ARCH_OMAP_OTG just like
it is done for OMAP2420

Signed-off-by: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a8a3d1e..8f9d9c9 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -10,6 +10,7 @@ config ARCH_OMAP2420
 config ARCH_OMAP2430
        bool "OMAP2430 support"
        depends on ARCH_OMAP2
+       select ARCH_OMAP_OTG

 config ARCH_OMAP3430
        bool "OMAP3430 support"
--
1.6.6


This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
