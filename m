From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: linux 3.16-rc3: USB DMA issue
Date: Tue, 8 Jul 2014 11:42:17 +0200
Message-ID: <CAGm1_ktB8ZhEPDsCaGvtaOiG206D2xYzmVrNYHVXQQgN1TH3KQ@mail.gmail.com>
References: <CAGm1_kuA8nYvqHXYbg5kULCujzOYEBW6AAijeQt3yzg_P9=EHg@mail.gmail.com>
 <CAGm1_ksYdfkiSBAsV6Rq2GZ5CBwNbO8An0bzKaknxrnkRLEAXQ@mail.gmail.com>
 <CAAEAJfDaEt0PGhFOs0-Q6W8ogu1aEGMGarnbuBVzZHnuHm4zZQ@mail.gmail.com> <CAGm1_kvTfPNcbp5M1OMWo-sfyBSd-tKm5wtqEVdTnswioajSBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47733 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbaGHJmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 05:42:38 -0400
In-Reply-To: <CAGm1_kvTfPNcbp5M1OMWo-sfyBSd-tKm5wtqEVdTnswioajSBQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>

On Wed, Jul 2, 2014 at 3:28 PM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> On Tue, Jul 1, 2014 at 5:37 PM, Ezequiel Garc=C3=ADa
> <ezequiel@vanguardiasur.com.ar> wrote:
>> On 1 July 2014 12:07, Yegor Yefremov <yegorslists@googlemail.com> wr=
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
> Compiling as a module helped. Thanks.

I experience another issue, that happens either in monolithic kernel
or as modules. In 2-4% of power cycles the hub chip connected to USB0
won't be detected. So far I couldn't find any error messages. Any
idea?

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
