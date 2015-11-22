From: Ran Shalit <ranshalit@gmail.com>
Subject: power states transitions
Date: Sun, 22 Nov 2015 17:58:40 +0200
Message-ID: <CAJ2oMhLmViYf=27nVh_=DBFyQLCcBT+985RTkMiwJZyav7Uiyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

I have stranhe behaviour in which even when there is no activity in
serial port, the retention counter is keep incremented all these time,
as if the cpu gets in and out of retention periodically.
I would expect the cpu to get into retention mode, when there is no
activity and stay in that state.
What can cause such behaviour ? Is it because some background process ?
These are the processes I see using ps command :

~ # ps
  PID USER       VSZ STAT COMMAND
    1 root      2088 S    init
    2 root         0 SW   [kthreadd]
    3 root         0 SW   [ksoftirqd/0]
    4 root         0 SW   [kworker/0:0]
    5 root         0 SW   [kworker/u:0]
    6 root         0 SW<  [khelper]
    7 root         0 SW   [irq/72-serial i]
    8 root         0 SW   [irq/73-serial i]
    9 root         0 SW   [irq/74-serial i]
   10 root         0 SW   [sync_supers]
   11 root         0 SW   [bdi-default]
   12 root         0 SW<  [kblockd]
   13 root         0 SW   [khubd]
   14 root         0 SW   [kseriod]
   15 root         0 SW<  [twl4030-irqchip]
   16 root         0 SW   [twl4030-irq]
   17 root         0 SW   [irq/378-twl4030]
   18 root         0 SW   [kworker/u:1]
   19 root         0 SW<  [musb-hdrc.0]
   20 root         0 SW<  [kconservative]
   21 root         0 SW   [kswapd0]
   22 root         0 SW<  [aio]
   23 root         0 SW<  [crypto]
   29 root         0 SW   [mtdblock0]
   30 root         0 SW   [mtdblock1]
   31 root         0 SW   [mtdblock2]
   32 root         0 SW   [mtdblock3]
   33 root         0 SW   [mtdblock4]
   34 root         0 SW   [mtdblock5]
   35 root         0 SW   [mtdblock6]
   36 root         0 SW   [mtdblock7]
   37 root         0 SW   [mtdblock8]
   38 root         0 SW   [mtdblock9]
   41 root         0 SW   [kworker/0:1]
   42 root         0 SW<  [kondemand]
   43 root         0 SWN  [jffs2_gcd_mtd5]
   46 root         0 SWN  [jffs2_gcd_mtd6]
   47 root         0 SWN  [jffs2_gcd_mtd8]
   48 root         0 SWN  [jffs2_gcd_mtd7]
   71 root      2364 S    /usr/sbin/inetd
   74 root      2092 S    -/bin/sh
   93 root      2092 R    ps
~ #

My original problem is that the ethernet performance is very low with
small windows. I thought that I can control this value by changing
sleep_latency parameter in
the following array. Yet, it did not help me. I don't know why.


static struct cpuidle_params cpuidle_params_table[] = {
/* C1 */
    {0, 2, 2, 5},        <-- changed valid to 0 (I am interested in
getting into deepest state)
/* C2 */
    {0, 10, 10, 30},     <-- changed valid to 0 (I am interested in
getting into deepest state)
/* C3 */
    {0, 50 , 50, 300},     <-- changed valid to 0 (I am interested in
getting into deepest state)
    /* C4 */
    {1, 1500000 , 1800, 4000},     <-- changed sleep_latency to 1500000
....
}


Best Regards,
Ran
