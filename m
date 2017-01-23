From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Mon, 23 Jan 2017 15:48:10 -0600
Message-ID: <91a2d778-ce39-19dd-33cd-77e4eda0d8b7@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-3-d-gerlach@ti.com>
 <20170119180702.62xg2ta5pq4mf7sd@rob-hp-laptop>
 <b7d11925-879a-9be0-fdd8-45b70e642ce1@ti.com>
 <20170120184324.GJ7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170120184324.GJ7403@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/20/2017 12:43 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [170119 10:32]:
>> On 01/19/2017 12:07 PM, Rob Herring wrote:
>>>> +	/*
>>>> +	 * The three following nodes are marked with opp-suspend
>>>> +	 * because they can not be enabled simultaneously on a
>>>> +	 * single SoC.
>>>> +	 */
>>>> +	opp50@300000000 {
>>>
>>> What's the 50, 100, 120 in the names?
>>
>> Those are the names of the OPPs given in Table 5-7 of the AM335x data
>> manual, seen here http://www.ti.com/lit/ds/symlink/am3359.pdf . I typically
>> reference the table and document in the commit message of the actual DT
>> patches but didn't here for the binding.
>
> If you don't need the names, you could maybe use:
>
> opp100: opp@275000000 {
> 	...
> };
>
> opp200: opp@300000000 {
> 	...
> };

Thanks for the suggestion, but we have duplicate frequencies that have 
different voltages defined for them, so the scheme opp@<freq> won't work 
because then we end up with duplicate nodes. OPPs are a defined by a 
number of parameters, not just frequency, so always naming the nodes 
opp@<freq> won't cover all scenarios.

Regards,
Dave

> ...
>
> Regards,
>
> Tony
>

