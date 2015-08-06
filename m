From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: dts: AM4372: Reorder the rtc compatible string
Date: Thu, 6 Aug 2015 06:55:57 +0530
Message-ID: <55C2B7A5.5000400@ti.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com> <1438771792-12604-2-git-send-email-j-keerthy@ti.com> <20150805153148.GB12328@saruman.tx.rr.com> <55C230E9.9010309@ti.com> <20150805161445.GF12328@saruman.tx.rr.com> <55C23740.2080102@ti.com> <20150805165122.GH12328@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150805165122.GH12328-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 05 August 2015 10:21 PM, Felipe Balbi wrote:
> On Wed, Aug 05, 2015 at 09:48:08PM +0530, Keerthy wrote:
>>
>>
>> On Wednesday 05 August 2015 09:44 PM, Felipe Balbi wrote:
>>> On Wed, Aug 05, 2015 at 09:21:05PM +0530, Keerthy wrote:
>>>> Felipe,
>>>>
>>>> On Wednesday 05 August 2015 09:01 PM, Felipe Balbi wrote:
>>>>> On Wed, Aug 05, 2015 at 04:19:45PM +0530, Keerthy wrote:
>>>>>> Compared to da830-rtc compatibility am3352-rtc is more compatible to
>>>>>> the one in am437x. Hence adding the am3352-rtc compatible to cover the
>>>>>> entire feature set.
>>>>>>
>>>>>> The ti,am4372-rtc has no Documentation and not used even in the driver
>>>>>> hence removing it.
>>>>>
>>>>> why don't you do the inverse ? Document am4372-rtc and make driver use
>>>>> it ?
>>>>
>>>> am3352-rtc suffices for am4372 too. No need to add additional one for
>>>> am4372.
>>>
>>> Until we end up needing it, right ? :-)
>>>
>>> Besides, it's already used in a DTS. What happens if someone branched
>> >from that DTS and ships that in a product. RTC will just stop working
>>> for them. Sure, it wasn't documented, but that's a problem of commit
>>> 73456012734b80442b33916406cfd13bf1b73acb (ARM: dts: AM4372: add few
>>> nodes) which, essentially, added that compatible flag without
>>> documenting it.
>>>
>>> BTW, this compatible has been in tree since August 2013, IMO it's unfar
>>> to drop it just like that. Documenting it would be a better approach.
>>
>> Okay. Can you point me to a file which is already accessing it in dts?
>
> Accessing what ? Also, once DTS reaches a major kernel release, it's
> deemed stable and should be supported. Are we dropping that ?

I meant getting used in any other dts files than the one i just dropped 
it. I checked the driver for rtc-omap and the compatibles are 
ti,am3352-rtc, ti,da830-rtc. So instead of appending it i dropped it as 
it was unused before. Tony i guess has already pulled in this patch. So 
i will let Tony comment on this. If the am4372-rtc compatible needs to 
be there i can add more documentation and append am3352-rtc.

Regards,
Keerthy
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
