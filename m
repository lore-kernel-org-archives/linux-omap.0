From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
Date: Wed, 7 Sep 2016 10:04:37 -0500
Message-ID: <57D02C85.7020300@ti.com>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-3-d-gerlach@ti.com> <20160907052053.GO27345@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160907052053.GO27345@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/07/2016 12:20 AM, Viresh Kumar wrote:
> On 31-08-16, 21:53, Dave Gerlach wrote:
>> Some TI SoCs, like those in the AM335x, AM437x, DRA7x, and AM57x families,
>> have different OPPs available for the MPU depending on which specific
>> variant of the SoC is in use. This can be determined through use of the
>> revision and an eFuse register present in the silicon. Introduce a
>> ti-cpufreq driver that can read the aformentioned values and provide
>> them as version matching data to the opp framework. Through this the
>> opp-supported-hw dt binding that is part of the operating-points-v2
>> table can be used to indicate availability of OPPs for each device.
>>
>> This driver also creates the "cpufreq-dt" platform_device after passing
>> the version matching data to the OPP framework so that the cpufreq-dt
>> handles the actual cpufreq implementation. Even without the necessary
>> data to pass the version matching data the driver will still create this
>> device to maintain backwards compatibility with operating-points v1
>> tables.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>> ---
>> v1->v2:
>> 	- Convert to module_platform_driver to match against new compatibles
>> 	  in patch 1
>> 	- Cleaned up some bit shifts
>> 	- of_property_read_u32_array used rather than reading values individually
>>
>>   drivers/cpufreq/Kconfig.arm  |  11 ++
>>   drivers/cpufreq/Makefile     |   1 +
>>   drivers/cpufreq/ti-cpufreq.c | 308 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 320 insertions(+)
>>   create mode 100644 drivers/cpufreq/ti-cpufreq.c
>
> I am wondering if we should start writing OPP drivers instead. As this
> patch doesn't have anything to do with cpufreq really :)
>
> But its fine for now..
>
>> +static const struct of_device_id ti_cpufreq_of_match[] = {
>> +	{ .compatible = "operating-points-v2-ti-am3352-cpu",
>> +	  .data = &am3x_soc_data, },
>> +	{ .compatible = "operating-points-v2-ti-am4372-cpu",
>> +	  .data = &am4x_soc_data, },
>> +	{ .compatible = "operating-points-v2-ti-dra7-cpu",
>> +	  .data = &dra7_soc_data },
>
> You should be using your SoC compatible strings here. OPP compatible
> property isn't supposed to be (mis)used for this purpose.
>

Referring to my comments in patch 1, what if we end up changing the 
bindings based on DT maintainer comments? We will have these compatible 
strings, and at that point is it acceptable to match against them? Or is 
it still better to match to SoC compatibles? I think it makes sense to 
just probe against these.

Regards,
Dave
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
