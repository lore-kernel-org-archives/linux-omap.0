From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Tue, 3 Jun 2008 12:32:44 +0800
Message-ID: <386072610806022132m2d515537wadd23c102aec2bf0@mail.gmail.com>
References: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:40684 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYFCEcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 00:32:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so696252ywe.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Jun 2008 21:32:44 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>

On Tue, Jun 3, 2008 at 12:27 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> Hi folks,
>>
>> I am trying to enable the whole musb HS DMA code on Blackfin. But
>> found the is no place to clean the DMA interrupt flag in musbhsdma.c.
>> As a result, the irq always happens with the same DMA irq source. I
>> add some code to clear the DMA interrupt. Did I miss something here?
>
> The DMA interrupt register is cleared on a read. I don't think you need
> to explicitly clear it.
>

Maybe there some difference between Blackfin and OMAP implementation.
>From the Datatsheet of BF54x, it said that:
---
USB DMA Interrupt (USB_DMA_INTERRUPT) Register
The USB_INTRTX register (see Figure 13-9) indicates which of the eight
DMA master channels have a pending interrupt. When the status has been
read by the processor core, the corresponding bit should have a 1 written
to it by the software in order to clear the status.
---

And without the clearing operation, the DMA irq handler will be called endless.

Thanks
-Bryan

>>
>> After enabling the musb HS DMA code for Blackfin, normal operation is
>> OK for mount/umount U-disks. But when I tried to write large file to
>> the U-DISK (such as 10Mbyte or 100Mbyte), speed is very slow and mush
>> slower than PIO mode, IMO.
>> Did you guy meet this issue before on OMAP?
>>
>> Thanks
>> -Bryan
>
> - Anand
>
