From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 09 Nov 2006 16:48:29 -0800
Message-ID: <4553CC5D.3040303@mvista.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
	<45520972.7060805@gmail.com> <20061110002909.GV16172@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061110002909.GV16172@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [061108 18:45]:
>> Kevin Hilman wrote:
>>> Dirk Behme wrote: 
>>>> Add clocksource driver for OMAP1.
>>>>
>>>> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
>>>>
>>>> What do you think about this? OSK still boots and I can't
>>>> see any runtime issues. But maybe others?
>>> Daniel Walker and myself have done both the clocksource and clockevent
>>> drivers for the 32k timer and MPU timers on OMAP1.
>> Ah, thanks for the hint! I overlooked [1].
>>
>>> The clocksource driver has been submitted to RMK's patchsystem (but not
>>> yet integrated, RMK is waiting some settling in mainline too) 
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1
> 
> Great!
>  
>> - For clocksource_mpu.mult and clocksource_register stuff we 
>> should (later?) have a seperate function 
>> omap_init_clocksource() to be able to call it by something like
>>
>> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036700.html
>>
>> - While working on same topic I wonder if we still need both 
>> HW timers in timer.c
>>
>> setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
>> setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
>> omap_mpu_timer_start(0, 0xffffffff);
>> omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
>>
>> ?
> 
> Well if that one timer is continuous, it should be enough. However, if
> it was being continuously reprogrammed, it would not be accurate for
> keeping time, and then you would need another timer for timesource.

The goal of the generic clockevents layer is to have a continually
re-programmable clocksource.  This is then used for high-res timers, but
also for the generic dynamic tick support.

The ideal is to have 2 hardware timers: on continuous for the
clocksource and the other reprogrammable for the clockevents.

There probably are some clever ways to use one timer to do this, but for
this first pass, we haven't spent time on that.

Kevin
