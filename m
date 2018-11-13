From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v3] cpufreq: ti-cpufreq: Only register platform_device
 when supported
Date: Tue, 13 Nov 2018 13:14:15 -0600
Message-ID: <c93fb7a9-88ad-d634-18ff-088d146637ce@ti.com>
References: <20181113173912.27643-1-d-gerlach@ti.com>
 <20181113175853.GN13311@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113175853.GN13311@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 11/13/2018 11:58 AM, Johan Hovold wrote:
> On Tue, Nov 13, 2018 at 11:39:12AM -0600, Dave Gerlach wrote:
>> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
>> the driver to probe on any platforms where the driver is built in.
>> However, this should only happen on platforms that actually can make use
>> of the driver. There is already functionality in place to match the
>> SoC compatible so let's factor this out into a separate call and
>> make sure we find a match before creating the ti-cpufreq platform device.
>>
>> Reviewed-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>> v2->v3: Use platform_device_register_resndata to pass match data to probe to
>> 	to avoid matching again in probe.
>>
>> 	v2: https://patchwork.kernel.org/patch/10574535/
>>
> 
>>  static int ti_cpufreq_init(void)
>>  {
>> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
>> +	const struct of_device_id *match;
>> +
>> +	/* Check to ensure we are on a compatible platform */
>> +	match = ti_cpufreq_match_node();
>> +	if (match)
>> +		platform_device_register_resndata(NULL, "ti-cpufreq", -1, NULL,
>> +						  0, match,
>> +						  sizeof(*match));
> 
> platform_device_register_data()?

Whoops yeah that's a bit more concise, v4 incoming.

Regards,
Dave

> 
>>  	return 0;
>>  }
>>  module_init(ti_cpufreq_init);
> 
> Johan
> 
