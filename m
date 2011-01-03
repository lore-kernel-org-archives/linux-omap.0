From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Mon, 03 Jan 2011 20:07:18 +0300
Message-ID: <4D220246.5020303@mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>	<4D21F3F2.6090302@mvista.com> <20110103163447.GB2911@n2100.arm.linux.org.uk> <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43132 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1ACRIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 12:08:24 -0500
Received: by ewy5 with SMTP id 5so6134582ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 09:08:23 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

Hello.

On 03-01-2011 20:01, Gupta, Ajay Kumar wrote:

>>>> Add support for Texas Instuments Communication Port Programming Interface 4.1
>>>> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.

>>>> At this moment, only the DMA controller and queue manager are supported.
>>>> Support for the buffer manager is lacking but these chips don't have it anyway.

>>>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>>>> Signed-off-by: Sekhar Nori<nsekhar@ti.com>

>>>     Russell, you have recently discarded this patch from your patch
>>> system. Can we know the reason?

>> It was recently discussed with TI, and various people raised concerns
>> about it.  I don't remember the exact details, and I wish they'd raise
>> them with the patch author directly.  It may have been that it's
>> inventing its own API rather than using something like the DMA engine
>> API.

>> Adding linux-omap to try to get a response there.

> Sergei,
> This issue was discussed recently at TI and proposal was to place it to
> drivers/dma folder.

    Note that I have neither time nor inclination to do this work (not do I 
think it's even feasible), so it will have to fall on TI's shoulders...

> Moreover, even Felipe also seems to move other musb
> DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.

    Frankly speaking, I doubt that drivers/dma/ will have place for the purely 
MUSB specific DMA engines such as the named ones (there's no TUSB DMA BTW -- 
it uses OMAP DMA).

> Regards,
> Ajay

WBR, Sergei
