From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix section mismatch: reference to .init.text: from
	.text warning
Date: Fri, 25 May 2007 11:42:49 -0700
Message-ID: <20070525184249.GK19506@atomide.com>
References: <000001c79814$fec527d0$e1ac580a@swcenter.sec.samsung.co.kr>
	<20070517173820.GA8556@atomide.com>
	<46572A15.8020506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46572A15.8020506@googlemail.com>
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
Cc: linux-omap-open-source@linux.omap.com, Kyungmin Park <kmpark@infradead.org>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070525 11:25]:
> Tony Lindgren wrote:
>> * Kyungmin Park <kmpark@infradead.org> [070516 16:51]:
>>> Fix section mismatch: reference to .init.text: from .text warning of 
>>> omap_timer
>>>
>>> I tested with OMAP2 only, but OMAP1 also has same warning.
>>>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> --
>>>
>>> index 3705d20..0ba739c 100644
>>> --- a/arch/arm/mach-omap1/time.c
>>> +++ b/arch/arm/mach-omap1/time.c
>>> @@ -289,6 +289,6 @@ static void __init omap_timer_init(void)
>>>  	omap_init_clocksource(rate);
>>>  }
>>>  -struct sys_timer omap_timer = {
>>> +struct sys_timer omap_timer __initdata = {
>>>  	.init		= omap_timer_init,
>>>  };
>>> diff --git a/arch/arm/mach-omap2/timer-gp.c 
>>> b/arch/arm/mach-omap2/timer-gp.c
>>> index 8f380a1..948d7ec 100644
>>> --- a/arch/arm/mach-omap2/timer-gp.c
>>> +++ b/arch/arm/mach-omap2/timer-gp.c
>>> @@ -175,6 +175,6 @@ static void __init omap2_gp_timer_init(void)
>>>  	omap2_gp_clocksource_init();
>>>  }
>>>  -struct sys_timer omap_timer = {
>>> +struct sys_timer omap_timer __initdata = {
>>>  	.init	= omap2_gp_timer_init,
>>>  };
>>> diff --git a/arch/arm/plat-omap/timer32k.c 
>>> b/arch/arm/plat-omap/timer32k.c
>>> index 2474597..e7e1960 100644
>>> --- a/arch/arm/plat-omap/timer32k.c
>>> +++ b/arch/arm/plat-omap/timer32k.c
>>> @@ -262,6 +262,6 @@ static void __init omap_timer_init(void)
>>>  	omap_init_32k_timer();
>>>  }
>>>  -struct sys_timer omap_timer = {
>>> +struct sys_timer omap_timer __initdata = {
>>>  	.init		= omap_timer_init,
>>>  };
>>>
>> We cannot mark sys_timer as __initdata as it is used for all
>> timer stuff. There is a patch on linux-arm-kernel to ignore
>> sys_timer for the check. So these warnings may not be correct
>> always.
>> BTW, we should check that struct omap_board_config_kernel
>> entries really can be __initdata from modules point of view.
>
> I think you are talking here about this one
>
> WARNING: arch/arm/plat-omap/built-in.o(.data+0xd68): Section mismatch:
> reference to .init.text: (between 'omap_timer' and 'omap_32k_timer_irq')
>
> ?
>
> This is the last section mismatch I get after update to recent git.
> What's the best way to remove this now? Remove __init/__initdata?

I think the right fix would be to ignore struct sys_timer initdata
errors. Removing the __init from timer_init() really just hides the
problem. Here's a link to a related thread:

http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg155753.html

Tony
