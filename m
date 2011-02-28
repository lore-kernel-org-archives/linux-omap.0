From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 03/12] usb: musb: gadget: do not poke with
 gadget's list_head
Date: Mon, 28 Feb 2011 10:43:11 +0200
Message-ID: <20110228084311.GJ2459@legolas.emea.dhcp.ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-4-git-send-email-balbi@ti.com>
 <loom.20110225T201502-888@post.gmane.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:37589 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677Ab1B1InQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:43:16 -0500
Received: by bwz8 with SMTP id 8so4492728bwz.35
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:43:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110225T201502-888@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavol Kurina <pavol.kurina@emsys.de>
Cc: linux-omap@vger.kernel.org

On Fri, Feb 25, 2011 at 07:41:47PM +0000, Pavol Kurina wrote:
> Felipe Balbi <balbi <at> ti.com> writes:
> > 
> > struct usb_request's list_head is supposed to be
> > used only by gadget drivers, but musb is abusing
> > that. Give struct musb_request its own list_head
> > and prevent musb from poking into other driver's
> > business.
> 
> Hi,
> 
> I think, the patch misses to fix the usage of 
> "request->list" in musb_gadget_dequeue in 
> musb_gadget.c.
> 
> I found out by having troubles with f_mass_storage. 
> It needs musb_gadget_dequeue to work properly...
> 
> I backported the patch to android-2.6.35 kernel on a 
> omap4 system and also fixed the musb_gadget_dequeue 
> there so f_mass_storage seem to work at least there 
> now...
> 
> Can you check this patch regarding some missing bits
> please?

Looks like we need some extra tests to be added to g_zero, I tested with
g_zero and it didn't find that problem. Anyway, here's a patch which
probably fixes what you need to be fixed. Would you test it for me ?

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index da8c93b..bf88a61 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1274,7 +1274,8 @@ cleanup:
 static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 {
        struct musb_ep          *musb_ep = to_musb_ep(ep);
-       struct usb_request      *r;
+       struct musb_request     req = to_musb_request(request);
+       struct musb_request     *r;
        unsigned long           flags;
        int                     status = 0;
        struct musb             *musb = musb_ep->musb;
@@ -1285,10 +1286,10 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
        spin_lock_irqsave(&musb->lock, flags);
 
        list_for_each_entry(r, &musb_ep->req_list, list) {
-               if (r == request)
+               if (r == req)
                        break;
        }
-       if (r != request) {
+       if (r != req) {
                DBG(3, "request %p not queued to %s\n", request, ep->name);
                status = -EINVAL;
                goto done;

-- 
balbi
