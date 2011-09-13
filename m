From: Dat <dtran11@gmail.com>
Subject: Re: musb crash on suspend
Date: Tue, 13 Sep 2011 14:26:58 +0000 (UTC)
Message-ID: <loom.20110913T162232-434@post.gmane.org>
References: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com> <CAOd_LFwAej8uJxk4aN0r1r5seODuCwE=H3yfjfDnZpcS2SzmTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44791 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145Ab1IMOaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 10:30:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1R3Tzw-0005zi-5y
	for linux-omap@vger.kernel.org; Tue, 13 Sep 2011 16:30:04 +0200
Received: from 205.178.40.152 ([205.178.40.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 16:30:04 +0200
Received: from dtran11 by 205.178.40.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 16:30:04 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Cliff Brake <cliff.brake <at> gmail.com> writes:

> 
> On Thu, Jul 28, 2011 at 5:05 PM, Cliff Brake <cliff.brake <at> gmail.com> 
wrote:
> 
> My kernel config is:
> 
> CONFIG_USB_MUSB_HDRC=y
> # CONFIG_USB_MUSB_TUSB6010 is not set
> CONFIG_USB_MUSB_OMAP2PLUS=y
> # CONFIG_USB_MUSB_AM35X is not set
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_PERIPHERAL is not set
> CONFIG_USB_MUSB_OTG=y
> CONFIG_USB_GADGET_MUSB_HDRC=y
> CONFIG_USB_MUSB_HDRC_HCD=y
> # CONFIG_MUSB_PIO_ONLY is not set
> CONFIG_USB_INVENTRA_DMA=y
> 
> Its interesting that if I plug a host cable into the port, then it
> seems to suspend.  Its only when a host cable is not plugged in (ID
> pin is not grounded) that I get this crash.
> 
> Cliff
> 



Hi Cliff,

I have the same problem as you. Did you ever fix the problem? I don't think it 
is working when you have the usb cable plugged in. You don't see the error 
because it doesn't really go into suspend mode when the cable is plugged in. You 
should see something like "core_domain failed to suspend error 1" when you 
resume from suspend.

I found the error to be in musb_core.c, musb_save_context(), when executing this 
line:

    musb->context.power = musb_readb(musb_base, MUSB_POWER);   

I wonder if the memory is suspending before the USB can save the context.

Thanks.


