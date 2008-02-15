From: Tony Lindgren <tony@atomide.com>
Subject: Re: A thing of power beauty cpu-idle on arm.
Date: Fri, 15 Feb 2008 15:20:58 -0800
Message-ID: <20080215232057.GG16607@atomide.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429037DEC91@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429037DEC91@dlee13.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Dasu, Karthik P" <karthik-dp@ti.com>, linux-omap@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [080213 14:16]:
> Hi,
> 
> A bit of fun is working is slowly working its way to the tree.  After a
> couple teaks and a little c-state patch from Kevin Hilman it looks like
> powertop will be able to live on ARM/OMAP3.
> 
> Our first pass of internal code has come together enough to have cpuidle
> + cpufreq running ++.  Hopefully, after some time and more work that
> reference can be leveraged to see the same on kernel.org.  Lots of work
> to do on that path...
> 
> If the png picture makes it, it can be seen given the load which was
> running, all C-States have been touched and most P-States!  The P-State
> picture only has ARM displayed, might be nice to see if Intel is open to
> listing speed for the other asymmetric processors and the IO domain.
> Given the background load residency isn't so great, but OFF mode is
> being touched.
> 
> In the current definition:
> 	C0 - wfi
> 	C1 - wfi + dtick
> 	C2 - mpu-retention, core-active
> 	C3 - mpu-off, core-active
> 	C4 - mpu-ret, core-ret
> 	C5 - mpu-off, core-ret
> 	C6 - mpu-off, core-off  (0-volts)
> 
> Thanks to Adam Belay for cpuidle work!
> 
> Regards,
> Richard W.
> 
> root@128.247.75.85:/tst# ./powertop-static -d -t 60
> PowerTOP 1.9    (C) 2007 Intel Corporation
> 
> Collecting data for 60 seconds
> Cn                Avg residency
> C0 (cpu running)        ( 7.9%)
> C1              934.7ms (89.0%)
> C2               44.4ms ( 2.7%)
> C3                0.0ms ( 0.0%)
> C4                5.5ms ( 0.3%)
> C5                3.5ms ( 0.2%)
> C6                0.4ms ( 0.0%)
> P-states (frequencies)
>    550 Mhz     8.0%
>    500 Mhz     0.0%
>    250 Mhz     0.0%
>    125 Mhz    92.0%
> Wakeups-from-idle per second :  2.9     interval: 60.0s
> Top causes for wakeups:
>   56.8% ( 12.4)       <interrupt> : 32KHz timer
>   11.4% (  2.5)       <interrupt> : prcm
>   10.4% (  2.3)       <interrupt> : eth0
>    7.3% (  1.6)              bash : queue_delayed_work_on
> (delayed_work_timer_fn
> )
>    4.6% (  1.0)     <kernel core> : __netdev_watchdog_up (dev_watchdog)
>    2.3% (  0.5)     <kernel core> : queue_delayed_work_on
> (delayed_work_timer_fn
> )
>    1.5% (  0.3)     <kernel core> : irlmp_start_discovery_timer
> (irlmp_discovery
> _timer_expired)
>    1.5% (  0.3)             mvltd : schedule_timeout (process_timeout)
>    1.1% (  0.2)     <kernel core> : neigh_table_init_no_netlink
> (neigh_periodic_
> timer)
>    0.9% (  0.2)     <kernel core> : page_writeback_init (wb_timer_fn)
>    0.9% (  0.2)              init : schedule_timeout (process_timeout)
>    0.2% (  0.1)     <kernel core> : sk_reset_timer (tcp_delack_timer)
>    0.2% (  0.1)        in.telnetd : sk_reset_timer (tcp_write_timerS
>    0.2% (  0.1)     <kernel core> : neigh_update (neigh_timer_handler)
>    0.2% (  0.0)       <interrupt> : serial
>    0.2% (  0.0)     <kernel core> : cache_register
> (delayed_work_timer_fn)
>    0.1% (  0.0)     <kernel core> : ip_rt_init (rt_check_expire)
>    0.1% (  0.0)   powertop-static : schedule_timeout (process_timeout)

Cool :) Nice to see the timer interrupts are also pretty low nowadays
with dyntick / NO_HZ.

Tony
