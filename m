From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Date: Fri, 14 Aug 2015 10:25:11 +0530
Message-ID: <55CD74AF.4020803@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-3-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com> <55CB99C2.7010007@ti.com> <20150812201636.GJ3411@piout.net> <alpine.DEB.2.02.1508131822510.1009@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1508131822510.1009-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 14 August 2015 01:47 AM, Paul Walmsley wrote:
> Hi guys
>
> On Wed, 12 Aug 2015, Alexandre Belloni wrote:
>
>> On 13/08/2015 at 00:38:50 +0530, Keerthy wrote :
>>> The intent here is to switch to a higher precision clock which is the
>>> internal clock when available.
>>>
>>> Alexandre,
>>>
>>> Is dynamic switching preferred over sticking  to external clock always if
>>> present?
>>
>> I'd say that I don't really care. I'd say the best would be to make a
>> decision based on clock-accuracy but maybe that is an information you
>> don't have yet. Anyway, this could be added at a later date.
>
> Either the clock mux logic is glitchless, in which case the RTC is likely
> to lose at least 31 microseconds per switch; or it's not glitchless, in
> which case it's unsafe to switch the RTC clock source while the clock
> isn't gated.  Keerthy, before submitting this patch for merging, I'd
> suggest consulting your hardware folks to figure out which case it is.

Paul,

Thanks. Yes so i am doing the static way first. Keeping external clock 
always if available. Switching dynamically can be done later with more 
clarifications.

Thanks,
Keerthy

>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
