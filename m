From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
Date: Tue, 13 Sep 2011 11:07:57 +0530
Message-ID: <4E6EEC35.8080203@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com> <87obypfvah.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:58296 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754085Ab1IMFiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 01:38:06 -0400
Received: by mail-gx0-f176.google.com with SMTP id 7so225345gxk.21
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 22:38:05 -0700 (PDT)
In-Reply-To: <87obypfvah.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Tuesday 13 September 2011 12:22 AM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> This patch adds the MPUSS OSWR (Open Switch Retention) support. The MPUSS
>> OSWR configuration is as below.
>> 	- CPUx L1 and logic lost, MPUSS logic lost, L2 memory is retained
>>
>> OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
>> anymore just like CORE power domain. The deepest state supported is OSWR.
>> On OMAP4430 secure devices too, MPUSS off mode can't be used because of
>> a bug which alters Ducati and Tesla states. Hence MPUSS off mode as an
>> independent state isn't supported on OMAP44XX devices.
>>
>> Ofcourse when MPUSS power domain transitions to OSWR along
>> with device off mode, it eventually hits off state since memory
>> contents are lost.
>>
>> Hence the MPUSS off mode independent state is not attempted without
>> device off mode. All the necessary infrastructure code for MPUSS
>> off mode is in place as part of this series.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> Compile failure for the !CONFIG_PM case:
>
> [...]
>
>> @@ -70,11 +71,18 @@ static inline int omap4_mpuss_init(void)
>>   {
>>   	return 0;
>>   }
>> -
>> +static inline u32 omap4_mpuss_read_prev_context_state(void)
>> +{
>> +	return 0;
>> +}
>
> added here
>
>>   static inline int omap4_finish_suspend(unsigned long cpu_state)
>>   {}
>>   static inline void omap4_cpu_resume(void)
>>   {}
>> +static inline u32 omap4_mpuss_read_prev_context_state(void)
>> +{
>> +	return 0;
>> +}
>
> same thing added here
>
I noticed this yesterday and was planning to send a note on this
patch. :(
Have removed this already in the updated patches.
Thanks for pointing it out.

Regards
Santosh

