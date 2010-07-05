From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: multipath mux question
Date: Mon, 5 Jul 2010 14:49:22 +0300
Message-ID: <AANLkTinuFnpTyMJaMLLulio2hmGHKfL_6VkJogsV_nDa@mail.gmail.com>
References: <AANLkTikb2w3is46Gw-r22F9n2Ockx5rzOWHGo49cnQ8G@mail.gmail.com>
	<20100705073642.GB15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50413 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab0GELtY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 07:49:24 -0400
Received: by yxi11 with SMTP id 11so659485yxi.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Jul 2010 04:49:23 -0700 (PDT)
In-Reply-To: <20100705073642.GB15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jul 5, 2010 at 10:36 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [100703 00:21]:
>> Hi,
>>
>> on OMAP3 CBB package GPIO126 can be muxed on 2 pins: mmc1_dat4 and
>> cam_strobe. On pandora mmc1_dat4 is connected to mmc1 write protect,
>> this makes omap2_mmc_mux() call omap_mux_init_gpio() on GPIO126, which
>> muxes both pins and warns:
>> mux: Multiple gpio paths for gpio126
>
> OK.
>
>> This results in unusable GPIO. I wonder how should I handle this,
>> perhaps overriding mux by calling omap_mux_init_signal() after
>> omap2_hsmmc_init() call? Or maybe omap_mux_init_gpio() should be
>> patched not to set up GPIOs if it encounters multiple paths?
>
> To me the safest route is the second option you suggest where
> we refuse to mux GPIO pins that have multiple outputs.
>
> We should just print a warning and return an error. Then we should
> also start checking the return values for omap_mux_init_gpio
> now that the code is converted over to use the new mux code.

Hm, not sure about return checking, what omap2_mmc_mux() can do when
it sees omap_mux_init_gpio failing because of that inevitable gpio126
multipath error?

> If you do a patch, please do it against omap for-next branch
> as omap_mux_init_gpio has a pending patch for MUXABLE_GPIO_MODE3.

ok
