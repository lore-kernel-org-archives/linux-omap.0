From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Warnings: pm branch
Date: Wed, 12 Aug 2009 19:52:16 +0530
Message-ID: <00a101ca1b58$4cdca100$LocalHost@wipultra793>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com><873a7y74mj.fsf@deeprootsystems.com><03d301ca1b32$14f97d10$LocalHost@wipultra793><7803.10.24.255.18.1250081698.squirrel@dbdmail.itg.ti.com> <87d4712k4h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35109 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbZHLOW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:22:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Kevin Hilman" <khilman@deeprootsystems.com>
>>  /* enter the state and update stats */
>> @@ -91,6 +93,12 @@ static void cpuidle_idle_call(void)
>>  /* give the governor an opportunity to reflect on the outcome */
>>  if (cpuidle_curr_governor->reflect)
>>  cpuidle_curr_governor->reflect(dev);
>> +
>> + return;
>> +
> 
> ... I think you want to drop this return.  If it returns here, it
> will still not enable IRQs.  I think it should just fall through
> to the enable and return.

Since omap3_enter_idle returns with interrupts enabled, I had
added this return. We could remove it also for safety purposes.

Thanks
Hemanth
