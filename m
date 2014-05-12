From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND flash
Date: Mon, 12 May 2014 11:08:08 +0200
Message-ID: <CABxcv==vS481jyTNpqtWwfWRmeCOYYZc3mR0Cudu0ATHQjEh3w@mail.gmail.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
	<CABxcv=nNuMLDCbNimWWR6yBbq3dHV6i87vBu69ZXGcYE-c9bmA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com>
	<CABxcv==SGZ1fReXkgT769Z70ek_guMVn6nSK0FFgzjoksLGBrw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:59086 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaELJIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 05:08:10 -0400
Received: by mail-wi0-f181.google.com with SMTP id n15so4095794wiw.2
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 02:08:08 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

On Mon, May 12, 2014 at 11:05 AM, Gupta, Pekon <pekon@ti.com> wrote:
>>From: Javier Martinez Canillas [mailto:javier@dowhile0.org]
> [...]
>
>>> Newer platforms have upgraded version of GPMC engine which supports
>>> BCH16 ECC scheme in hardware. Thus the GPMC address space was
>>> expanded to include some extra registers required for BCH16 ECC [2].
>>>
>>>
>>
>>I see and did the GPMC register space became that big to need to map 8KB?
>>
>>Although the smallest unit for ioremap is PAGE_SIZE and using any of
>>these reg sizes:
>>
>>reg = <0x6e000000 0x02d0>;
>>reg = <0x6e000000 0x0400>;
>>reg = <0x6e000000 0x1000>;
>>
>>in practice have the same effect, DTS should describe the hardware and
>>not an implementation detail so I think that we should use only the
>>register size that is defined in the TRM.
>>
> Yes, I agree with you.
> I have fixed this in newer version of the patch and will be sending it soon.
> But this series will only contain updates for new platforms with addition
> of NAND node in DTS, so that this series is not stalled for any reason.
> For fixing existing platform/boards DTS I'll send another series soon.
>

Yes, I agree that fixing existing platforms is a matter of a different
series, I just didn't want to introduce more :-)

> For now, I'll use GPMC address-space size = 0x380 as it matches with
> actual hardware and is working.
>

Perfect, thanks a lot!

>>>
>>> [1] http://www.ti.com/lit/gpn/am3359    (Section 7.4 to 7.4.5)
>>>
>>> [2] http://www.ti.com/lit/gpn/am3359    (Section 7.1 to 7.1.5)
>>> (Though the AM335x address space mentions 0x368 as last address,
>>>  it should be 0x378. I have raised documentation bug for it).
>>>
>>>
>>> with regards, pekon
>>
>>Best regards,
>>Javier
>>
>>[0]: http://lxr.free-electrons.com/source/arch/arm/mm/ioremap.c#L334

Best regards,
Javier
