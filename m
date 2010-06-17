From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/8] MUSB: make non-OMAP platforms build with CONFIG_PM=y
Date: Thu, 17 Jun 2010 16:10:35 +0530
Message-ID: <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276771242-5201-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

Attempt to build MUSB driver with CONFIG_PM=y (e.g. in the OTG mode) on DaVinci
results in these link errors:

drivers/built-in.o: In function `musb_restore_context':
led-triggers.c:(.text+0x714d8): undefined reference to
`musb_platform_restore_context'
drivers/built-in.o: In function `musb_save_context':
led-triggers.c:(.text+0x71788): undefined reference to
`musb_platform_save_context'

This turned out to be caused by commit 9957dd97ec5e98dd334f87ade1d9a0b24d1f86eb
(usb: musb: Fix compile error for omaps for musb_hdrc). Revert it, taking into
account the rename of CONFIG_ARCH_OMAP34XX into CONFIG_ARCH_OMAP3 (which that
commit fixed in a completely inappropriate way) and the recent addition of
OMAP4 support.

Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index b22d02d..91d6779 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -470,7 +470,8 @@ struct musb_csr_regs {
 
 struct musb_context_registers {
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+    defined(CONFIG_ARCH_OMAP4)
 	u32 otg_sysconfig, otg_forcestandby;
 #endif
 	u8 power;
@@ -484,7 +485,8 @@ struct musb_context_registers {
 	struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
 };
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+    defined(CONFIG_ARCH_OMAP4)
 extern void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context);
 extern void musb_platform_restore_context(struct musb *musb,
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
