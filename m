From: "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Subject: Re: [OOPS] cppi41_dma_channel_program: Unable to handle kernel NULL
 pointer dereference
Date: Sat, 21 May 2016 20:50:32 +0300
Message-ID: <CAJs94EYePeENwsHD--E6cGVP22-nfYcy_yTK-V2Hc1wWYb04vw@mail.gmail.com>
References: <1463750386-6259-1-git-send-email-matwey@sai.msu.ru>
 <CAJs94EZjWi0KGn_siyXNGvjO2DTh2aXtYqKzy7Km7mA_bYTeKg@mail.gmail.com>
 <20160520201019.GA3432@uda0271908> <CAJs94EZSwJ=sJv6NtR6RNdiugiSQQpam-TFRTn0uZZJ4MLsr5g@mail.gmail.com>
 <CAJs94EY3BfQjkk+0hKR5WfKggvmtgV0yz77awiX8Lt_pLYs3ug@mail.gmail.com>
 <CAJs94EZm3aV23x3hGHLpM4dAC+C9rH-ro3JbWU=se_QWv9jRmw@mail.gmail.com>
 <20160520211236.GB3432@uda0271908> <CAJs94Eb6tfJHV7YeAA0UATF2A5oNrCDTSqTAdHbacmrm4Qw=8w@mail.gmail.com>
 <CADYTM3bcTWSBf9HXKpsud6i--_04tsKZX1J3p9_6TqL1gp9YnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADYTM3bcTWSBf9HXKpsud6i--_04tsKZX1J3p9_6TqL1gp9YnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

2016-05-21 6:13 GMT+03:00 Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi,
>
> On Fri, May 20, 2016 at 4:20 PM, Matwey V. Kornilov <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org> wrote:
>> 2016-05-21 0:12 GMT+03:00 Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>:
>>> Hi,
>>>
>>> On Sat, May 21, 2016 at 12:05:06AM +0300, Matwey V. Kornilov wrote:
>>>> By the way, is it ok that function musb_rx_dma_iso_cppi41 uses
>>>> hw_ep->tx_channel? I would suppose that it should use rx_channel
>>>> instead.
>>>
>>> I just got here, and am wondering the same. But the question is why just
>>> your case hit the problem. I will try to look at it more next week.
>>>
>>> I had an impression the linux-usb@ has a discussion before about
>>> rx/tx-channel messing up, will have to look it up.
>>>
>>
>> Thank you.
>> If you need additional info, I can use kgdb with this issue.
>
> After reviewed the code, it must be hw_ep->rx_channel instead. It is likely a
> bug caused by commit 069a3fd (usb: musb: Remove ifdefs for musb_host_rx
> in musb_host.c part1). Please test with the following patch.
>

I've just tested this patch. Indeed, it helps to avoid kernel panic.
Now, I can interact with my webcam and watch video-stream in  xawtv.
It would be great if the patch could become a part of 4.6.x stable tree.

> Regards,
> -Bin.
>
> -----8<---------
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 2f8ad7f..9b2553c 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -1551,7 +1551,7 @@ static int musb_rx_dma_iso_cppi41(struct
> dma_controller *dma,
>                                   struct urb *urb,
>                                   size_t len)
>  {
> -       struct dma_channel *channel = hw_ep->tx_channel;
> +       struct dma_channel *channel = hw_ep->rx_channel;
>         void __iomem *epio = hw_ep->regs;
>         dma_addr_t *buf;
>         u32 length, res;
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
