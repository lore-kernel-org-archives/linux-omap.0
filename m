From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/11] arm: omap: musb: ioremap only what's ours
Date: Fri, 19 Feb 2010 15:30:19 -0800
Message-ID: <20100219233019.10559.71005.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100219232648.10559.380.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

omap3430 TRM says the OTG address space is 4k, not 8k.

Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/usb-musb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a80441d..ba71f76 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -152,7 +152,7 @@ void __init usb_musb_init(void)
 		musb_resources[0].start = OMAP243X_HS_BASE;
 	else
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
-	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
+	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
 	 * REVISIT: This line can be removed once all the platforms using

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
