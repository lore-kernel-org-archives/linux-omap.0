From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Mon, 20 Aug 2012 11:06:34 +0530
Message-ID: <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44338 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754480Ab2HTFgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 01:36:35 -0400
Received: by vbip1 with SMTP id p1so4801958vbi.4
        for <linux-omap@vger.kernel.org>; Sun, 19 Aug 2012 22:36:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>
> 3.6-rc2 fails to compile with
> CONFIG_USB_MUSB_HDRC=m
> CONFIG_USB_MUSB_OMAP2PLUS=m
>
>   LD      init/built-in.o
> drivers/built-in.o: In function `twl4030_usb_irq':
> /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
> drivers/built-in.o: In function `twl4030_usb_phy_init':
> /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'

Having TWL4030_USB as a module will get rid of this.
I'll see how this can be resolved when some modules are *built-in* and
some are made as *modules*.

Thanks
Kishon
