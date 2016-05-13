From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND 0/4] arm: dts: am57xx: Correct the thermal
 thresholds
Date: Fri, 13 May 2016 10:49:20 +0530
Message-ID: <573563D8.7020503@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
 <57316262.80003@ti.com> <20160512203505.GV5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160512203505.GV5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 13 May 2016 02:05 AM, Tony Lindgren wrote:
> Hi,
>
> * Keerthy <a0393675-l0cyMroinI0@public.gmane.org> [160509 21:25]:
>> Tony,
>>
>> On Thursday 28 April 2016 03:35 PM, Keerthy wrote:
>>> Noticed that earlier post had a wrong list name hence resending the
>>> series.
>>>
>>> Currently all the am57xx versions are wrongly re-using the dra7  thermal
>>> threholds. Introduing the correct thermal thresholds based on industrial
>>> or commercial grade silicon present on the individual boards.
>>>
>>> Tested on AM57XX-BEAGLE-X15 (Commercial) and AM572X-IDK(Industrial)
>>> for the trip_point node sysfs temperatures.
>>>
>>
>> A Gentle ping on this series.
>
> I already have these in Linux next for v4.7 merge window:
>
> 5b6042237dc8 ("ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds")
> 266e62f97539 ("ARM: dts: am57xx-beagle-x15: Include the commercial grade thresholds")
> cf9b7d5e9cfd ("ARM: dts: am57xx: Introduce industrial grade thermal thresholds")
> 286db0a516e0 ("ARM: dts: am57xx: Introduce commercial grade thermal thresholds")
>
> Care to check if those are OK? If fixes are needed, please post an
> incremental patch against current Linux next.

Thanks Tony. Those 4 commits are fine.

Regards,
Keerthy
>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
