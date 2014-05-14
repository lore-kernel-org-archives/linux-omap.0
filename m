From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND flash
Date: Wed, 14 May 2014 11:23:36 +0200
Message-ID: <CABxcv=nR7S2oV95iPLCq64XGwc_cQ_3WGOpL4=Q5irEaRO8JvA@mail.gmail.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
	<CABxcv=nNuMLDCbNimWWR6yBbq3dHV6i87vBu69ZXGcYE-c9bmA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com>
	<CABxcv==SGZ1fReXkgT769Z70ek_guMVn6nSK0FFgzjoksLGBrw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com>
	<53732896.6060109@ti.com>
	<53733093.6000904@ti.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACCDEA@DBDE04.ent.ti.com>
	<537334C0.8040109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39280 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbaENJXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 05:23:38 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so1633781wev.33
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 02:23:36 -0700 (PDT)
In-Reply-To: <537334C0.8040109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

On Wed, May 14, 2014 at 11:17 AM, Roger Quadros <rogerq@ti.com> wrote:
> On 05/14/2014 12:09 PM, Gupta, Pekon wrote:
>>> From: Quadros, Roger
>> [...]
>>
>>>>> For now, I'll use GPMC address-space size = 0x380 as it matches with
>>>>> actual hardware and is working.
>>>>
>>>> How did you get 0x380?
>>>>
>>>> From DRA7 TRM, GPMC address range is 0x5000 0000 : 0x5000 02D0
>>>> So the address-space size should be 0x2D4 (as last register@2D0 is 32-bits wide)
>>>

arch/arm/boot/dts/omap3.dtsi is using reg = <0x6e000000 0x02d0> so
that should be fixed to 0x2d4 too.

>>> Sorry for the noise.
>>> Just figured out that the register space is not numerically arranged in the TRM.
>>>
>>> The last register is P GPMC_BCH_RESULT6_i
>>>      0x5000  0308  +  (0x0000   0010  *  i)
>>>      i = 0 to 7
>>>
>>> So size should be 0x37C.
>>>
>> Yes, as each {GPMC_BCH_RESULTx_i} group is incremented by 0x10,
>> so I aligned the last address to 0x380 boundary. Hope leaving room for
>> extra 4 bytes (0x380 - 0x37C) will not matter much?
>
> Functionally it won't matter but it always good to describe the hardware as
> accurately as possible and avoid confusion to future developers as to why
> extra 4 bytes were used in the device tree.
>

I don't think that aligning makes too much sense since in practice
ioremap() will map a complete page anyways so if we are not using
0x1000 (e.g: PAGE_SIZE on ARM) is just because we want the DT to
strictly model what the hardware registers address size really is.

Best regards,
Javier
