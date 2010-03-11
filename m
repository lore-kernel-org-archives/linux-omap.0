From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/3] usb: Fix compile error for omaps for musb_hdrc
Date: Thu, 11 Mar 2010 10:03:22 -0800
Message-ID: <20100311180322.20537.3614.stgit@baageli.muru.com>
References: <20100311180023.20537.27516.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311180023.20537.27516.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

CONFIG_ARCH_OMAP34XX is now CONFIG_ARCH_OMAP3.

But since drivers/usb/musb/omap2430.c use CONFIG_PM for these
registers and functions, do the same for the header.

Otherwise we get the following for most omap3 defconfigs:

drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'do'
drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'while'
drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'do'
drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'while'

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index d849fb8..cd9f4a9 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -469,7 +469,7 @@ struct musb_csr_regs {
 
 struct musb_context_registers {
 
-#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
+#ifdef CONFIG_PM
 	u32 otg_sysconfig, otg_forcestandby;
 #endif
 	u8 power;
@@ -483,7 +483,7 @@ struct musb_context_registers {
 	struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
 };
 
-#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
+#ifdef CONFIG_PM
 extern void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context);
 extern void musb_platform_restore_context(struct musb *musb,

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
