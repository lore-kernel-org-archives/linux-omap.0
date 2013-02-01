From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: Display correct system timer name
Date: Fri, 1 Feb 2013 02:53:43 -0600
Message-ID: <510B8297.8070305@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com> <1359565471-30721-2-git-send-email-jon-hunter@ti.com> <B5906170F1614E41A8A28DE3B8D121433ED07255@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54331 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab3BAIxq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 03:53:46 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED07255@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On 02/01/2013 02:41 AM, Bedia, Vaibhav wrote:
> Hi Jon,
> 
> On Wed, Jan 30, 2013 at 22:34:27, Hunter, Jon wrote:
>> Currently on boot, when displaying the name of the gptimer used for
>> clockevents and clocksource timers, the timer ID is shown. However,
>> when booting with device-tree, the timer ID is not used to select a
>> gptimer but a timer property. Hence, it is possible that the timer
>> selected when booting with device-tree does not match the ID shown.
>> Therefore, instead display the HWMOD name of the gptimer and use
>> the HWMOD name as the name of clockevent and clocksource timer (if a
>> gptimer is used).no
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  arch/arm/mach-omap2/timer.c |   44 +++++++++++++++++++++----------------------
>>  1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 72c2ca1..18cb856 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -71,6 +71,9 @@
>>  #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET		0x14
>>  #define NUMERATOR_DENUMERATOR_MASK			0xfffff000
>>  
>> +/* Timer name needs to be big enough to store a string of "timerXX" */
>> +static char timer_name[10];
>> +
> 
> Why not move this inside omap_dm_timer_init_one()?

In the non-DT case, the name member of the clocksource/event struct will
point to this array and so it needs to reside in memory permanently and
not just temporary. Once we migrate completely to DT then we will be
able to remove this completely. See following snippet ...

-		sprintf(name, "timer%d", gptimer_id);
-		oh_name = name;
+		sprintf(timer_name, "timer%d", gptimer_id);
+		*name = timer_name;

Cheers
Jon
