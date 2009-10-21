From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 08/17] OMAP2/3: GPTIMER: Clear pending interrupts when
 entering suspend
Date: Wed, 21 Oct 2009 12:09:33 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A210F6A58264@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <87skdej7bi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47207 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbZJUKKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 06:10:34 -0400
In-Reply-To: <87skdej7bi.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 20 October, 2009 20:37
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 08/17] OMAP2/3: GPTIMER: Clear pending 
>interrupts when entering suspend
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> OMAP GP timers keep running for a few cycles after they are stopped,
>> which can cause the timer to expire and generate an 
>interrupt. The pending
>> interrupt will prevent OMAP from entering suspend, thus we 
>ack it manually.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>
>> ---
>>  arch/arm/mach-omap2/timer-gp.c |   14 +++++++++++++-
>>  1 files changed, 13 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/timer-gp.c 
>b/arch/arm/mach-omap2/timer-gp.c
>> index 9c056ff..c9d47bb 100644
>> --- a/arch/arm/mach-omap2/timer-gp.c
>> +++ b/arch/arm/mach-omap2/timer-gp.c
>> @@ -92,9 +92,21 @@ static void omap2_gp_timer_set_mode(enum 
>clock_event_mode mode,
>>  	case CLOCK_EVT_MODE_ONESHOT:
>>  		break;
>>  	case CLOCK_EVT_MODE_UNUSED:
>> -	case CLOCK_EVT_MODE_SHUTDOWN:
>>  	case CLOCK_EVT_MODE_RESUME:
>>  		break;
>> +	case CLOCK_EVT_MODE_SHUTDOWN:
>> +		/*
>> +		 * Wait for min period x 2 to make sure that timer is
>> +		 * stopped
>> +		 */
>> +		udelay(evt->min_delta_ns / 500);
>> +		/*
>> +		 * Clear possibly pending interrupt, this will 
>occasionally
>> +		 * generate spurious timer IRQs during suspend but this
>> +		 * is okay, as another option is not to enter 
>suspend at all
>> +		 */
>> +		omap_dm_timer_write_status(gptimer, 
>OMAP_TIMER_INT_OVERFLOW);
>> +		break;
>
>Seems to me that this fix should just be done in omap_dm_timer_stop()
>since it could also result in extra interrupts in when using oneshot
>mode under dyntick.

Hmm yea, I can attempt to move this in there.

>
>Kevin
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>