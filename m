From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND
 flash
Date: Wed, 14 May 2014 12:17:52 +0300
Message-ID: <537334C0.8040109@ti.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>	<CABxcv=nNuMLDCbNimWWR6yBbq3dHV6i87vBu69ZXGcYE-c9bmA@mail.gmail.com>	<20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com> <CABxcv==SGZ1fReXkgT769Z70ek_guMVn6nSK0FFgzjoksLGBrw@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com> <53732896.6060109@ti.com> <53733093.6000904@ti.com> <20980858CB6D3A4BAE95CA194937D5E73EACCDEA@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39843 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbaENJR7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2014 05:17:59 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACCDEA@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

On 05/14/2014 12:09 PM, Gupta, Pekon wrote:
>> From: Quadros, Roger
> [...]
> 
>>>> For now, I'll use GPMC address-space size = 0x380 as it matches with
>>>> actual hardware and is working.
>>>
>>> How did you get 0x380?
>>>
>>> From DRA7 TRM, GPMC address range is 0x5000 0000 : 0x5000 02D0
>>> So the address-space size should be 0x2D4 (as last register@2D0 is 32-bits wide)
>>
>> Sorry for the noise.
>> Just figured out that the register space is not numerically arranged in the TRM.
>>
>> The last register is P GPMC_BCH_RESULT6_i
>> 	0x5000  0308  +  (0x0000   0010  *  i)
>> 	i = 0 to 7
>>
>> So size should be 0x37C.
>>
> Yes, as each {GPMC_BCH_RESULTx_i} group is incremented by 0x10,
> so I aligned the last address to 0x380 boundary. Hope leaving room for
> extra 4 bytes (0x380 - 0x37C) will not matter much?

Functionally it won't matter but it always good to describe the hardware as
accurately as possible and avoid confusion to future developers as to why
extra 4 bytes were used in the device tree.

cheers,
-roger
