From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] clk, ti, LLVMLinux: Move __init outside of type definition
Date: Fri, 26 Sep 2014 17:57:56 -0700
Message-ID: <54260B94.2050502@converseincode.com>
References: <1411777908-16016-1-git-send-email-behanw@converseincode.com> <20140927005506.GB25432@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62601 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaI0A6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2014 20:58:00 -0400
Received: by mail-pd0-f174.google.com with SMTP id g10so13161674pdj.5
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2014 17:57:59 -0700 (PDT)
In-Reply-To: <20140927005506.GB25432@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: mturquette@linaro.org, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 09/26/14 17:55, Felipe Balbi wrote:
> On Fri, Sep 26, 2014 at 05:31:48PM -0700, Behan Webster wrote:
>> As written, the __init for ti_clk_get_div_table is in the middle of the return
>> type.
>>
>> The gcc documentation indicates that section attributes should be added to the
>> end of the function declaration:
>>
>>    extern void foobar (void) __attribute__ ((section ("bar")));
>>
>> However gcc seems to be very permissive with where attributes can be placed.
>> clang on the other hand isn't so permissive, and fails if you put the section
>> definition in the middle of the return type:
>>
>> drivers/clk/ti/divider.c:298:28: error: expected ';' after struct
>> static struct clk_div_table
>>                             ^
>>                             ;
>> drivers/clk/ti/divider.c:298:1: warning: 'static' ignored on this
>>        declaration [-Wmissing-declarations]
>> static struct clk_div_table
>> ^
>> drivers/clk/ti/divider.c:299:9: error: type specifier missing,
>>        defaults to 'int' [-Werror,-Wimplicit-int]
>> __init *ti_clk_get_div_table(struct device_node *node)
>> ~~~~~~  ^
>> drivers/clk/ti/divider.c:345:9: warning: incompatible pointer types
>>        returning 'struct clk_div_table *' from a function with result type 'int *' [-Wincompatible-pointer-types]
>>          return table;
>>                 ^~~~~
>> drivers/clk/ti/divider.c:419:9: warning: incompatible pointer types
>>        assigning to 'const struct clk_div_table *' from 'int *' [-Wincompatible-pointer-types]
>>          *table = ti_clk_get_div_table(node);
>>                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 3 warnings and 2 errors generated.
>>
>> By convention, most of the kernel code puts section attributes between the
>> return type and function name. In the case where the return type is a pointer,
>> it's important to place the '*' on left of the __init.
>>
>> This updated code works for both gcc and clang.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Reviewed-by: Mark Charlebois <charlebm@gmail.com>
> makes sense to me:
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
Thank you.

> I wonder if we should add this a Sparse or Coccinelle rule.
+1

I'm hoping it can be added to checkpatch as well.

Behan

-- 
Behan Webster
behanw@converseincode.com

