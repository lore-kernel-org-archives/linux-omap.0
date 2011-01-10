From: Etienne Le Sueur <elesueur@cse.unsw.edu.au>
Subject: cpuidle omap 4430, some clarifications please?
Date: Mon, 10 Jan 2011 16:05:30 +1100
Message-ID: <4D2A939A.6070602@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lemon.ertos.nicta.com.au ([203.143.174.143]:41587 "EHLO
	lemon.ken.nicta.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1AJFp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 00:45:58 -0500
Received: from vampire.ertos.nicta.com.au ([203.143.161.65]:59945 helo=simple.keg.ertos.in.nicta.com.au)
	by lemon.ken.nicta.com.au with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <elesueur@cse.unsw.edu.au>)
	id 1Pc9wh-0001BR-Gf
	for linux-omap@vger.kernel.org; Mon, 10 Jan 2011 16:05:33 +1100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm using linux-2.6.35.3 on a pandaboard taking power measurements in different idle states (I've written a userspace governor for cpuidle).

It seems like the code which is supposed to put the cores in deep sleep never actually gets called, see code below with my comments...

Taken from arch/arm/mach-omap2/cpuidle44xx.c, omap4_enter_idle, which gets called by cpuidle:

===============

     /*
      * Do only WFI for non-boot CPU(aux cores)
      */
     if (dev->cpu) {
         wmb();
         do_wfi();
         goto return_sleep_time;
     }

So on OMAP 4430, CPU1 never goes deeper than WFI?

     /*
      * Do only a WFI as long as CPU1 is online
      */
     if (num_online_cpus() > 1) {
         wmb();
         do_wfi();
         goto return_sleep_time;
     }

So while CPU1 is online (it never goes offline due to the above code) CPU0 will never go deeper than WFI?

     /*
      * Hold on till CPU1 hits OFF
      */
     cpu1_state = pwrdm_read_pwrst(cpu1_pd);
     if (cpu1_state != PWRDM_POWER_OFF) {
         wmb();
         do_wfi();
         goto return_sleep_time;
     }

It seems like CPU1 will never 'hit off' ?

     if (cx->type > OMAP4_STATE_C1)
         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);

#ifdef CONFIG_PM_DEBUG
     pwrdm_pre_transition();
#endif

The code below never gets called, therefore neither CPU0, CPU1 nor the MPU go into a deeper sleep state?

     pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
     omap4_set_pwrdm_state(mpu_pd, cx->mpu_state);

     omap4_set_pwrdm_state(core_pd, cx->core_state);

     omap4_enter_sleep(dev->cpu, cx->cpu0_state);

=================

Can someone clarify for me?

Cheers,
Etienne Le Sueur
