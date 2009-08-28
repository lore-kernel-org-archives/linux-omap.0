From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 17:06:45 +0400
Message-ID: <4A97D665.90306@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com> <4A97A1FF.5050501@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com> <4A97AB42.4070008@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A635@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E73940436A4A63E@dbde02.ent.ti.com> <4A97CA80.7010600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A97CA80.7010600-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello, I wrote:

>>>>> This part is being done at musb_host_rx()

>>>>   You're doing it in musb_host_tx() actually. Although musb_host_rx()
>>>> is also broken WRT the isochronous transfers.

>>>>> doing next packet programming within same urb and *not* starting next

>>>> urb. Thus musb_start_urb() doesn't come into this path.

>>>>   What? Read the code, please -- musb_start_urb() call should always
>>>> precede musb_host_tx() which handles the DMA interrupt. Unless 
>>>> something
>>>> clears DMAReqEnab after musb_start_urb() call, setting it only once
>>>> should work.

>>> musb_start_urb() call does precede musb_host_tx() but when urb is
>>> *completed*.

>> I think you are aware that there are multiple packets within same 
>> isochronous urb and musb_start_urb() programs only for first packet.

>> ============================================================
>>         case USB_ENDPOINT_XFER_ISOC:
>>                 qh->iso_idx = 0;
>>                 qh->frame = 0;
>>                 offset = urb->iso_frame_desc[0].offset;
>>                 len = urb->iso_frame_desc[0].length;
>> ============================================================

>    Sure. What I'm still not aware of is where and how the TXCSR DMA bits 
> are cleared after the first fragment. Hopefully, testing will reveal 
> this...

    I really should have stared at the code a bit more myself. Now that I 
have the sad truth has dawned on me... :-/
    My patch "USB: musb: bugfixes for multi-packet TXDMA support" (commit 
c7bbc056a92476b3b3d70a8df7cc746ac5d56de7) inevitably causes the DMA bits to 
be cleared because we're using DMA mode 1 regardless of whether this is 
isochronous transfer or no.  (We could really use mode 0 for isochronous 
transfer and save the hassle when filtering out DMA completion interrupt in 
musb_host_tx().)
    So, I now have to ACK your patch (which could use a better description 
though) and strew my head with ashes. All this also must mean that I have 
managed to break ISO Tx DMA in the internal tree, where I added the 
abovementioned patch after the one that fixed it (the order of the patches 
in the community tree is reverse). I probably did not retest USB audio back 
then...

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
