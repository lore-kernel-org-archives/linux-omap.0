From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clk: ti: fix linker error with !SOC_OMAP4
Date: Thu, 20 Apr 2017 17:06:46 +0200
Message-ID: <CAK8P3a2=pDP7-b4njRo9KKa-JAueTp8O=stmyMz68-Piy__UKQ@mail.gmail.com>
References: <20170419214318.1605787-1-arnd@arndb.de> <9df5f73d-3e3a-ee33-1b75-c14a1a707ad9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <9df5f73d-3e3a-ee33-1b75-c14a1a707ad9@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Richard Watts <rrw@kynesim.co.uk>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 20, 2017 at 4:57 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On 20/04/17 00:43, Arnd Bergmann wrote:
>>
>> When none of the OMAP4-generation SoCs are enabled, we run into a link
>> error for am43xx/am43xx:
>>
>> drivers/clk/ti/dpll.o: In function `of_ti_am3_dpll_x2_setup':
>> dpll.c:(.init.text+0xd8): undefined reference to `clkhwops_omap4_dpllmx'
>>
>> This is easily fixed by adding another #ifdef.
>>
>> While looking at the code, I also spotted another problem with the
>> assignment of hw_ops variable that is not used again later. I'm
>> changing this to setting clk_hw->ops instead, which I guess is what
>> was intended here.
>
>
> Good catch... It seems the corner case is masked in the testing I did
> locally so far.
>
>>
>> Fixes: 0565fb168d63 ("clk: ti: dpll: move omap3 DPLL functionality to
>> clock driver")
>
>
> However, I believe the fixes tag should point to this one in linux-next:
>
> commit 473adbf4e02857a6b78dfb3d9fcf752638bbadb9
> Author: Tero Kristo <t-kristo@ti.com>
> Date:   Thu Feb 9 11:25:28 2017 +0200
>
>     clk: ti: dpll44xx: fix clksel register initialization

Ah, right.

> Other than that:
>
> Acked-by: Tero Kristo <t-kristo@ti.com>

Do you want me to resend, or can you forward the patch with the
fixed fixes line?

     Arnd
