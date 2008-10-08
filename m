From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] MUSB: Fixes endpoint allocation logic
Date: Wed, 8 Oct 2008 08:32:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DC1D556B@dbde02.ent.ti.com>
References: <1223372190-8050-1-git-send-email-ajay.gupta@ti.com>,<e5e6ade50810071121l60623de6r20848a8028b22f38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35811 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbYJHDCZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 23:02:25 -0400
In-Reply-To: <e5e6ade50810071121l60623de6r20848a8028b22f38@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Oct 7, 2008 at 2:36 AM, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> musb->periodic[] flag was getting set for an endpoint even when only rx
> or tx is used.This patch adds two field musb->in[16] and musb->out[16]
> in place of musb->periodic[32] which will enable endpoint allocation
> flag setting on rx/tx basis of an endpoint.

> To apply this I had to make some changes to an older patch, since it
> used ->periodic:
> http://marc.info/?l=linux-omap&m=122284678326859&w=2

> It seems to be working fine.  But, is there a way to get the latest
> versions of the pending MUSB patches?
> - Nathan

There are some changes required in my older patch 
http://marc.info/?l=linux-omap&m=122284678326859&w=2

I will submit a fresh patch again once it gets reviewd. Meanwhile I am
copying the changes which can be applied manually.

1) within musb_urb_dequeue()

-		if (usb_pipeisoc(type))
-			musb->periodic[qh->hw_ep->epnum] = NULL;
+		if (usb_pipeisoc(type) && usb_pipein(type))
+			musb->in[qh->hw_ep->epnum] = NULL;
+		else if (usb_pipeisoc(type) && usb_pipeout(type))
+			musb->out[qh->hw_ep->epnum] = NULL;

2) within musb_h_disable()

-		for (i = 0; i < musb->nr_endpoints; i++) {
-			if (musb->periodic[i] == qh)
+		for (i = 1; i < musb->nr_endpoints; i++) {
+			if ((musb->in[i] == qh) || (musb->out[i] == qh))

Regards,
Ajay

