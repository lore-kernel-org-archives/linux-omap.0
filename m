From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
Date: Fri, 21 Sep 2012 08:30:28 +0200
Message-ID: <CAORVsuXS=zk6SEqo=qhyaAFyYQbhLA8CY9TTMMhEQtMZf7p21Q@mail.gmail.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
	<1348152453-30532-3-git-send-email-j-pihet@ti.com>
	<20120920221504.GK28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46719 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2IUGaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 02:30:30 -0400
Received: by lbbgj3 with SMTP id gj3so3426692lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 23:30:28 -0700 (PDT)
In-Reply-To: <20120920221504.GK28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbou@mail.ru>, Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Tony,

On Fri, Sep 21, 2012 at 12:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Jean Pihet <jean.pihet@newoldbits.com> [120920 07:48]:
>> --- a/drivers/power/avs/smartreflex.c
>> +++ b/drivers/power/avs/smartreflex.c
>> @@ -131,14 +131,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
>>       struct clk *sys_ck;
>>       u32 sys_clk_speed;
>>
>> -     if (cpu_is_omap34xx())
>> -             sys_ck = clk_get(NULL, "sys_ck");
>> -     else
>> -             sys_ck = clk_get(NULL, "sys_clkin_ck");
>> +     sys_ck = clk_get(NULL, sr->fck_name);
>>
>>       if (IS_ERR(sys_ck)) {
>> -             dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
>> -                     __func__);
>> +             dev_err(&sr->pdev->dev, "%s: unable to get smartreflex fck %s\n",
>> +                     __func__, sr->fck_name);
>>               return;
>>       }
>>
>
> You should be able to make this even simpler and not have to pass
> the clock name around at all. Just do:
>
> syc_ck = clk_get(NULL, "fck);
> ...
The problem is that the system has multiple instances of the
smartreflex module, each having its own fck. On OMAP3/4 the fck's are
derived from sys_clk via muxes and latches.
The proposed code uses the fck's as defined in the .main_clk field of
the hwmod entries, so that it takes the muxes and latches into account
and also has a consistent clock naming.

> In the driver, and add the necessary entries to the clock alias
> table. That way it's up to the SoC to set up the necessary clocks
> and the driver stays generic.
Got it. The only solution would be to use an unique fck for all
smartreflex modules in all configurations. Is that acceptable?

>
>> @@ -1049,6 +1039,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>>
>>       list_del(&sr_info->node);
>>       iounmap(sr_info->base);
>> +     kfree(sr_info->fck_name);
>>       kfree(sr_info->name);
>>       kfree(sr_info);
>>       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> Then there's no need for the kfree of the fck_name
> either.
>
> There's an example of a similar patch done for twl-core.c as commit
> defa6be1 (mfd: Fix compile for twl-core.c by removing cpu_is_omap usage)
> in current linux next, except with smartreflex you probably don't
> need to do any of the platform_device_alloc trickery like twl-core.c
> neded to get around using the i2c numbers as names.

Thanks!

Regards,
Jean

>
> Regards,
>
> Tony
