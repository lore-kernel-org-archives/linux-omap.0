From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Date: Thu, 13 Aug 2015 00:38:50 +0530
Message-ID: <55CB99C2.7010007@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-3-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1508121422020.7154-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 12 August 2015 07:57 PM, Paul Walmsley wrote:
> On Mon, 10 Aug 2015, Keerthy wrote:
>
>> Switch to external clock source during suspend and switch back
>> to internal source on resume. This helps rtc ticking across suspend.
>
> Doesn't this type of dynamic switching make it likely that ticks will be
> lost?
>
> If the external, optional source is present, isn't it best just to use the
> external source 100% of the time?


Paul,

The intent here is to switch to a higher precision clock which is the 
internal clock when available.

Alexandre,

Is dynamic switching preferred over sticking  to external clock always 
if present?

Regards,
Keerthy
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
