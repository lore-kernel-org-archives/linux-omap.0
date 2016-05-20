From: "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Subject: Re: [OOPS] cppi41_dma_channel_program: Unable to handle kernel NULL
 pointer dereference
Date: Fri, 20 May 2016 23:55:41 +0300
Message-ID: <CAJs94EZSwJ=sJv6NtR6RNdiugiSQQpam-TFRTn0uZZJ4MLsr5g@mail.gmail.com>
References: <1463750386-6259-1-git-send-email-matwey@sai.msu.ru>
 <CAJs94EZjWi0KGn_siyXNGvjO2DTh2aXtYqKzy7Km7mA_bYTeKg@mail.gmail.com> <20160520201019.GA3432@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160520201019.GA3432@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I used kgdb. Is it ok?
channel appeared to be 0x0:

(gdb) continue
Continuing.
[Switching to Thread 315]

Breakpoint 1, cppi41_dma_channel_program (channel=0x0, packet_sz=960,
mode=0 '\000', dma_addr=2609136576, len=960)
    at ../drivers/usb/musb/musb_cppi41.c:481
481     {
(gdb) bt
#0  cppi41_dma_channel_program (channel=0x0, packet_sz=960, mode=0
'\000', dma_addr=2609136576, len=960)
    at ../drivers/usb/musb/musb_cppi41.c:481
#1  0xbf251570 in musb_rx_dma_iso_cppi41 (len=<optimized out>,
urb=<optimized out>, qh=<optimized out>, hw_ep=<optimized out>,
    dma=<optimized out>) at ../drivers/usb/musb/musb_host.c:1569
#2  musb_rx_dma_inventra_cppi41 (len=<optimized out>, urb=<optimized
out>, qh=<optimized out>, hw_ep=<optimized out>,
    dma=<optimized out>) at ../drivers/usb/musb/musb_host.c:1652
#3  musb_host_rx (musb=0xdb3e0010, epnum=<optimized out>) at
../drivers/usb/musb/musb_host.c:1969
#4  0xbf249fb4 in musb_dma_completion (musb=<optimized out>,
epnum=<optimized out>, transmit=<optimized out>)
    at ../drivers/usb/musb/musb_core.c:1693
#5  0xbf258b10 in cppi41_trans_done (cppi41_channel=0xd914c3bc) at
../drivers/usb/musb/musb_cppi41.c:148
#6  0xbf258c1c in cppi41_dma_callback (private_data=<optimized out>)
at ../drivers/usb/musb/musb_cppi41.c:286
#7  0xbf229f38 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)


2016-05-20 23:10 GMT+03:00 Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>:
> Hi,
>
> On Fri, May 20, 2016 at 04:32:06PM +0300, Matwey V. Kornilov wrote:
>> 2016-05-20 16:19 GMT+03:00  <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>:
>> > Hello,
>> >
>> > I am running 4.6-rc3 on BealgeBone Black and when I try to interract
>> > with pwc webcam attached to usb port the following kernel panic
>> > happening.
>>
>> Please note, that the same is happening with 4.6.0 release.
>
> Please apply the following patch and reproduce the oops, I'd like to
> check if the oops is caused by NULL of hw_ep->in_qh.
>
> Regards,
> -Bin.
>
> ---8<-------
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
> index e499b86..3492c6e 100644
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
> @@ -489,8 +489,11 @@ static int cppi41_dma_channel_program(struct dma_channel *channel,
>         if (is_host_active(cppi41_channel->controller->musb)) {
>                 if (cppi41_channel->is_tx)
>                         hb_mult = cppi41_channel->hw_ep->out_qh->hb_mult;
> -               else
> +               else {
> +                       if (!cppi41_channel->hw_ep->in_qh)
> +                               dev_err(NULL, "->in_qh is NULL\n");
>                         hb_mult = cppi41_channel->hw_ep->in_qh->hb_mult;
> +               }
>         }
>
>         channel->status = MUSB_DMA_STATUS_BUSY;
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
