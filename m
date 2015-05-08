From: Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Sat, 9 May 2015 00:11:39 +0300
Message-ID: <CAB=otbSGB1Dsex-0OnwyNLfAVQCS78Rx0AvUySYOn9q5ZCKHTQ@mail.gmail.com>
References: <554AA11B.9040909@logicpd.com>
	<20150507160606.GB15563@atomide.com>
	<20150507161656.GB29183@saruman.tx.rr.com>
	<554BAC48.2050406@logicpd.com>
	<CAPM0aKVSJfyBj-FzdTDC+PFmHOmch39F26OF_0CzK5a704AVpA@mail.gmail.com>
	<CADYTM3YGgm9b+vpxH8jJk41Cc9no=-pPydfHQsvR1FehbRCTxw@mail.gmail.com>
	<554BD878.7090907@logicpd.com>
	<554BDC0D.7010401@logicpd.com>
	<554BE351.7070908@logicpd.com>
	<554CFF6E.9020208@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554CFF6E.9020208-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 8, 2015 at 9:24 PM, Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org> wrote:
> On 05/07/15 17:12, Tim Nordell wrote:
>>
>> On 05/07/15 16:41, Tim Nordell wrote:
>>>
>>> I'm going to try another test which limits the TX or RX activity to PIO
>>> mode only just to see what happens if I avoid the trigger listed in that
>>> specific errata (despite the workaround for the errata being present).
>>
>>
>> The system survives this.  I'm not sure if it's just because of
>> different usages of the system, or if because there is still an issue
>> with TX/RX DMA at the same time despite the advisory for the hardware
>> still being followed.
>>
>
> I was wrong about the MUSB code implementing the advisory correctly.  I
> misread the advisory as saying 32-bit aligned when in fact it says 32-byte
> aligned.  The additional constraints for the DMA advisory on the DM37x
> states that for Tx DMA packets, the data should be 32-byte aligned (Rx can
> go to any alignment still).  It also has payload size constraints for both
> Rx and Tx which aren't checked in the existing MUSB driver.
>
> Doing some testing, the USB networking stack isn't sending 32-byte aligned
> buffers so I can't double check to see if this completely fixes it or if
> it's just masking it by adding some additional checks.  For our system,
> we're going to leave the Tx DMAs completely disabled.
>
> At some point a patch should be developed which follows Advisory 1.81 for
> the DM3730 part.

Well, in MUSB driver we already have a code that prepares 4-bytes
aligned buffers
for new DMA engines. Please look at musb_host.c around
musb_{un}map_urb_for_dma()
that do that preparation.
When I was impelenting that few years ago I was aware only about OMAP4
MUSB DMA issue
so feel free to update it for DM37x as well.
Networking layer sends 2-bytes shifted buffers that's why it's failing.
Try to change MUSB_USB_DMA_ALIGN to 32 and see if it helps.

Good luck

Ruslan Bilovol
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
