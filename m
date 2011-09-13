From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
Date: Tue, 13 Sep 2011 09:39:05 +0200
Message-ID: <CAORVsuUaR8pcZ4MYigi85tmtWspz3tR_OJcvhaB0AFRLRaAANw@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>
	<87obypfvah.fsf@ti.com>
	<4E6EEC35.8080203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:54699 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab1IMHjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 03:39:06 -0400
Received: by vws16 with SMTP id 16so563932vws.11
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 00:39:06 -0700 (PDT)
In-Reply-To: <4E6EEC35.8080203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

Hi Santosh,

On Tue, Sep 13, 2011 at 7:37 AM, Santosh <santosh.shilimkar@ti.com> wro=
te:
> On Tuesday 13 September 2011 12:22 AM, Kevin Hilman wrote:
>>
>> Santosh Shilimkar<santosh.shilimkar@ti.com> =A0writes:
>>
>>> This patch adds the MPUSS OSWR (Open Switch Retention) support. The=
 MPUSS
>>> OSWR configuration is as below.
>>> =A0 =A0 =A0 =A0- CPUx L1 and logic lost, MPUSS logic lost, L2 memor=
y is retained
>>>
>>> OMAP4460 onwards, MPUSS power domain doesn't support OFF state any =
more
>>> anymore just like CORE power domain. The deepest state supported is=
 OSWR.
>>> On OMAP4430 secure devices too, MPUSS off mode can't be used becaus=
e of
>>> a bug which alters Ducati and Tesla states. Hence MPUSS off mode as=
 an
>>> independent state isn't supported on OMAP44XX devices.
>>>
>>> Ofcourse when MPUSS power domain transitions to OSWR along
>>> with device off mode, it eventually hits off state since memory
>>> contents are lost.
>>>
>>> Hence the MPUSS off mode independent state is not attempted without
>>> device off mode. All the necessary infrastructure code for MPUSS
>>> off mode is in place as part of this series.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>
>> Compile failure for the !CONFIG_PM case:
>>
>> [...]
>>
>>> @@ -70,11 +71,18 @@ static inline int omap4_mpuss_init(void)
>>> =A0{
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> -
>>> +static inline u32 omap4_mpuss_read_prev_context_state(void)
>>> +{
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>
>> added here
>>
>>> =A0static inline int omap4_finish_suspend(unsigned long cpu_state)
>>> =A0{}
This one should return 0, as I already pointed out in the comments for =
[14/25].

Regards,
Jean

>>> =A0static inline void omap4_cpu_resume(void)
>>> =A0{}
>>> +static inline u32 omap4_mpuss_read_prev_context_state(void)
>>> +{
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>
>> same thing added here
>>
> I noticed this yesterday and was planning to send a note on this
> patch. :(
> Have removed this already in the updated patches.
> Thanks for pointing it out.
>
> Regards
> Santosh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
