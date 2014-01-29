From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [BISECTED] OMAP: DSS: clk rate mismatch
Date: Wed, 29 Jan 2014 20:52:22 +0200
Message-ID: <52E94DE6.9050806@gmail.com>
References: <52E697C0.6000202@gmail.com> <52E7614E.8010903@ti.com> <52E76EE0.2060006@ti.com> <52E7F451.7040708@gmail.com> <52E8E643.60408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52E8E643.60408@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, pavel@ucw.cz, chf.fritz@googlemail.com, Tero Kristo <t-kristo@ti.com>, nm@ti.com
List-Id: linux-omap@vger.kernel.org



On 29.01.2014 13:30, Tomi Valkeinen wrote:
> On 2014-01-28 20:17, Ivaylo Dimitrov wrote:
>>
>>
>> On 28.01.2014 10:48, Tomi Valkeinen wrote:
>>
>>> I made a somewhat hacky quickfix for beagle. Applying that and the
>>> clk-divider from the link above makes things work for me. However, as I
>>> said, the issue with n900 might be different, but it'd be interesting to
>>> hear if it has any effect.
>>>
>>>    Tomi
>>>
>>
>> Applying those 2 patches doesn't help, still get exactly the same warning.
>>
>> Find attached my clk_summary (with my hacky patch applied, otherwise I
>> cannot boot the device)
>
> Can you try this one:
>
>  From e511789f7be00beeeee0712910c60a57c51b2705 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Wed, 29 Jan 2014 13:28:53 +0200
> Subject: [PATCH] clkoutx2 fix
>
> ---
>   arch/arm/mach-omap2/cclock3xxx_data.c |  7 +++++++
>   arch/arm/mach-omap2/dpll3xxx.c        | 20 ++++++++++++++++++++
>   2 files changed, 27 insertions(+)
>

Yep, that one fixes the problem. Thanks!

Now I only need to find why maemo is 10 times slower with linux-next 
compared to 3.13-rc7, but that is another story :).

Ivo
