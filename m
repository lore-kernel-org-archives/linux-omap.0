From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] cpufreq: ti: Use generic platdev driver
Date: Fri, 16 Sep 2016 16:29:04 -0500
Message-ID: <57DC6420.20706@ti.com>
References: <20160914204137.20346-1-d-gerlach@ti.com>
 <20160915062507.GA30169@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160915062507.GA30169@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,
On 09/15/2016 01:25 AM, Viresh Kumar wrote:
> On 14-09-16, 15:41, Dave Gerlach wrote:
>> Now that the cpufreq-dt-platdev is used to create the cpufreq-dt platform
>> device for all OMAP platforms and the platform code that did it
>> before has been removed, add ti,am33xx and ti,dra7xx to the machine list
>> in cpufreq-dt-platdev which had relied on the removed platform code to do
>> this previously.
>>
>> Fixes: 7694ca6e1d6f ("cpufreq: omap: Use generic platdev driver")
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>
> Any stable trees you want this to be added to ?

I suppose it'll go for 4.7-stable as the change happened in v4.6.

>
>> ---
>>   drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 0bb44d5b5df4..d5e8ba50f8a3 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -68,6 +68,8 @@ static const struct of_device_id machines[] __initconst = {
>>
>>   	{ .compatible = "sigma,tango4" },
>>
>> +	{ .compatible = "ti,am33xx", },
>> +	{ .compatible = "ti,dra7", },
>>   	{ .compatible = "ti,omap2", },
>>   	{ .compatible = "ti,omap3", },
>>   	{ .compatible = "ti,omap4", },
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>

Thanks,
Dave
