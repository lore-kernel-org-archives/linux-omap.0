From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent
 clk set
Date: Tue, 12 Jun 2012 11:27:27 -0500
Message-ID: <4FD76DEF.7090309@ti.com>
References: <zumeng.chen@gmail.com> <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com> <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com> <4FD608C5.9000900@ti.com> <CA+Y31wfHiKEWFbwkec_fFHS3kKms_OccTKGQcetuE9F132vbDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44762 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab2FLQ1b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 12:27:31 -0400
In-Reply-To: <CA+Y31wfHiKEWFbwkec_fFHS3kKms_OccTKGQcetuE9F132vbDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, ajay.gupta@ti.com, khasim@ti.com, hvaibhav@ti.com


On 06/11/2012 09:30 PM, Zumeng Chen wrote:
> 
> 
> 2012/6/11 Jon Hunter <jon-hunter@ti.com <mailto:jon-hunter@ti.com>>
> 
> 
>     On 06/11/2012 09:00 AM, Zumeng Chen wrote:
>     > A typo fix for this cosmetic change and mute a failed message from
>     > a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.
>     >
>     > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com
>     <mailto:zumeng.chen@gmail.com>>
>     > ---
>     >  drivers/mfd/omap-usb-host.c |    4 +++-
>     >  1 files changed, 3 insertions(+), 1 deletions(-)
>     >
>     > diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>     > index 7e96bb2..9aaaf3c 100644
>     > --- a/drivers/mfd/omap-usb-host.c
>     > +++ b/drivers/mfd/omap-usb-host.c
>     > @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct
>     platform_device *pdev)
>     >               goto err_usbtll_p2_fck;
>     >       }
>     >
>     > +#ifndef CONFIG_MACH_OMAP3EVM
>     > +     /* for OMAP3 , the clk set parent fails */
>     >       if (is_ehci_phy_mode(pdata->port_mode[0])) {
>     > -             /* for OMAP3 , the clk set paretn fails */
>     >               ret = clk_set_parent(omap->utmi_p1_fck,
>     >                                       omap->xclk60mhsp1_ck);
>     >               if (ret != 0)
> 
>     This begs the question, why is port_mode[0] set to ehci phy mode if this
>     is failing? Something does not seem right here but this does not look
>     like the right fix.
> 
> Actually, for omap3530evm, there is only port-mode[1] is valid, so
> port_mode[0]
> will be skipped by "if". And it will report "xclk60mhsp2_ck set parent
> failed"
> 
> But why I bracket both of them, because, both xclk60mhsp2_ck and
> xclk60mhsp1_ck
> have dummy_ck clk for omap3530evm. So we can skip them directly.

How about something like this ...

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 62ec5c4..c1335f1 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
        if (!arch_clock || !arch_clock->clk_set_parent)
                return ret;

+       /* If the clock is a dummy clock just return */
+       if (!strcmp(clk->name, dummy_ck.name))
+               return 0;
+
        spin_lock_irqsave(&clockfw_lock, flags);
        if (clk->usecount == 0) {
                ret = arch_clock->clk_set_parent(clk, parent);

Can you give this a try?

Cheers
Jon
