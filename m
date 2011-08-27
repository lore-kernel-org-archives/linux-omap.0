From: ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 22:46:25 +0800
Message-ID: <1314456385-16378-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XWe1ixc4/HljEvhb3Hwu1Ks@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

This patch fixs one performance bug on ARM Cortex A9 dual core platform,
which has been reported on quite a few ARM machines(OMAP4, Tegra 2, snowball...),
see details from link of https://bugs.launchpad.net/bugs/709245.

In fact, one mb() on ARM is enough to flush L2 cache, but
'dummy->hw_token = token;' after mb() is added just for obeying
correct mb() usage.

The patch has been tested ok on OMAP4 panda A1 board, the performance
of 'dd' over usb mass storage can be increased from 4~5MB/sec to
14~16MB/sec after applying this patch.

Signed-off-by: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/usb/host/ehci-q.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 0917e3a..65b5021 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
 			wmb ();
 			dummy->hw_token = token;
 
+			/* The mb() below is added to make sure that
+			 * 'token' can be writen into qtd, so that ehci
+			 * HC can see the up-to-date qtd descriptor. On
+			 * some archs(at least on ARM Cortex A9 dual core),
+			 * writing into coherenet memory doesn't mean the
+			 * value written can reach physical memory
+			 * immediately, and the value may be buffered
+			 * inside L2 cache. 'dummy->hw_token = token;'
+			 * after mb() is added for obeying correct mb()
+			 * usage.
+			 * */
+			mb();
+			token = dummy->hw_token;
+
 			urb->hcpriv = qh_get (qh);
 		}
 	}
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
