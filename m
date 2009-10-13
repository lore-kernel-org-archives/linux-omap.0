From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Broken cpuidle on PM branch?
Date: Tue, 13 Oct 2009 07:05:46 -0700
Message-ID: <87fx9npex1.fsf@deeprootsystems.com>
References: <20091012192347.GI32041@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f197.google.com ([209.85.222.197]:50060 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbZJMOHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 10:07:00 -0400
Received: by pzk35 with SMTP id 35so4691370pzk.22
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 07:05:48 -0700 (PDT)
In-Reply-To: <20091012192347.GI32041@smtp.gmail.com> (Amit Kucheria's message of "Mon\, 12 Oct 2009 22\:23\:47 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Amit Kucheria <amit.kucheria@verdurent.com> writes:

> Hi,
>
> I am testing twl4030 script optimisations on the current PM branch. But I am
> seeing the board (RX51) freeze when CPU_IDLE is enabled in the config.
>
> Is it known to work on other boards?

Yes, and it works for me on RX51 as well, output of the maemo powertop
below.

For a known working defconfig, start from omap3_pm_defconfig and
change the low-level debug UART from UART1 to UART3.

There is a known UART bug in the current PM branch where if you don't
'echo 1 > /debug/pm_debug/sleep_while_idle', the UART eventually locks
up when the inactivity timer expires.  I'm still looking into this
one.

Kevin


/ # powertop                                                                    
Powertop 1.13.1                                                                 
status: Unable to send message: Connection refused                              
Mounting debugfs...Success                                                      
Sleeping for 11 seconds before sampling                                         
Collecting data for 30 seconds                                                  
Sample interval was 00m 30s 20569us                                             
                                                                                
C#      | Ratio  | Avg/dura | Frequency | Ratio                                 
--------+--------+----------+-----------+--------------                         
     C0 |  83.4% |          |   600 MHz |   0.0%                                
     C1 |  16.6% |  832.4ms |   550 MHz |   0.0%                                
     C2 |   0.0% |          |   500 MHz | 100.0%                                
     C3 |   0.0% |          |   250 MHz |   0.0%                                
     C4 |   0.0% |          |   125 MHz |   0.0%                                
                                                                                
IRQ#    | Activity   | Type           | Name                                    
--------+------------+----------------+---------------------------              
     37 |         27 |           INTC | gp                                      
     11 |         23 |           INTC | prcm                                    
     12 |          4 |           INTC | DMA                                     
    225 |          2 |           GPIO | omap2-onenand                           
                                                                                
PID#    | Activity   | Name           | Function Entry (Expire)                 
--------+------------+----------------+---------------------------              
      0 |         16 |  <kernel core> | hrtimer_start (tick_sched_timer)        
     93 |          5 |    bdi-default | bdi_forker_task (process_timeout)       
    483 |          5 |flush-ubifs_0_0 | schedule_timeout_interruptible (process)
      0 |          4 |  <kernel core> | arm_supers_timer (sync_supers_timer_fn) 
      5 |          3 |       events/0 | queue_delayed_work (delayed_work_timer_)
    483 |          1 |flush-ubifs_0_0 | hrtimer_start_range_ns (wbuf_timer_call)
    483 |          1 |flush-ubifs_0_0 | hrtimer_start_range_ns (wbuf_timer_call)
    484 |          1 |       powertop | hrtimer_start_range_ns (hrtimer_wakeup) 
                                                                                
Power domain activity breakdown                                                 
Domain  | % of time spent in states                                             
--------+---------+---------+---------+---------+----------                     
usbhost |OFF:   0%|RET: 100%|INA:   0%| ON:   0%| now:(RET)                     
    sgx |OFF: 100%|RET:   0%|INA:   0%| ON:   0%| now:(OFF)                     
    per |OFF:   0%|RET:  83%|INA:   0%| ON:  16%| now:(ON)                      
    dss |OFF:   0%|RET: 100%|INA:   0%| ON:   0%| now:(RET)                     
    cam |OFF:   0%|RET: 100%|INA:   0%| ON:   0%| now:(RET)                     
   core |OFF:   0%|RET:  83%|INA:   0%| ON:  16%| now:(ON)                      
   neon |OFF:   0%|RET:  83%|INA:   0%| ON:  16%| now:(ON)                      
    mpu |OFF:   0%|RET:  83%|INA:   0%| ON:  16%| now:(ON)                      
   iva2 |OFF:   0%|RET: 100%|INA:   0%| ON:   0%| now:(RET)                     
                                                                                
Clock activity breakdown at end of period                                       
Domain  | Active clocks                                                         
--------+---------------+---------------+------------------                     
   core |          SDRC |      OMAPCTRL |         UART1                         
        |         UART2 |                                                       
  core3 |       USBTLL                                                          
   wkup |          GPT1 |       32KSYNC |         GPIO1                         
        |                                                                       
  ckgen |          CORE |          PERI |           96M                         
        |           48M |           12M |           54M                         
        |      EMU_CORE |                                                       
    per |         UART3 |         GPIO2 |         GPIO3                         
        |         GPIO4 |         GPIO5 |         GPIO6                         
        |                                                                       
                                                                                
Total wakeups    92,   3.1/s | IRQ   56,   1.9/s | Timers   36,   1.2/s         
HW wakeups       23,   0.8/s |     Real gp_timers expired   27,   0.9/s         
Dismounting debufs...Success                                                    
/ # 

