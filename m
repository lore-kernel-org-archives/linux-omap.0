From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2: add cpuidle and cpufreq events tracing
Date: Thu, 26 Aug 2010 17:01:45 -0700
Message-ID: <87iq2wsz2u.fsf@deeprootsystems.com>
References: <AANLkTim-n+3sTzrxKStniAjHFWxGx4xVAf=FkZ4U282f@mail.gmail.com>
	<87r5hmft7c.fsf@deeprootsystems.com>
	<AANLkTiknAXe4SNavZpwSVY__v4bRTiWZEA5NxMMi5y10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913Ab0H0ABt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 20:01:49 -0400
Received: by pvg2 with SMTP id 2so851221pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 17:01:48 -0700 (PDT)
In-Reply-To: <AANLkTiknAXe4SNavZpwSVY__v4bRTiWZEA5NxMMi5y10@mail.gmail.com>
	(Jean Pihet's message of "Thu, 26 Aug 2010 18:56:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Wed, Aug 25, 2010 at 8:22 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Hi Jean,
>>
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
> ...
>>
>>> Add the cpuidle power_start and power_end events. The state
>>> parameter of power_start has the following meaning:
>>> - -1: from the suspend handler (omap3_pm_suspend),
>>> - 1: from the default idle handler (omap3_pm_idle),
>>> - other values are the C-states from the cpuidle handler
>>> =A0 =A0(omap3_enter_idle).
>>
>> Are these definitions standard across other arches too? =A0The use o=
f
>> POWER_CSTATE from supend seems less than intuitive.
> Only x86 is using those events, and only for idle (values >=3D 0).
> I have added -1 to differentiate the suspend from the regular idle bu=
t
> it sems that it is not the best option.
> Is a new type of power event more suited, e.g. POWER_SSTATE? If so I
> will have to add it in the event definition header (in
> include/trace/events/power.h) and the patch will be submitted to LKML=
=2E

Yes, I think a new event is probably more appropriate, but should be
discussed on LKML.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
