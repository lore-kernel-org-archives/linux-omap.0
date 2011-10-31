From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: Re: [v2 1/2] usb: musb: omap2+: fix context api's
Date: Sun, 30 Oct 2011 23:48:10 -0700
Message-ID: <CAFm5wm2nAMLM4qDw2yiJyQ3=vb_5tqqO+rUG0a3cd94JLE018w@mail.gmail.com>
References: <1315412364-21384-1-git-send-email-vikram.pandita@ti.com>
 <1315412364-21384-2-git-send-email-vikram.pandita@ti.com> <20111010060808.GD31707@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111010060808.GD31707-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 9, 2011 at 11:08 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, Sep 07, 2011 at 09:19:23AM -0700, Vikram Pandita wrote:
>> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>>
>> RxFifoSz, TxFifoSz, RxFifoAddr, TxFifoAddr
>> are all indexed registers.
>>
>> So before doing a context save or restore, INDEX register
>> should be set, then only one gets to the right register offset.
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>
> applied, thanks

thanks.

>
> (sorry for the long delay)

Late is better than never :-)

>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
