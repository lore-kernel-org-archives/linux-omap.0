From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 11 Apr 2012 17:19:37 -0700
Message-ID: <87ehrtn6na.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:40174 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754928Ab2DLATd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 20:19:33 -0400
Received: by dake40 with SMTP id e40so2416114dak.25
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 17:19:26 -0700 (PDT)
In-Reply-To: <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 11 Apr 2012 03:29:58 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Mon, Apr 9, 2012 at 10:03 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>> While SD card performance loss is not that bad (~7%), NAND one is
>>> worrying (~39%). I've tried disabling/enabling CONFIG_CPU_IDLE, also
>>> cpuidle states over sysfs, it did not have any significant effect. Is
>>> there something else to try?
>>
>> Looks like we might need a PM QoS constraint when there is DMA activity
>> in progress.
>>
>> You can try doing a pm_qos_add_request() for PM_QOS_CPU_DMA_LATENCY when
>> DMA transfers are active and I suspect that will help.
>
> I've tried it and it didn't help much. It looks like the only thing it
> does is limiting cpuidle c-states, I tried to set qos dma latency to 0
> and it made it stay in C1 while transfer was ongoing (I watched
> /sys/devices/system/cpu/cpu0/cpuidle/state*/usage), but performance
> was still poor.

Great, thanks for doing this experiment.

Assuming we get to a C1 that's low-latency enough, we will still need
this constraint to ensure C1 during transfers.  But first we have to
figure out what's going on with C1...

> What I think is going on here is that omap_sram_idle() is taking too
> much time because it's overhead is too large. I've added a counter
> there and it seems to be called ~530 times per megabyte (DMA operates
> in ~2K chunks so it makes sense), that's over 2000 calls per second.
> Some quick measurement code shows ~243us spent for setting up in
> omap_sram_idle() (before and after omap34xx_do_sram_idle()).

> Could we perhaps have a lighter idle function for C1 that doesn't try
> to switch all powerdomain states and maybe not enable RAM
> self-refresh? 

Yes, but first let's try to uncover exactly what makes the current C1 so
heavy.  

> As a quick test I've tried this in omap3_enter_idle():
>
>         /* Execute ARM wfi */
>         if (index == 0) {
>                 clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
>                 cpu_do_idle();
>         } else
>                 omap_sram_idle();
>
> ..and it brought performance close to !CONFIG_PM case (cpu_do_idle()
> is used as pm_idle on !CONFIG_PM). 

OK, I see now.   I think you're right about the overhead.

It would be helpful now to narrow down what are the big contributors to
the overhead in omap_sram_idle().  Most of the code there is skipped for
C1 because the next states for MPU and CORE are both ON.

There are 2 primary differences that I see as possible causes.  I list
them here with a couple more experiments for you to try to help us
narrow this down.

1) powerdomain accounting: pwrdm_pre_transition(), pwrdm_post_transition()

Could you try using omap_sram_idle() and just commenting out those
calls?  Does that help performance?  Those iterate over all the
powerdomains, so defintely add some overhead, but I don't think it
would be as significant as what you're seeing.    Much more likely is...

2) jump to SRAM, SDRC self-refresh, SDRC errata workarounds

This is more likely the culprit of most of the overhead.  Specifically,
when returning from idle there are some errata to workaround that
require waiting for DPLL3 to lock.  I suspect this is more likely to be
the source of the problem.  

Can you try the hack below[1], which basically does the cpu_do_idle() hack
that you've already done, but inside omap_sram_idle() and only
eliminates the jump to SRAM, SDRC self-refresh and SDRC errata
workarounds?

I assume that will get performance back to what you expect.  Then it
remains to be seen if it's the SDRC self-refresh that's causing the
delay, or the errata workarounds.

To add the self-refresh back, but eliminate the SDRC errata workaround,
You could try something like I hacked up in the (untested) branch here[2].
If performance is still good, that will tell us that it's the errata
workaround waiting that's causing the extra overhead.

I need to clarify for myself if SDRC self-refresh is even entered in C1.
When the CORE powerdomain is left on, I don't think the PRCM is would
send IDLEREQ to the SDRC, so it should not enter self refresh, but I
need to verify that.

> I don't know what side effects something like this might have though.

There are some other errata workaounds that you miss by not calling
omap_sram_idle().  Specifically, the call to omap3_intc_prepare_idle()
is important.

Kevin




[1]
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3e6b564..0fb3942 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -313,7 +313,7 @@ void omap_sram_idle(void)
 	if (save_state == 1 || save_state == 3)
 		cpu_suspend(save_state, omap34xx_do_sram_idle);
 	else
-		omap34xx_do_sram_idle(save_state);
+		cpu_do_idle();
 
 	/* Restore normal SDRC POWER settings */
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&


[2] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tmp/sdrc-hacks
