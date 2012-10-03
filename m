From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Wed, 3 Oct 2012 20:19:28 +0200
Message-ID: <CAORVsuUCwGYjUjAuxZQb+en9SLE066OFJ3AOgSQou7JEyu5cjg@mail.gmail.com>
References: <1349279277-7634-1-git-send-email-j-pihet@ti.com>
	<1349279277-7634-2-git-send-email-j-pihet@ti.com>
	<20121003170059.GD4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39084 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab2JCSTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 14:19:30 -0400
Received: by lbon3 with SMTP id n3so6485917lbo.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 11:19:29 -0700 (PDT)
In-Reply-To: <20121003170059.GD4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbou@mail.ru>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Tony,

On Wed, Oct 3, 2012 at 7:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [121003 08:48]:
>> @@ -1036,8 +1036,8 @@ static struct omap_clk am33xx_clks[] = {
>>       CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
>>       CLK("NULL",     "mmc2_fck",             &mmc2_fck,      CK_AM33XX),
>>       CLK(NULL,       "mmu_fck",              &mmu_fck,       CK_AM33XX),
>> -     CLK(NULL,       "smartreflex0_fck",     &smartreflex0_fck,      CK_AM33XX),
>> -     CLK(NULL,       "smartreflex1_fck",     &smartreflex1_fck,      CK_AM33XX),
>> +     CLK(NULL,       "smartreflex.0",        &smartreflex_mpu_fck,   CK_AM33XX),
>> +     CLK(NULL,       "smartreflex.1",        &smartreflex_core_fck,  CK_AM33XX),
>>       CLK(NULL,       "timer1_fck",           &timer1_fck,    CK_AM33XX),
>>       CLK(NULL,       "timer2_fck",           &timer2_fck,    CK_AM33XX),
>>       CLK(NULL,       "timer3_fck",           &timer3_fck,    CK_AM33XX),
>
> I think this should be something like this instead:
>
>         CLK("smartreflex.0",    "fck",  &smartreflex_mpu_fck,   CK_AM33XX),
>         CLK("smartreflex.1",    "fck",  &smartreflex_core_fck,  CK_AM33XX),
>
> Where the first one is the dev name, the second one is the
> alias you want to use in the client driver?
Ok, thanks for the suggestion.

It works however I get a ' smartreflex.0: alias fck already exists'
warning at boot, coming from _add_hwmod_clocks_clkdev (called from
omap_device_alloc).
Since an "fck" is implicitly added for every device (in
_add_hwmod_clocks_clkdev) I replaced "fck" in the alias definition by
NULL but the warning is still present.

What do you think? /me dives into the omap_device code for details...

> Regards,
>
> Tony

Thanks,
Jean
