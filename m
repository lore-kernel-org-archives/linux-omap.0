From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] cpufreq: ti: Use generic platdev driver
Date: Mon, 19 Sep 2016 15:41:04 -0500
Message-ID: <57E04D60.2040402@ti.com>
References: <20160914204137.20346-1-d-gerlach@ti.com>
 <20160915062507.GA30169@vireshk-i7> <57DC6420.20706@ti.com>
 <4712275.44limO7TAi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <4712275.44limO7TAi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 09/16/2016 04:59 PM, Rafael J. Wysocki wrote:
> On Friday, September 16, 2016 04:29:04 PM Dave Gerlach wrote:
>> Hi,
>> On 09/15/2016 01:25 AM, Viresh Kumar wrote:
>>> On 14-09-16, 15:41, Dave Gerlach wrote:
>>>> Now that the cpufreq-dt-platdev is used to create the cpufreq-dt platform
>>>> device for all OMAP platforms and the platform code that did it
>>>> before has been removed, add ti,am33xx and ti,dra7xx to the machine list
>>>> in cpufreq-dt-platdev which had relied on the removed platform code to do
>>>> this previously.
>>>>
>>>> Fixes: 7694ca6e1d6f ("cpufreq: omap: Use generic platdev driver")
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>
>>> Any stable trees you want this to be added to ?
>>
>> I suppose it'll go for 4.7-stable as the change happened in v4.6.
>
> The commit in the fixes tag went in during the 4.7 cycle, so the fix should
> go into 4.7.y, but I'm not going to push it as urgent material for 4.8.
>

Yes, that is fine, thanks a lot!

Regards,
Dave

> Thanks,
> Rafael
>

