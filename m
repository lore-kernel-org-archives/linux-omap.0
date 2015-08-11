From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/6] ARM: AM43xx: Introduce a separate soc_is function
 for am438x series of SoCs
Date: Tue, 11 Aug 2015 23:24:26 +0530
Message-ID: <55CA36D2.3080509@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-4-git-send-email-j-keerthy@ti.com> <20150811125515.GN4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811125515.GN4215-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 11 August 2015 06:25 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [150810 02:31]:
>> @@ -371,8 +372,10 @@ IS_OMAP_TYPE(3430, 0x3430)
>>   #ifdef	CONFIG_SOC_AM43XX
>>   # undef soc_is_am43xx
>>   # undef soc_is_am437x
>> -# define soc_is_am43xx()		is_am43xx()
>> -# define soc_is_am437x()		is_am437x()
>> +# undef soc_is_am438x
>> +# define soc_is_am43xx()		of_machine_is_compatible("ti,am43")
>> +# define soc_is_am437x()		of_machine_is_compatible("ti,am4372")
>> +# define soc_is_am438x()		of_machine_is_compatible("ti,am438x")
>>   #endif
>
> Hmm didn't I already comment on this change? I don't want to do it
> for one SoC. Please add the SoC detection the old way for am43xx,
> then do another series that changes all the DT only SoCs to use
> of_machine_is_compatible() after it's been properly tested so now
> regressions are caused for the early init code.

Okay. I misinterpreted your earlier comment. Thanks for clarifying.
I will re-do.

>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
