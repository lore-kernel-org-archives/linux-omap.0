From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: add clkctrl data dra7 sgx
Date: Tue, 21 Jan 2020 09:33:13 +0200
Message-ID: <3d62b6f6-63ce-f009-84af-a177c7844d46@ti.com>
References: <20191101162719.49781-1-tony@atomide.com>
 <20200106031426.B1B6D21582@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41196 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUHdg (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2020 02:33:36 -0500
In-Reply-To: <20200106031426.B1B6D21582@mail.kernel.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Benoit Parrot <bparrot@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Robert Nelson <robertcnelson@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On 06/01/2020 05:14, Stephen Boyd wrote:
> Quoting Tony Lindgren (2019-11-01 09:27:19)
>> This is similar to what we have for omap5 except the gpu_cm address is
>> different, the mux clocks have one more source option, and there's no
>> divider clock.
>>
>> Note that because of the current dts node name dependency for mapping to
>> clock domain, we must still use "gpu-clkctrl@" naming instead of generic
>> "clock@" naming for the node. And because of this, it's probably best to
>> apply the dts node addition together along with the other clock changes.
>>
>> For accessing the GPU, we also need to configure the interconnect target
>> module for GPU similar to what we have for omap5, I'll send that change
>> separately.
>>
>> Cc: Benoit Parrot <bparrot@ti.com>
>> Cc: "H. Nikolaus Schaller" <hns@goldelico.com>
>> Cc: Robert Nelson <robertcnelson@gmail.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 

Queued up towards 5.6, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
