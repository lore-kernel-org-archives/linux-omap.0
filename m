From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Question regarding MUSB and dynamic fifo sizing
Date: Fri, 7 Aug 2009 01:41:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
References: <1249589441.10885.75.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41801 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbZHFUQU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 16:16:20 -0400
In-Reply-To: <1249589441.10885.75.camel@blitz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>, linux-omap <linux-omap@vger.kernel.org>

Peter Barada wrote:
> I'm running into a problem where the MUSB controller stops talking with
> the hardwired device on the other end, and I wasn to unload the musb as
> a module and reload it to the connection working again.
> 
> I can compile MSUB as a module, but when I load it the 2nd time it
> complains with:
> 
> OMAP-35x# modprobe musb_hdrc
> musb_hdrc: version 6.0, pio, otg (peripheral+host), debug=0
> musb_core_init 1421: reconfigure software for static FIFOs
> musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> 
> This is due to the platform device wanting dynamic fifo sizing but the
> CONFIGDATA register has DYNFIFO bit cleared.  Looking through the TRM, I
> can't find informaiton on how the MUSB controller changes the state of
> DYNFIFO - I'm guessing once any of the dynamic registers are written to
> that the controller switches to Dynamic Fifo sizing.

This patch from Ajay (already in mainline) should fix it for you.

<http://marc.info/?l=linux-usb&m=124881724122257&w=2>

The problem is not that the CONFIGDATA changes, but that we attempt
to read from CONFIGDATA without having set the INDEX register to 0.

CONFIGDATA is a read-only register.

- Anand


> 
> The code that aborts is:
> 
>         if (reg & MUSB_CONFIGDATA_DYNFIFO) {
>                 if (musb->config->dyn_fifo)
>                         status = ep_config_from_table(musb);
>                 else {
>                         ERR("reconfigure software for Dynamic FIFOs\n");
>                         status = -ENODEV;
>                 }
>         } else {
>                 if (!musb->config->dyn_fifo)
>                         status = ep_config_from_hw(musb);
>                 else {
>                         ERR("reconfigure software for static FIFOs\n");
>                         return -ENODEV;
>                 }
>         }
> 
> 1) How can one change from dynamic to static fifo sizing in the MUSB?
> 
> 2) Would it be safe to program for dynamic fifo sizing if CONFIG_DATA
> indicates the fifos are Statically sized?
> 
> 
> --
> Peter Barada <peterb@logicpd.com>
> Logic Product Development, Inc.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 