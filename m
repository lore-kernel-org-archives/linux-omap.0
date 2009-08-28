From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 16:16:00 +0400
Message-ID: <4A97CA80.7010600@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com> <4A97A1FF.5050501@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com> <4A97AB42.4070008@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A635@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E73940436A4A63E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51891 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751099AbZH1MOP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 08:14:15 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A4A63E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

Gupta, Ajay Kumar wrote:

>>>>This part is being done at musb_host_rx()

>>>   You're doing it in musb_host_tx() actually. Although musb_host_rx()
>>>is also broken WRT the isochronous transfers.

>>>> doing next packet programming within same urb and *not* starting next

>>>urb. Thus musb_start_urb() doesn't come into this path.

>>>   What? Read the code, please -- musb_start_urb() call should always
>>>precede musb_host_tx() which handles the DMA interrupt. Unless something
>>>clears DMAReqEnab after musb_start_urb() call, setting it only once
>>>should work.

>>musb_start_urb() call does precede musb_host_tx() but when urb is
>>*completed*.

> I think you are aware that there are multiple packets within same isochronous urb and musb_start_urb() programs only for first packet.
> 
> ============================================================
>         case USB_ENDPOINT_XFER_ISOC:
>                 qh->iso_idx = 0;
>                 qh->frame = 0;
>                 offset = urb->iso_frame_desc[0].offset;
>                 len = urb->iso_frame_desc[0].length;
> ============================================================

    Sure. What I'm still not aware of is where and how the TXCSR DMA bits 
are cleared after the first fragment. Hopefully, testing will reveal this...

WBR, Sergei
