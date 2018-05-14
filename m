From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 07/11] driver core: Respect all error codes from dev_pm_domain_attach()
Date: Mon, 14 May 2018 20:57:17 +0200
Message-ID: <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org> <20180514151907.GK98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514151907.GK98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 14 May 2018 at 17:19, Tony Lindgren <tony@atomide.com> wrote:
> Ulf,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [180426 09:01]:
>> The limitation of being able to check only for -EPROBE_DEFER from
>> dev_pm_domain_attach() has been removed. Hence let's respect all error
>> codes and bail out accordingly.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/platform.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 8075ddc..9460139 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -572,17 +572,16 @@ static int platform_drv_probe(struct device *_dev)
>>               return ret;
>>
>>       ret = dev_pm_domain_attach(_dev, true);
>> -     if (ret != -EPROBE_DEFER) {
>> -             if (drv->probe) {
>> -                     ret = drv->probe(dev);
>> -                     if (ret)
>> -                             dev_pm_domain_detach(_dev, true);
>> -             } else {
>> -                     /* don't fail if just dev_pm_domain_attach failed */
>> -                     ret = 0;
>> -             }
>> +     if (ret)
>> +             goto out;
>> +
>> +     if (drv->probe) {
>> +             ret = drv->probe(dev);
>> +             if (ret)
>> +                     dev_pm_domain_detach(_dev, true);
>>       }
>>
>> +out:
>>       if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>>               dev_warn(_dev, "probe deferral not supported\n");
>>               ret = -ENXIO;
>> --
>
> Looks like this causes Linux next to not boot for me with device
> probes failing with error -17. So that's at least omaps, looks
> like kernelci has others failing too.

Yep, problem also reported for some Exynos5 platforms.

Omap suffers from the similar problem, because of its SoC specific way
of attaching devices to PM domains.

>
> Reverting for 8c123c14bbba ("driver core: Respect all error codes from
> dev_pm_domain_attach()") fixes the issue for me.
>
> Sounds like something is missing, any ideas?

This should solve the problem:

https://patchwork.kernel.org/patch/10398597/

Kind regards
Uffe
