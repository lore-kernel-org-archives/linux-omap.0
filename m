From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure
 ram
Date: Fri, 19 Nov 2010 14:08:50 -0600
Message-ID: <4CE6D952.8000601@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-10-git-send-email-nm@ti.com>	<87sjyxb5gh.fsf@deeprootsystems.com> <4CE6B176.10204@ti.com> <87oc9l9juh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34011 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281Ab0KSUIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 15:08:55 -0500
Received: by mail-vw0-f50.google.com with SMTP id 1so2720695vws.23
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 12:08:54 -0800 (PST)
In-Reply-To: <87oc9l9juh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Kevin Hilman had written, on 11/19/2010 01:47 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Kevin Hilman had written, on 11/19/2010 11:15 AM, the following:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>>>>
>>>> We need to disable the autoidle bit from MPU INTC,
>>>> otherwise INTC would get stall, and we would never
>>>> come out of WFI. This must be done before save secure ram
>>>> as well because save secure ram also does WFI.
>>>>
>>>> This patch is just a addition to the current W/A we have for i540,
>>>> in order to cover the WFI inside the save secure ram.
>>> This 'in addition' doesn't really make sense to me.  This doesn't add
>>> anything to the current workaround, it just changes the order of
>>> operations.
>> yes - the "in addition" part is as follows:
>>
>> ideally speaking you just need the omap3_intc_prepare_idle just before
>> wfi. we "in addition" need to protect the save_secure_ram call as well
>> because ROM code's WFI hits the same window of the bug that we do in
>> the kernel. I believe the "in addition" was meant to state that we
>> have to protect the logic of romcode as well..
> 
> OK, then it needs to be rephrased.  It doesn't need to (re)summarize the
> i540 workaround, since it's already in the kernel.  You could just state:
> 
> The existing workaround for erratum i540 (disable MPU INTC auto-idle)
> needs to be done before saving secure RAM since secure-mode call can
> also do WFI.
> 

yep, Thanks, this is indeed a better description - will take it in as 
part of my v2.

-- 
Regards,
Nishanth Menon
