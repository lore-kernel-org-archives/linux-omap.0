From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v6 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Fri, 16 May 2014 19:34:10 +0200
Message-ID: <CABxcv==TtKytbj6d8Pyq_Uyy8rw43fayqxF5t7nsovgxvnQ+7w@mail.gmail.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
	<1400238230-26357-2-git-send-email-pekon@ti.com>
	<20140516115736.GA684@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:61033 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402AbaEPReL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 13:34:11 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so5185829wgg.6
        for <linux-omap@vger.kernel.org>; Fri, 16 May 2014 10:34:10 -0700 (PDT)
In-Reply-To: <20140516115736.GA684@arch.cereza>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Pekon Gupta <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hello Ezequiel,

On Fri, May 16, 2014 at 1:57 PM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> Hello Pekon,
>
> On 16 May 04:33 PM, Pekon Gupta wrote:
> [..]
>> +             gpmc,wait-pin = <0>;
>> +             gpmc,wait-on-read;
>> +             gpmc,wait-on-write;
>
> Thanks for adding the wait-pin property. I think the other boards also
> needs this change. Javier, do you have a IGEP Aquila with NAND to try?
>

I do have an IGEP aquila with NAND so I can give it a try. I won't be
able to do this until Monday though. Hopefully by then Pekon would
have already sent his patch to set dev_ready=true.

Do you have any specific thing you want me to test? or just a nandtest run?

> Pekon, have you noticed that there's no devicetree property to enable
> ready/busy? In other words, the NAND driver dev_ready field will never
> be true when probed from DT.
>
> --
> Ezequiel Garcia, VanguardiaSur
> www.vanguardiasur.com.ar

Best regards,
Javier
