From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide
 powerhold property
Date: Wed, 23 Nov 2016 09:05:19 +0530
Message-ID: <6ac3b28e-4891-83bc-a2f7-c903541acc18@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
 <20161115000849.GD4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115000849.GD4082-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 15 November 2016 05:38 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [161109 21:10]:
>> The PMICs have POWERHOLD set by default which prevents PMIC shutdown
>> even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
>> So to enable pmic power off this property lets one over ride the default
>> value and enable pmic power off.
>
> This should not cause merge conflicts so probably best to merge along
> with the driver changes:
>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>
> If you guys want me to pick up this separately let me know.

Hi Lee Jones,

Are you planning to pull DT and Documentation patches as well?

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
