From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk, ti, LLVMLinux: Move __init outside of type definition
Date: Mon, 29 Sep 2014 14:44:47 +0300
Message-ID: <5429462F.7090702@ti.com>
References: <1411777908-16016-1-git-send-email-behanw@converseincode.com> <20140927005506.GB25432@saruman> <54260B94.2050502@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54260B94.2050502@converseincode.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Behan Webster <behanw@converseincode.com>, balbi@ti.com
Cc: mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/27/2014 03:57 AM, Behan Webster wrote:
> On 09/26/14 17:55, Felipe Balbi wrote:
>> On Fri, Sep 26, 2014 at 05:31:48PM -0700, Behan Webster wrote:
>>> As written, the __init for ti_clk_get_div_table is in the middle of
>>> the return
>>> type.
>>>
>>> The gcc documentation indicates that section attributes should be
>>> added to the
>>> end of the function declaration:
>>>
>>>    extern void foobar (void) __attribute__ ((section ("bar")));
>>>
>>> However gcc seems to be very permissive with where attributes can be
>>> placed.
>>> clang on the other hand isn't so permissive, and fails if you put the
>>> section
>>> definition in the middle of the return type:
>>>
>>> drivers/clk/ti/divider.c:298:28: error: expected ';' after struct
>>> static struct clk_div_table
>>>                             ^
>>>                             ;
>>> drivers/clk/ti/divider.c:298:1: warning: 'static' ignored on this
>>>        declaration [-Wmissing-declarations]
>>> static struct clk_div_table
>>> ^
>>> drivers/clk/ti/divider.c:299:9: error: type specifier missing,
>>>        defaults to 'int' [-Werror,-Wimplicit-int]
>>> __init *ti_clk_get_div_table(struct device_node *node)
>>> ~~~~~~  ^
>>> drivers/clk/ti/divider.c:345:9: warning: incompatible pointer types
>>>        returning 'struct clk_div_table *' from a function with result
>>> type 'int *' [-Wincompatible-pointer-types]
>>>          return table;
>>>                 ^~~~~
>>> drivers/clk/ti/divider.c:419:9: warning: incompatible pointer types
>>>        assigning to 'const struct clk_div_table *' from 'int *'
>>> [-Wincompatible-pointer-types]
>>>          *table = ti_clk_get_div_table(node);
>>>                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 3 warnings and 2 errors generated.
>>>
>>> By convention, most of the kernel code puts section attributes
>>> between the
>>> return type and function name. In the case where the return type is a
>>> pointer,
>>> it's important to place the '*' on left of the __init.
>>>
>>> This updated code works for both gcc and clang.
>>>
>>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>>> Reviewed-by: Mark Charlebois <charlebm@gmail.com>
>> makes sense to me:
>>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Thank you.
>
>> I wonder if we should add this a Sparse or Coccinelle rule.
> +1
>
> I'm hoping it can be added to checkpatch as well.
>
> Behan
>

Thanks, patch applied to for-v3.18/ti-clk-drv.

-Tero
