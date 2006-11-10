From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Fri, 10 Nov 2006 02:29:09 +0200
Message-ID: <20061110002909.GV16172@atomide.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
	<45520972.7060805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45520972.7060805@gmail.com>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061108 18:45]:
> Kevin Hilman wrote:
> >Dirk Behme wrote: 
> >>Add clocksource driver for OMAP1.
> >>
> >>Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> >>
> >>What do you think about this? OSK still boots and I can't
> >>see any runtime issues. But maybe others?
> >
> >Daniel Walker and myself have done both the clocksource and clockevent
> >drivers for the 32k timer and MPU timers on OMAP1.
> 
> Ah, thanks for the hint! I overlooked [1].
> 
> >The clocksource driver has been submitted to RMK's patchsystem (but not
> >yet integrated, RMK is waiting some settling in mainline too) 
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1

Great!
 
> - For clocksource_mpu.mult and clocksource_register stuff we 
> should (later?) have a seperate function 
> omap_init_clocksource() to be able to call it by something like
> 
> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036700.html
> 
> - While working on same topic I wonder if we still need both 
> HW timers in timer.c
> 
> setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
> setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
> omap_mpu_timer_start(0, 0xffffffff);
> omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
> 
> ?

Well if that one timer is continuous, it should be enough. However, if
it was being continuously reprogrammed, it would not be accurate for
keeping time, and then you would need another timer for timesource.
 
> My test worked with using only one HW timer and removing all 
> other stuff:
> 
> setup_irq(INT_TIMER1, &omap_mpu_timer_irq);
> omap_mpu_timer_start(0, MPU_TIMER_TICK_PERIOD);
> 
> But maybe I missed anything?

No, I think the use of two timers is just legacy code from the
original RidgeRun code.

Regards,

Tony
