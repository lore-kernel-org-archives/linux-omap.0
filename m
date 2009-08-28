From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 17:23:08 +0400
Message-ID: <4A97DA3C.5090008@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com> <4A97A1FF.5050501@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com> <4A97AB42.4070008@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A635@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E73940436A4A63E@dbde02.ent.ti.com> <4A97CA80.7010600@ru.mvista.com> <4A97D665.90306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53725 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813AbZH1NVY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 09:21:24 -0400
In-Reply-To: <4A97D665.90306@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

Hello, I wrote:

>>>>>   You're doing it in musb_host_tx() actually. Although musb_host_rx()
>>>>> is also broken WRT the isochronous transfers.

>>>>>> doing next packet programming within same urb and *not* starting next

>>>>> urb. Thus musb_start_urb() doesn't come into this path.

>>>>>   What? Read the code, please -- musb_start_urb() call should always
>>>>> precede musb_host_tx() which handles the DMA interrupt. Unless 
>>>>> something
>>>>> clears DMAReqEnab after musb_start_urb() call, setting it only once
>>>>> should work.

>>>> musb_start_urb() call does precede musb_host_tx() but when urb is
>>>> *completed*.

>>> I think you are aware that there are multiple packets within same 
>>> isochronous urb and musb_start_urb() programs only for first packet.

>>> ============================================================
>>>         case USB_ENDPOINT_XFER_ISOC:
>>>                 qh->iso_idx = 0;
>>>                 qh->frame = 0;
>>>                 offset = urb->iso_frame_desc[0].offset;
>>>                 len = urb->iso_frame_desc[0].length;
>>> ============================================================

>>    Sure. What I'm still not aware of is where and how the TXCSR DMA 
>> bits are cleared after the first fragment. Hopefully, testing will 
>> reveal this...

>    I really should have stared at the code a bit more myself. Now that I 
> have the sad truth has dawned on me... :-/
>    My patch "USB: musb: bugfixes for multi-packet TXDMA support" (commit 
> c7bbc056a92476b3b3d70a8df7cc746ac5d56de7) inevitably causes the DMA bits 

    You can also refer to this patch'es brokenness in your patch description.
Looks like I now have the complete picture of what happened back then when 
the patches were (re)submitted. The DaVinci case was competely broken when I 
recast the patch "USB: musb: fix isochronous TXDMA (take 2)" to fix the 
failure to transfer the whole ISO URB in DMA mode for the Mentor's own DMA 
case; before that, DaVinci case could (likewise) complete the URB transfer 
in PIO mode after transferring the first fragment via DMA...

>    So, I now have to ACK your patch (which could use a better description though) and strew my head with ashes. All this also must mean that I have managed to break ISO Tx DMA in the internal tree, where I added the abovementioned patch after the one that fixed it (the order of the patches in the community tree is reverse). I probably did not retest USB audio back then...

    No, looks like in the internal tree transfer is completed in PIO mode 
since the internal version of patch lacks that Mentor DMA fix (luckily :-). 
Should still check to make sure...

WBR, Sergei

