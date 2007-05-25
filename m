From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Fix section mismatch: reference to .init.text:
 from	.text warning
Date: Fri, 25 May 2007 20:25:25 +0200
Message-ID: <46572A15.8020506@googlemail.com>
References: <000001c79814$fec527d0$e1ac580a@swcenter.sec.samsung.co.kr>
	<20070517173820.GA8556@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070517173820.GA8556@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Kyungmin Park <kmpark@infradead.org> [070516 16:51]:
>> Fix section mismatch: reference to .init.text: from .text warning of omap_timer
>>
>> I tested with OMAP2 only, but OMAP1 also has same warning.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> --
>>
>> index 3705d20..0ba739c 100644
>> --- a/arch/arm/mach-omap1/time.c
>> +++ b/arch/arm/mach-omap1/time.c
>> @@ -289,6 +289,6 @@ static void __init omap_timer_init(void)
>>  	omap_init_clocksource(rate);
>>  }
>>  
>> -struct sys_timer omap_timer = {
>> +struct sys_timer omap_timer __initdata = {
>>  	.init		= omap_timer_init,
>>  };
>> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
>> index 8f380a1..948d7ec 100644
>> --- a/arch/arm/mach-omap2/timer-gp.c
>> +++ b/arch/arm/mach-omap2/timer-gp.c
>> @@ -175,6 +175,6 @@ static void __init omap2_gp_timer_init(void)
>>  	omap2_gp_clocksource_init();
>>  }
>>  
>> -struct sys_timer omap_timer = {
>> +struct sys_timer omap_timer __initdata = {
>>  	.init	= omap2_gp_timer_init,
>>  };
>> diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
>> index 2474597..e7e1960 100644
>> --- a/arch/arm/plat-omap/timer32k.c
>> +++ b/arch/arm/plat-omap/timer32k.c
>> @@ -262,6 +262,6 @@ static void __init omap_timer_init(void)
>>  	omap_init_32k_timer();
>>  }
>>  
>> -struct sys_timer omap_timer = {
>> +struct sys_timer omap_timer __initdata = {
>>  	.init		= omap_timer_init,
>>  };
>>
> 
> We cannot mark sys_timer as __initdata as it is used for all
> timer stuff. There is a patch on linux-arm-kernel to ignore
> sys_timer for the check. So these warnings may not be correct
> always.
> 
> BTW, we should check that struct omap_board_config_kernel
> entries really can be __initdata from modules point of view.

I think you are talking here about this one

WARNING: arch/arm/plat-omap/built-in.o(.data+0xd68): Section mismatch:
reference to .init.text: (between 'omap_timer' and 'omap_32k_timer_irq')

?

This is the last section mismatch I get after update to recent git.
What's the best way to remove this now? Remove __init/__initdata?

Cheers

Dirk
