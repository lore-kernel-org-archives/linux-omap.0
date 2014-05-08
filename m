From: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Thu, 8 May 2014 14:00:36 -0300
Message-ID: <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
	<535F5BA5.6000903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:62276 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbaEHRAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 13:00:36 -0400
Received: by mail-yk0-f172.google.com with SMTP id 79so2385809ykr.3
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2014 10:00:36 -0700 (PDT)
In-Reply-To: <535F5BA5.6000903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hi George,

On 29 April 2014 04:58, George Cherian <george.cherian@ti.com> wrote:
> On 4/29/2014 11:49 AM, Yegor Yefremov wrote:
>>
>> On Thu, Apr 24, 2014 at 11:11 PM, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>>
>>> The DMA controller is needed for the USB controller to be correctly
>>> registered. Therefore, if the DMA node is located at the end an
>>> unecessary
>>> probe deferral is produced systematically.
>>>
>>> This is easily fixed by moving the node at the beggining of the chi=
ld
>>> list,
>>> so it's probed first.
>
> This will give issues on module removal.
> Since we use device_for_each_child in remove patch, it will try to re=
move
> cppi dma controller, while the channel
> is still in use by musb node.
>

OK, this seems confusing: are you sure module removal works?

Doing this simple test on v3.15-rcN:

$ modprobe musb_dsps
$ modprobe musb_am335x
$ modprobe musb_am335x -r

And the kernel blows up :-(

I've been debugging this and I think we simply cannot support removal
of the musb_am335x
module.

Had this ever worked before?
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
