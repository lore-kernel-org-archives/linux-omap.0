From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] OMAP3 PM: Deny clock gating only for safe state
Date: Wed, 02 Mar 2011 13:11:25 -0800
Message-ID: <87d3m99qiq.fsf@ti.com>
References: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
	<1297846874-18286-2-git-send-email-vishwanath.bs@ti.com>
	<87mxleimh6.fsf@ti.com>
	<e295d93b87df63e95a46e625d7422433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39819 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757627Ab1CBVLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 16:11:34 -0500
Received: by mail-gw0-f50.google.com with SMTP id a20so195168gwa.9
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 13:11:28 -0800 (PST)
In-Reply-To: <e295d93b87df63e95a46e625d7422433@mail.gmail.com> (Vishwanath
	Sripathy's message of "Wed, 2 Mar 2011 22:44:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

> Kevin,
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@ti.com]
>> Sent: Wednesday, March 02, 2011 2:32 AM
>> To: Vishwanath BS
>> Cc: linux-omap@vger.kernel.org; patches@linaro.org
>> Subject: Re: [PATCH 1/3] OMAP3 PM: Deny clock gating only for safe
>> state
>>
>> Vishwanath BS <vishwanath.bs@ti.com> writes:
>>
>> > Currently clock gating for MPU and core are denied whenever C1 state
>> is
>> > selected.
>>
>> Yes, that is the definition of C1.
>>
>> > It should be denied only when safe state is selected.
>>
>> Why?
> Clock gating in C1 will reduce overall power consumption and it should not
> impact any functionality as well.

Clock gating changes latencies.

>>
>> This changes the definition and behavior of C1 depending on how it is
>> entered.  Not a good idea IMO.
> I thought of adding a new C state, keeping C1 definition unchanged. Then
> we will not get the real power benefit since in case of C1, clock gating
> will be prevented. Let me know if you have some suggestion.

My problem with this patch is that you make C1 have different behavior
depending on whether it is selected directly by the governor or it is
entered due to the safe state.

The motiviation for this change is not at all described in the
changelog.

Kevin
