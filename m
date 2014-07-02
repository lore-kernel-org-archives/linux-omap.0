From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: am335x: linux 3.16-rc3: USB DMA issue
Date: Wed, 2 Jul 2014 15:29:11 +0200
Message-ID: <CAGm1_kutSyFgUwZmQ0ic6PdfVrObmjyUshbUtFZXw3YH2rrwZg@mail.gmail.com>
References: <CAGm1_kuA8nYvqHXYbg5kULCujzOYEBW6AAijeQt3yzg_P9=EHg@mail.gmail.com>
 <CAGm1_ksYdfkiSBAsV6Rq2GZ5CBwNbO8An0bzKaknxrnkRLEAXQ@mail.gmail.com>
 <CAAEAJfDaEt0PGhFOs0-Q6W8ogu1aEGMGarnbuBVzZHnuHm4zZQ@mail.gmail.com> <CADYTM3YkfzjUNrDaPrY_RwtRcstjSJ+o-ST31Z7z70f44-CuUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADYTM3YkfzjUNrDaPrY_RwtRcstjSJ+o-ST31Z7z70f44-CuUA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 1, 2014 at 5:43 PM, Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jul 1, 2014 at 10:37 AM, Ezequiel Garc=C3=ADa
> <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> wrote:
>> On 1 July 2014 12:07, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wr=
ote:
>> [..]
>>>
>>> What can be done with these error messages:
>>>
>>> of_get_named_gpiod_flags: can't parse gpios property of node
>>> '/ocp/usb@47400000/usb-phy@47401300[0]'
>>> 47401300.usb-phy supply vcc not found, using dummy regulator
>>> musb-hdrc musb-hdrc.0.auto: Failed to request rx1.
>>> musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status=
 -517
>>> platform musb-hdrc.0.auto: Driver musb-hdrc requests probe deferral
>>> of_get_named_gpiod_flags: can't parse gpios property of node
>>> '/ocp/usb@47400000/usb-phy@47401b00[0]'
>>> 47401b00.usb-phy supply vcc not found, using dummy regulator
>>> musb-hdrc musb-hdrc.1.auto: Failed to request rx1.
>>> musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status=
 -517
>>> platform musb-hdrc.1.auto: Driver musb-hdrc requests probe deferral
>>> couldn't find an available UDC
>>>
>>
>> The above are typical deferal messages. Have you tried building
>> everything as a module or moving the DMA devicetree node so it's
>> probed earlier?
>>
>> But I'm not sure it's related to the problem you are seeing.
>
> It might be ZLP related. Daniel's patch "dma: cppi41: handle 0-length
> packets" might solve it.

Have applied the patch, but it didn't help. Compiling the drivers as a
module help for now.

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
