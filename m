From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: cpuidle and NO_HZ <boot speedup>
Date: Fri, 23 Jan 2009 12:14:37 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203767D8B64@dlee02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301C6DD0347@dbde02.ent.ti.com>
	<8bf247760901220906n1ab095a0h695e9c1f5e8db916@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C6DD03F9@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C6EC7222@dbde02.ent.ti.com>
	<8bf247760901230752h4835083foaa486311425c6c68@mail.gmail.com>
 <87ab9i6i9j.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41419 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZAWSPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 13:15:20 -0500
In-Reply-To: <87ab9i6i9j.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Sriram V <vshrirama@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>


> Alternatively, you you do some experiments to see exactly which
> C-states are causing the problems.  You could modify cpuidle34xx.c and
> set the 'valid' flag in the higher C-states to zero so that they
> cannot be entered and see which C-states (if any) are working.

I recently added the following hack which cut boot time in half and removed many early network issues.

I've not converted it to the latest kernel but how to do it is simple.

Basically it delays as long as possible CPUIdle init to remove its cost during a lot of boot.  Then it sets a constraint which is command line override-able to allow the application to boot.

We recommend doing this along with setting an OPP constraint so you're in overdrive during boot time.  Today we start off with performance governor to achieve this, then switch to on-demand for tracking later on.

During boot and initial applications startup you want these things.

Probably I'll update it to pmqos in a few weeks if I have time.  It has shown to be worth while in speeding up boot up.

diff -purN img/2.6_kernel/arch/arm/mach-omap2/pm_idle_34xx.c 2.6_kernel/arch/arm/mach-omap2/pm_idle_34xx.c
--- img/2.6_kernel/arch/arm/mach-omap2/pm_idle_34xx.c   2008-12-09 20:24:31.000000000 -0600
+++ 2.6_kernel/arch/arm/mach-omap2/pm_idle_34xx.c       2008-12-19 20:13:30.000000000 -0600
@@ -917,6 +918,24 @@ struct cpuidle_driver omap3_idle_driver
        .owner =        THIS_MODULE,
 };

+/* Gate long latency C states for 20 seconds to reduce boot time */
+static unsigned int __initdata boot_noidle_time = 20;
+
+/* Command line override to allow matching with application start time */
+static int __init boot_noidle_time_setup(char *str)
+{
+       get_option(&str, &boot_noidle_time);
+       return 1;
+}
+__setup("boot_noidle_time=", boot_noidle_time_setup);
+
+
+struct timer_list boot_timer;
+static void omap_boot_timer(unsigned long arg)
+{
+       remove_acceptable_latency("idle_delay");
+}
+
 int omap3_idle_init(void)
 {
        int i, count = 0;
@@ -963,6 +982,15 @@ int omap3_idle_init(void)
        /* Initialize UART inactivity time */
        awake_time_end = jiffies + msecs_to_jiffies(UART_TIME_OUT);

+       /* For boot speed restrict C-State to C0 until boot done */
+       init_timer(&boot_timer);
+       boot_timer.function = omap_boot_timer;
+       boot_timer.data = (unsigned long)NULL;
+       boot_timer.expires = boot_noidle_time * HZ + jiffies;
+       add_timer(&boot_timer);
+       set_acceptable_latency("idle_delay", 10);
+
        return 0;
 }
-__initcall(omap3_idle_init);
+/* Install omap3_idle idle last to speed up boot */
+late_initcall_sync(omap3_idle_init);
diff -purN img/2.6_kernel/kernel/latency.c 2.6_kernel/kernel/latency.c
--- img/2.6_kernel/kernel/latency.c     2008-10-17 14:10:28.000000000 -0500
+++ 2.6_kernel/kernel/latency.c 2008-12-18 19:44:22.000000000 -0600
@@ -269,11 +269,13 @@ EXPORT_SYMBOL_GPL(unregister_latency_not
 static __init int latency_init(void)
 {
        atomic_set(&current_max_latency, INFINITE_LATENCY);
+#ifndef CONFIG_OMAP3_PM
        /*
         * we don't want by default to have longer latencies than 2 ticks,
         * since that would cause lost ticks
         */
        set_acceptable_latency("kernel", 2*1000000/HZ);
+#endif
        return 0;
 }

