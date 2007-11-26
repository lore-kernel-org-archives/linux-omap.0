From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: MACH-OMAP1: Fix compilation issues for OMAP1
Date: Mon, 26 Nov 2007 12:09:39 -0800
Message-ID: <20071126200939.GH21886@atomide.com>
References: <1196092220-6633-1-git-send-email-felipe.lima@indt.org.br>
	<474B23A4.7090902@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <474B23A4.7090902@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [071126 11:51]:
> Felipe Balbi wrote:
>> After commit 6e0d7b9283a5b91bf2c2adc7801e426fd563bc13 building
>> is broken for omap1 archs due to double definition of sched_clock().
>> sched_clock() has moved to plat-omap/common.c so it's ok removing it
>> from mach-omap1/time.c
>
> While trying to find this patch in list archive, I found that you sent it 
> only to our new list at vger.kernel.org [1]. Nice, now I'm sure that mails 
> from that list reach me as well ;) But we have no archive there yet. So for 
> some time I think CC to Linux-omap-open-source@linux.omap.com would be good 
> as well.

BTW, I got a mail from Hank Leininger at MARC today saying that he is
adding the list. He will also import the old archives there!

Tony


> [1] http://vger.kernel.org/vger-lists.html#linux-omap
>
>> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
>> ---
>>  arch/arm/mach-omap1/time.c |   15 ---------------
>>  1 files changed, 0 insertions(+), 15 deletions(-)
>> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
>> index a4f8b20..872b965 100644
>> --- a/arch/arm/mach-omap1/time.c
>> +++ b/arch/arm/mach-omap1/time.c
>> @@ -262,21 +262,6 @@ static void __init omap_init_clocksource(unsigned 
>> long rate)
>>    /*
>> - * Scheduler clock - returns current time in nanosec units.
>> - */
>> -unsigned long long sched_clock(void)
>> -{
>> -	unsigned long ticks = 0 - omap_mpu_timer_read(1);
>> -	unsigned long long ticks64;
>> -
>> -	ticks64 = omap_mpu_timer2_overflows;
>> -	ticks64 <<= 32;
>> -	ticks64 |= ticks;
>> -
>> -	return cycles_2_ns(ticks64);
>> -}
>> -
>> -/*
>>   * 
>> ---------------------------------------------------------------------------
>>   * Timer initialization
>>   * 
>> ---------------------------------------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
