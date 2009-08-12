From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Warnings: pm branch
Date: Wed, 12 Aug 2009 07:38:20 -0700
Message-ID: <87d47114ir.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com>
	<873a7y74mj.fsf@deeprootsystems.com>
	<03d301ca1b32$14f97d10$LocalHost@wipultra793>
	<7803.10.24.255.18.1250081698.squirrel@dbdmail.itg.ti.com>
	<87d4712k4h.fsf@deeprootsystems.com>
	<00a101ca1b58$4cdca100$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:45547 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbZHLOiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:38:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so15534wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 07:38:22 -0700 (PDT)
In-Reply-To: <00a101ca1b58$4cdca100$LocalHost@wipultra793> (Hemanth V.'s message of "Wed\, 12 Aug 2009 19\:52\:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

> ----- Original Message ----- 
> From: "Kevin Hilman" <khilman@deeprootsystems.com>
>>>  /* enter the state and update stats */
>>> @@ -91,6 +93,12 @@ static void cpuidle_idle_call(void)
>>>  /* give the governor an opportunity to reflect on the outcome */
>>>  if (cpuidle_curr_governor->reflect)
>>>  cpuidle_curr_governor->reflect(dev);
>>> +
>>> + return;
>>> +
>>
>> ... I think you want to drop this return.  If it returns here, it
>> will still not enable IRQs.  I think it should just fall through
>> to the enable and return.
>
> Since omap3_enter_idle returns with interrupts enabled, I had
> added this return. We could remove it also for safety purposes.
 
OK.  I think you should post to linux-pm for comment, and possibly
raise this as a question.

You can add:

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

