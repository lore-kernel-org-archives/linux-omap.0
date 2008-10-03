From: "Nathan Monson" <nmonson@gmail.com>
Subject: RE: OMAP support in mainline?
Date: Fri, 3 Oct 2008 00:20:56 -0700
Message-ID: <e5e6ade50810030020q62e2a305tf9111f626c1eb42f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:63861 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYJCHU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 03:20:57 -0400
Received: by gxk9 with SMTP id 9so2309647gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 00:20:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 18, 2008 at 3:26PM, Felipe Balbi wrote:
> Yeah, we lost some musb history when it went to mainline. I didn't test
> this patch yet cuz I've been quite busy at work, but it should make
> beagle work. Could you tell me if makes it work ?

This patch has been working for me until the latest round of twl4030 changes.

Commit fde13f8fc7de977e71304fd500fed029b41ceb19/"move twl4030-usb to
platform-device" changed subsys_initcall to module_init in
twl4030-usb.

Now, twl4030-usb is initialized after musb.  This means
otg_set_transceiver is called later in boot, so the patch below gets
null back from otg_get_transceiver and oopses on *xceiv.

Unfortunately, without the patch, USB host doesn't work on the BeagleBoard.

Other than this, the new kernel seems to work pretty well for me.

- Nathan

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 9d2dcb1..f7fe91e 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>
> int __init musb_platform_init(struct musb *musb)
> {
> +       struct otg_transceiver *xceiv = otg_get_transceiver();
> u32 l;
>
> #if defined(CONFIG_ARCH_OMAP2430)
> omap_cfg_reg(AE5_2430_USB0HS_STP);
> #endif
>
> +       memcpy(musb->xceiv, xceiv, sizeof(*xceiv));
> musb_platform_resume(musb);
>
> l = omap_readl(OTG_SYSCONFIG);
