From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 3/4] Misc: SRAM: Hack for allowing executable code in SRAM.
Date: Fri, 6 Sep 2013 13:50:27 -0700
Message-ID: <CA+Bv8XZCeQuUvQ3O9VQwC_XUU0R9bEsGBvzPyb34HYe-ZCvK1Q@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
	<1378226665-27090-4-git-send-email-Russ.Dill@ti.com>
	<20130904180638.GC31541@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:52172 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab3IFUu3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 16:50:29 -0400
Received: by mail-ve0-f179.google.com with SMTP id c14so1975220vea.38
        for <linux-omap@vger.kernel.org>; Fri, 06 Sep 2013 13:50:27 -0700 (PDT)
In-Reply-To: <20130904180638.GC31541@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 4, 2013 at 11:06 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Russ Dill <Russ.Dill@ti.com> [130903 09:52]:
>> The generic SRAM mechanism does not ioremap memory in a
>> manner that allows code to be executed from SRAM. There is
>> currently no generic way to request ioremap to return a
>> memory area with execution allowed.
>>
>> Insert a temporary hack for proof of concept on ARM.
>>
>> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
>> ---
>>  drivers/misc/sram.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
>> index 08baaab..e059a23 100644
>> --- a/drivers/misc/sram.c
>> +++ b/drivers/misc/sram.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/genalloc.h>
>>  #include <linux/sram.h>
>>  #include <asm-generic/cacheflush.h>
>> +#include <asm/io.h>
>>
>>  #define SRAM_GRANULARITY     32
>>
>> @@ -138,7 +139,7 @@ static int sram_probe(struct platform_device *pdev)
>>       int ret;
>>
>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -     virt_base = devm_ioremap_resource(&pdev->dev, res);
>> +     virt_base = __arm_ioremap_exec(res->start, resource_size(res), false);
>>       if (IS_ERR(virt_base))
>>               return PTR_ERR(virt_base);
>
> You can get rid of this hack by defining ioremap_exec in
> include/asm-generic/io.h the same way as ioremap_nocache
> is done:
>
> #ifndef ioremap_exec
> #define ioremap_exec ioremap
> #endif
>
> Then the arch that need ioremap_exec can define and
> implement it. Needs to be reviewed on LKML naturally :)

The similar statement for nocache in asm-generic/io.h appears in an
#ifndef CONFIG_MMU block. I think the better example would be
ioremap_wc, which looks like:

#ifndef ARCH_HAS_IOREMAP_WC
#define ioremap_wc ioremap_nocache
#endif

Course, ioremap_exec on ARM has a slight complication since it has an
extra bool nocache argument.
