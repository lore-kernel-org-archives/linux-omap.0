From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/6] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Thu, 13 Aug 2015 09:39:10 +0300
Message-ID: <55CC3B8E.2090802@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-6-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1508121434190.7154@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1508121434190.7154-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/12/2015 05:39 PM, Paul Walmsley wrote:
> On Mon, 10 Aug 2015, Keerthy wrote:
>
>> The patch adds rtc hwmod. This is present on gp and sk evm and not on
>> epos evm. Hence adding it selectively using a seprate list.
>>
>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>
> So just to confirm, the RTC IP block has been physically removed or
> permanently disabled on these new AM438x chips?  So the registers are no
> longer accessible by the MPU?
>
> Is there a TRM available for these chips?

No public TRM available, as the SoC mostly contains secure environment 
support on them.

The RTC module is physically present on the SoC, but it is permanently 
disabled. A secure RTC is used instead on these devices, where needed.

-Tero

>
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
