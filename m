From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Documentation: dt: add bindings for ti-cpufreq
Date: Mon, 12 Sep 2016 15:56:43 -0500
Message-ID: <57D7168B.5070708@ti.com>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-2-d-gerlach@ti.com> <20160907051215.GN27345@vireshk-i7>
 <57D025E8.6030202@ti.com> <20160908033557.GQ27345@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160908033557.GQ27345@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Rob,
On 09/07/2016 10:35 PM, Viresh Kumar wrote:
> On 07-09-16, 09:36, Dave Gerlach wrote:
>> On 09/07/2016 12:12 AM, Viresh Kumar wrote:
>>> On 31-08-16, 21:53, Dave Gerlach wrote:
>>>> +In 'operating-points-v2' table:
>>>> +- compatible: Should be
>>>> +	- 'operating-points-v2-ti-am3352-cpu' for am335x SoCs
>>>> +	- 'operating-points-v2-ti-am4372-cpu' for am43xx SoCs
>>>> +	- 'operating-points-v2-ti-dra7-cpu' for dra7xx/am57xx SoCs
>>>
>>> Why do you need SoC specific compatible here? Are you defining new
>>> fields in OPP tables for your SoC ? How are the tables for your case
>>> going to differ from the ones using "operating-points-v2" compatible
>>> string?
>>>
>>
>> I thought you had suggested that I do this in your comments from v1, but I
>> guess that was dependent on whether or not I put the properties I have
>> inserted into the cpu node into the operating-points table instead.
>
> Yes.
>
>> I still
>> have gotten no comments from any DT maintainers so I left it as is. I am
>> still not sure if that is acceptable.
>
> @Rob: Can you please share your views on the new properties being
> added to the CPU node ?
>

I am fine moving the properties in the operating-points-v2 node or 
leaving it as is, whichever is preferred.

Viresh, thanks for your comments.

Regards,
Dave
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
