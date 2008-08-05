From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH RFC] MUSB: Fix index register corruption seen with g_ether
 and Windows host
Date: Tue, 5 Aug 2008 21:18:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:33181 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756239AbYHEQDR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 12:03:17 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

From: Anand Gadiyar <gadiyar@ti.com>

If Indexed Mode register accesses are enabled, the ep0_rxstate() function calls
musb_g_ep0_giveback() before writing to the CSR register. When control returns
to this ep0_rxstate, the index register contents are over-written. This causes
the CSR register write to fail.

Fixed by writing the correct value into the index register before
writing to the CSR.

This was observed only in ep0_rxstate() with g_ether loaded and the device
connected to a MS Windows host PC. Anticipatively fixed ep0_txstate() as well.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: David Brownell <david-b@pacbell.net>
---
This patch will probably turn up with tabs replaced by spaces - my mailer is
broken. Will fix that or find another one. Till then, this is RFC. The patch
was based on the linux-omap git tree but that tab-to-space issue should cause
the patch to not apply.

Dave, you wrote the original commit (5dd8c56c) on linux-omap that moved the
register write after the call to the giveback function [1]. Could you take
a look at this patch please?

[1] <http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=5dd8c56c0bb1aaadbf6540de8350161c7a9f7034>

 drivers/usb/musb/musb_gadget_ep0.c |    2 ++
 1 files changed, 2 insertions(+)

Index: 04aug_ccase/drivers/usb/musb/musb_gadget_ep0.c
===================================================================
--- 04aug_ccase.orig/drivers/usb/musb/musb_gadget_ep0.c
+++ 04aug_ccase/drivers/usb/musb/musb_gadget_ep0.c
@@ -476,6 +476,7 @@ static void ep0_rxstate(struct musb *mus
                        return;
                musb->ackpend = 0;
        }
+       musb_ep_select(musb->mregs, 0);
        musb_writew(regs, MUSB_CSR0, tmp);
 }

@@ -528,6 +529,7 @@ static void ep0_txstate(struct musb *mus
        }

        /* send it out, triggering a "txpktrdy cleared" irq */
+       musb_ep_select(musb->mregs, 0);
        musb_writew(regs, MUSB_CSR0, csr);
 }
