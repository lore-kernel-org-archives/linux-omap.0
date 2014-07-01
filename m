From: Bin Liu <binmlist@gmail.com>
Subject: Re: am335x: linux 3.16-rc3: USB DMA issue
Date: Tue, 1 Jul 2014 10:43:23 -0500
Message-ID: <CADYTM3YkfzjUNrDaPrY_RwtRcstjSJ+o-ST31Z7z70f44-CuUA@mail.gmail.com>
References: <CAGm1_kuA8nYvqHXYbg5kULCujzOYEBW6AAijeQt3yzg_P9=EHg@mail.gmail.com>
	<CAGm1_ksYdfkiSBAsV6Rq2GZ5CBwNbO8An0bzKaknxrnkRLEAXQ@mail.gmail.com>
	<CAAEAJfDaEt0PGhFOs0-Q6W8ogu1aEGMGarnbuBVzZHnuHm4zZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60441 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbaGAPnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 11:43:24 -0400
In-Reply-To: <CAAEAJfDaEt0PGhFOs0-Q6W8ogu1aEGMGarnbuBVzZHnuHm4zZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>

On Tue, Jul 1, 2014 at 10:37 AM, Ezequiel Garc=C3=ADa
<ezequiel@vanguardiasur.com.ar> wrote:
> On 1 July 2014 12:07, Yegor Yefremov <yegorslists@googlemail.com> wro=
te:
> [..]
>>
>> What can be done with these error messages:
>>
>> of_get_named_gpiod_flags: can't parse gpios property of node
>> '/ocp/usb@47400000/usb-phy@47401300[0]'
>> 47401300.usb-phy supply vcc not found, using dummy regulator
>> musb-hdrc musb-hdrc.0.auto: Failed to request rx1.
>> musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status =
-517
>> platform musb-hdrc.0.auto: Driver musb-hdrc requests probe deferral
>> of_get_named_gpiod_flags: can't parse gpios property of node
>> '/ocp/usb@47400000/usb-phy@47401b00[0]'
>> 47401b00.usb-phy supply vcc not found, using dummy regulator
>> musb-hdrc musb-hdrc.1.auto: Failed to request rx1.
>> musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status =
-517
>> platform musb-hdrc.1.auto: Driver musb-hdrc requests probe deferral
>> couldn't find an available UDC
>>
>
> The above are typical deferal messages. Have you tried building
> everything as a module or moving the DMA devicetree node so it's
> probed earlier?
>
> But I'm not sure it's related to the problem you are seeing.

It might be ZLP related. Daniel's patch "dma: cppi41: handle 0-length
packets" might solve it.

-Bin.

> --
> Ezequiel Garc=C3=ADa, VanguardiaSur
> www.vanguardiasur.com.ar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
