From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 15/15] staging: omap-thermal: update clock prepare count
Date: Wed, 27 Feb 2013 06:51:18 -0400
Message-ID: <512DE526.2050105@ti.com>
References: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com> <1361919218-9788-16-git-send-email-eduardo.valentin@ti.com> <20130227053523.14870.20885@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130227053523.14870.20885@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Mike,

On 27-02-2013 01:35, Mike Turquette wrote:
> Quoting Eduardo Valentin (2013-02-26 14:53:38)
>> This patch changes the clock management code to also update
>> the clock prepare counter, this way we won't skip the enable/disable
>> operation due to prepare dependencies.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>
> Hi Eduardo,
>
> I didn't look through the other patches in this series (or even the
> existing driver that is merged).  With that said, I have a question:
> does this driver aggressively call clk_enable/clk_disable in call sites
> other than those listed in this patch?

Not really, no. The only places it calls clk_enable/disable are those 
listed below. Idea is that we want to keep the sensor running all the 
time. There should come another patch to cover for core idle, which in 
that case, this driver must idle the sensor, and therefor gate the 
clock, otherwise core won't idle, on some OMAP versions.

>
> If so it might be a good idea to call clk_prepare_enable and
> clk_disable_unprepare in those location.  Of course only call it if the
> context can sleep (e.g. not an interrupt handler).

Ok. For now at least it is not the case.

>
> If the driver doesn't aggressively call enable/disable elsewhere than
> you can disregard my message ;-)

hheeh, alright:-)

thanks for your comment.

>
> Regards,
> Mike
>
>> ---
>>   drivers/staging/omap-thermal/omap-bandgap.c |   10 +++++-----
>>   1 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
>> index 83f74f4..d4a3788 100644
>> --- a/drivers/staging/omap-thermal/omap-bandgap.c
>> +++ b/drivers/staging/omap-thermal/omap-bandgap.c
>> @@ -943,7 +943,7 @@ int omap_bandgap_probe(struct platform_device *pdev)
>>
>>          bg_ptr->clk_rate = clk_rate;
>>          if (OMAP_BANDGAP_HAS(bg_ptr, CLK_CTRL))
>> -               clk_enable(bg_ptr->fclock);
>> +               clk_prepare_enable(bg_ptr->fclock);
>>
>>
>>          mutex_init(&bg_ptr->bg_mutex);
>> @@ -1013,7 +1013,7 @@ int omap_bandgap_probe(struct platform_device *pdev)
>>
>>   disable_clk:
>>          if (OMAP_BANDGAP_HAS(bg_ptr, CLK_CTRL))
>> -               clk_disable(bg_ptr->fclock);
>> +               clk_disable_unprepare(bg_ptr->fclock);
>>   put_clks:
>>          clk_put(bg_ptr->fclock);
>>          clk_put(bg_ptr->div_clk);
>> @@ -1044,7 +1044,7 @@ int omap_bandgap_remove(struct platform_device *pdev)
>>          omap_bandgap_power(bg_ptr, false);
>>
>>          if (OMAP_BANDGAP_HAS(bg_ptr, CLK_CTRL))
>> -               clk_disable(bg_ptr->fclock);
>> +               clk_disable_unprepare(bg_ptr->fclock);
>>          clk_put(bg_ptr->fclock);
>>          clk_put(bg_ptr->div_clk);
>>
>> @@ -1143,7 +1143,7 @@ static int omap_bandgap_suspend(struct device *dev)
>>          omap_bandgap_power(bg_ptr, false);
>>
>>          if (OMAP_BANDGAP_HAS(bg_ptr, CLK_CTRL))
>> -               clk_disable(bg_ptr->fclock);
>> +               clk_disable_unprepare(bg_ptr->fclock);
>>
>>          return err;
>>   }
>> @@ -1153,7 +1153,7 @@ static int omap_bandgap_resume(struct device *dev)
>>          struct omap_bandgap *bg_ptr = dev_get_drvdata(dev);
>>
>>          if (OMAP_BANDGAP_HAS(bg_ptr, CLK_CTRL))
>> -               clk_enable(bg_ptr->fclock);
>> +               clk_prepare_enable(bg_ptr->fclock);
>>
>>          omap_bandgap_power(bg_ptr, true);
>>
>> --
>> 1.7.7.1.488.ge8e1c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
