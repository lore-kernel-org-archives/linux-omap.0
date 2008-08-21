From: <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: patch musb-fix-index-register-corruption-seen-with-g_ether-and-windows-host.patch added to gregkh-2.6 tree
Date: Thu, 21 Aug 2008 09:05:18 -0700
Message-ID: <12193347183045@kroah.org>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31565@dbde02.ent.ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31565-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gadiyar-l0cyMroinI0@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    Subject: MUSB: Fix index register corruption seen with g_ether and Windows host

to my gregkh-2.6 tree.  Its filename is

    musb-fix-index-register-corruption-seen-with-g_ether-and-windows-host.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From gadiyar-l0cyMroinI0@public.gmane.org  Thu Aug 21 08:40:33 2008
From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Date: Thu, 21 Aug 2008 20:21:00 +0530
Subject: MUSB: Fix index register corruption seen with g_ether and Windows host
To: "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31565-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>


From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

If Indexed Mode register accesses are enabled, the ep0_rxstate()
function calls musb_g_ep0_giveback() before writing to the CSR
register. When control returns to this ep0_rxstate, the index
register contents are over-written. This causes the CSR register
write to fail.

Fixed by writing the correct value into the index register before
writing to the CSR.

This was observed only in ep0_rxstate() with g_ether loaded and
the device connected to a MS Windows host PC. Anticipatively fixed
ep0_txstate() as well.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

---
 drivers/usb/musb/musb_gadget_ep0.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -476,6 +476,7 @@ static void ep0_rxstate(struct musb *mus
 			return;
 		musb->ackpend = 0;
 	}
+	musb_ep_select(musb->mregs, 0);
 	musb_writew(regs, MUSB_CSR0, tmp);
 }
 
@@ -528,6 +529,7 @@ static void ep0_txstate(struct musb *mus
 	}
 
 	/* send it out, triggering a "txpktrdy cleared" irq */
+	musb_ep_select(musb->mregs, 0);
 	musb_writew(regs, MUSB_CSR0, csr);
 }
 


Patches currently in gregkh-2.6 which might be from gadiyar-l0cyMroinI0@public.gmane.org are

usb.current/usb-musb-get-rid-of-musb_loglevel-and-use-parameter.patch
usb.current/usb-musb-get-rid-of-procfs-entry.patch
usb.current/musb-fix-index-register-corruption-seen-with-g_ether-and-windows-host.patch
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
