From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/2] arm: omap: gpmc-smsc911x: minor style fixes
Date: Tue, 26 Apr 2011 17:40:52 +0300
Message-ID: <4DB6D974.6080201@compulab.co.il>
References: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il> <1303397412-24813-2-git-send-email-grinberg@compulab.co.il> <BANLkTikw73F1RBmJC=+Z2msA3Wr7gG3AGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:44624
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753371Ab1DZOk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 10:40:59 -0400
In-Reply-To: <BANLkTikw73F1RBmJC=+Z2msA3Wr7gG3AGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Nishanth,

On 04/26/11 16:45, Menon, Nishanth wrote:

> On Thu, Apr 21, 2011 at 09:50, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> replace "printk(KERN_ERR" by "pr_err("
>> and fix needlessly multi-lined #ifdef
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/mach-omap2/gpmc-smsc911x.c             |   14 +++++++-------
>>  arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    3 +--
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
>> index d30293a..b45efff 100644
>> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
>> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
> minor suggestion: wont using pr_fmt help to reduce the need to add %s,
> __func__ for pr_err through out the file?

I don't understand of what "need" are you talking about.
I don't know of any need to add "%s, __func__" with pr_fmt...
I've added "%s, __func__" as a meter of choice.
IMO, it makes it easier to parse the dmesg output.
If anyone objects it, I can remove them,
but I think both pr_fmt and __func__ are nice here and
way better then "printk(KERN_*" with embedded "smsc911x".

>> @@ -55,7 +55,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>>        gpmc_cfg = board_data;
>>
>>        if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
>> -               printk(KERN_ERR "Failed to request GPMC mem for smsc911x\n");
>> +               pr_err("%s: Failed to request GPMC mem region\n", __func__);
>>                return;
>>        }
>>
>> @@ -63,8 +63,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>>        gpmc_smsc911x_resources[0].end = cs_mem_base + 0xff;
>>
>>        if (gpio_request(gpmc_cfg->gpio_irq, "smsc911x irq") < 0) {
>> -               printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
>> -                               gpmc_cfg->gpio_irq);
>> +               pr_err("%s: Failed to request IRQ GPIO%d\n", __func__,
>> +                      gpmc_cfg->gpio_irq);
>>                goto free1;
>>        }
>>
>> @@ -74,8 +74,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>>        if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
>>                ret = gpio_request(gpmc_cfg->gpio_reset, "smsc911x reset");
>>                if (ret) {
>> -                       printk(KERN_ERR "Failed to request GPIO%d for smsc911x reset\n",
>> -                                       gpmc_cfg->gpio_reset);
>> +                       pr_err("%s: Failed to request reset GPIO%d\n", __func__,
>> +                              gpmc_cfg->gpio_reset);
>>                        goto free2;
>>                }
>>
>> @@ -92,7 +92,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>>                 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
>>                 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
>>        if (!pdev) {
>> -               printk(KERN_ERR "Unable to register smsc911x device\n");
>> +               pr_err("%s: Unable to register platform device\n", __func__);
>>                gpio_free(gpmc_cfg->gpio_reset);
>>                goto free2;
>>        }
>> @@ -104,5 +104,5 @@ free2:
>>  free1:
>>        gpmc_cs_free(gpmc_cfg->cs);
>>
>> -       printk(KERN_ERR "Could not initialize smsc911x\n");
>> +       pr_err("Could not initialize smsc911x\n");
>>  }
>> diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>> index d3f1579..ea6c9c8 100644
>> --- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>> +++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
>> @@ -21,8 +21,7 @@ struct omap_smsc911x_platform_data {
>>        u32     flags;
>>  };
>>
>> -#if defined(CONFIG_SMSC911X) || \
>> -       defined(CONFIG_SMSC911X_MODULE)
>> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
>>
>>  extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
>>
>> --
>> 1.7.3.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

-- 
Regards,
Igor.

