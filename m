From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/3] PM / OPP: Expose _of_get_opp_desc_node as
 dev_pm_opp API
Date: Mon, 31 Oct 2016 16:03:27 -0500
Message-ID: <a8a4253a-8558-c10f-817e-7cd6975b82ce@ti.com>
References: <20161027214131.1725-1-d-gerlach@ti.com>
 <20161027214131.1725-2-d-gerlach@ti.com> <20161028040507.GJ10423@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161028040507.GJ10423@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/27/2016 11:05 PM, Viresh Kumar wrote:
> On 27-10-16, 16:41, Dave Gerlach wrote:
>> Move _of_get_opp_desc_node into include/linux/pm_opp.h and rename it
>> dev_pm_opp_of_get_opp_desc_node to allow other drivers, such as platform
>> OPP and cpufreq drivers, to make use of it.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/base/power/opp/of.c  | 8 ++++----
>>  drivers/base/power/opp/opp.h | 1 -
>>  include/linux/pm_opp.h       | 6 ++++++
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
>> index 5552211e6fcd..215f5a538c78 100644
>> --- a/drivers/base/power/opp/of.c
>> +++ b/drivers/base/power/opp/of.c
>> @@ -198,7 +198,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>>
>>  /* Returns opp descriptor node for a device, caller must do of_node_put() */
>> -struct device_node *_of_get_opp_desc_node(struct device *dev)
>> +struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
>
> Export as well ?
>

Whoops, yes will need to do that. I'll give some time for comments on 
any other patches before sending v3.

Thanks,
Dave
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
