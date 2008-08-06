From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH RFC] MUSB: Fix index register corruption seen with g_ether and Windows host
Date: Wed, 6 Aug 2008 12:26:45 +0800
Message-ID: <386072610808052126o85e13cdm45925abdde96f159@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:12901 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbYHFE0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 00:26:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1650732ywe.1
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2008 21:26:45 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Tue, Aug 5, 2008 at 11:48 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
>
> If Indexed Mode register accesses are enabled, the ep0_rxstate() function calls
> musb_g_ep0_giveback() before writing to the CSR register. When control returns
> to this ep0_rxstate, the index register contents are over-written. This causes
> the CSR register write to fail.
>
> Fixed by writing the correct value into the index register before
> writing to the CSR.
>
> This was observed only in ep0_rxstate() with g_ether loaded and the device
> connected to a MS Windows host PC. Anticipatively fixed ep0_txstate() as well.
>

Actually, I'm still struggling in a bug similar with this one on Blackfin.
We ran following testcase 100 times, 10-20 times tastcases failed.

---
$ ./testusb -D /proc/bus/usb/005/012 -t14 -c 15000 -s 256 -v 1
unknown speed   /proc/bus/usb/005/012
/proc/bus/usb/005/012 test 14 --> 75 (Value too large for defined data type)
---

I reported this bug to our hardware designer and the omap list. Felipe
said he did met this issue.
>From the capture data of USB analyzer, the peripheral musb sent out
garbage data in the IN-STATUS stage.
In that stage, the DATA length should be zero. But the peripheral sent
out 1 byte or 2 bytes sometimes.

Thanks
-Bryan

> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: David Brownell <david-b@pacbell.net>
> ---
> This patch will probably turn up with tabs replaced by spaces - my mailer is
> broken. Will fix that or find another one. Till then, this is RFC. The patch
> was based on the linux-omap git tree but that tab-to-space issue should cause
> the patch to not apply.
>
> Dave, you wrote the original commit (5dd8c56c) on linux-omap that moved the
> register write after the call to the giveback function [1]. Could you take
> a look at this patch please?
>
> [1] <http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=5dd8c56c0bb1aaadbf6540de8350161c7a9f7034>
>
>  drivers/usb/musb/musb_gadget_ep0.c |    2 ++
>  1 files changed, 2 insertions(+)
>
> Index: 04aug_ccase/drivers/usb/musb/musb_gadget_ep0.c
> ===================================================================
> --- 04aug_ccase.orig/drivers/usb/musb/musb_gadget_ep0.c
> +++ 04aug_ccase/drivers/usb/musb/musb_gadget_ep0.c
> @@ -476,6 +476,7 @@ static void ep0_rxstate(struct musb *mus
>                        return;
>                musb->ackpend = 0;
>        }
> +       musb_ep_select(musb->mregs, 0);
>        musb_writew(regs, MUSB_CSR0, tmp);
>  }
>
> @@ -528,6 +529,7 @@ static void ep0_txstate(struct musb *mus
>        }
>
>        /* send it out, triggering a "txpktrdy cleared" irq */
> +       musb_ep_select(musb->mregs, 0);
>        musb_writew(regs, MUSB_CSR0, csr);
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
