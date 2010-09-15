From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in musb_g_tx
Date: Wed, 15 Sep 2010 17:06:46 +0400
Message-ID: <4C90C4E6.9000703@ru.mvista.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, balbi@ti.com, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

Ming Lei wrote:
> Hi All,

> In another thread, Sergei pointed out there is a ZLP issue in musb_g_tx:

> Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> Hello.

>> On 15-09-2010 14:05, Felipe Balbi wrote:

>>>> I didn't say it was duplicate for DMA, just too late.

>>> how come ? we need to send ZLP before giving back the request.

>>     Well, look at the code ionce again. We need to send ZLP *after*
>> request->actual == request->length, but as the check is inserted
>> after the ZLP send, ZLP *may* be sent once the first DMA completes,
>> not the last.

>> WBR, Sergei

> balbi also confirmed that is is really a problem.

> I also have two related questions below for the problem:

> 1),  why is the check for "is_dma" needed here?

>       if (is_dma || request->actual == request->length) {
>            ....
>       }

    I'm not sure -- it seems erratic.

> 2), why is a zlp needed in the case below?
> 
>       #ifdef CONFIG_USB_INVENTRA_DMA
>                   || (is_dma && (!dma->desired_mode ||
>                      (request->actual & (musb_ep->packet_sz - 1))))
>      #endif

> Seems no request->zero is set to ask for zlp explicitly in
> the case above.

    This is not for ZLP -- this is here to set TXPktRdy for the last short 
packet in the Inventra DMA mode 0 that doesn't set TXPktRdy in such case.

> IMO, it is not difficult to give a good fix for the ZLP problem
> if the two questions are clear.

WBR, Sergei
