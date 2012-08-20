From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Mon, 20 Aug 2012 15:46:07 +0530
Message-ID: <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
	<CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com>
	<20120820095421.GL17455@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:55698 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100Ab2HTKQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 06:16:09 -0400
Received: by vbbff1 with SMTP id ff1so5134043vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 03:16:07 -0700 (PDT)
In-Reply-To: <20120820095421.GL17455@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On Mon, Aug 20, 2012 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY wrote:
>> Hi,
>>
>> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> >
>> > 3.6-rc2 fails to compile with
>> > CONFIG_USB_MUSB_HDRC=m
>> > CONFIG_USB_MUSB_OMAP2PLUS=m
>> >
>> >   LD      init/built-in.o
>> > drivers/built-in.o: In function `twl4030_usb_irq':
>> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
>> > drivers/built-in.o: In function `twl4030_usb_phy_init':
>> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'
>>
>> Having TWL4030_USB as a module will get rid of this.
>> I'll see how this can be resolved when some modules are *built-in* and
>> some are made as *modules*.
>
> EXPORT_SYMBOL_GPL() should sort that out, right ?

No :-( I already have EXPORT_SYMBOL_GPL() in omap2430.c.

Thanks
Kishon
