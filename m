From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Wed, 08 Nov 2006 17:44:34 +0100
Message-ID: <45520972.7060805@gmail.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4550CA9E.6090500@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> Dirk Behme wrote: 
>>Add clocksource driver for OMAP1.
>>
>>Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
>>
>>What do you think about this? OSK still boots and I can't
>>see any runtime issues. But maybe others?
> 
> Daniel Walker and myself have done both the clocksource and clockevent
> drivers for the 32k timer and MPU timers on OMAP1.

Ah, thanks for the hint! I overlooked [1].

> The clocksource driver has been submitted to RMK's patchsystem (but not
> yet integrated, RMK is waiting some settling in mainline too) 

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1

- For clocksource_mpu.mult and clocksource_register stuff we 
should (later?) have a seperate function 
omap_init_clocksource() to be able to call it by something like

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036700.html

- While working on same topic I wonder if we still need both 
HW timers in timer.c

setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
omap_mpu_timer_start(0, 0xffffffff);
omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);

?

My test worked with using only one HW timer and removing all 
other stuff:

setup_irq(INT_TIMER1, &omap_mpu_timer_irq);
omap_mpu_timer_start(0, MPU_TIMER_TICK_PERIOD);

But maybe I missed anything?

> and the
> rest has been submitted to Thomas Gliexner and will be included in his
> next -hrt-dyntick patcheset[2]
> 
> The active -hrt-dyntick work is going on in -mm right now.  The attached
> patchset (against 2.6.19-rc2-mm2) includes the latest OMAP patches which
> will be part of the next -hrt-dyntick patchset.

I think OMAP in mainline is slightly different from our git 
tree here. Some parts are missing in mainline. If mainline 
has merged everything and we pull it back to our OMAP git, 
do we need a patch to adapt OMAP stuff not in mainline yet 
to changes for -hrt-dyntick?

See RT preemt: If you try to apply RT preemt 2.6.18-rt7 
(which is against OMAP in mainline) to OMAP 2.6.18 git, it 
doesn't apply cleanly. Parts are missing and different 
between OMAP git and OMAP mainline.

> We've tested these with Ingo's -rt patchset on 16xx/H2 and 1710/H3 and
> see good performance.  We've also validated the new generic dynamic tick
> support which is part of the -hrt-dyntick patchset

Full text untouched here because seems that large attachment 
prevented it from keeping in list archive.

> [2] http://tglx.de/projects/hrtimers/

Cheers,

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/008008.html
