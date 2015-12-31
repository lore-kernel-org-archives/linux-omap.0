From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH] thermal: Schedule a backup thermal shutdown workqueue
 after a known period of time to tackle failed poweroff
Date: Thu, 31 Dec 2015 11:47:57 -0600
Message-ID: <56856A4D.7090804@ti.com>
References: <1450676778-7840-1-git-send-email-j-keerthy@ti.com>
 <5681742C.8050805@ti.com> <56824F81.7000202@ti.com>
 <20151231172906.GB11863@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20151231172906.GB11863@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, linux-omap@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/31/2015 11:29 AM, Eduardo Valentin wrote:
> can we have a shorter title?
> 
> On Tue, Dec 29, 2015 at 02:46:49PM +0530, Keerthy wrote:
>> Hi Nishanth,
>>
> 
> <cut> 
>>>
>>> I am not sure if this #ifdeffery is even needed.
>>>
>>>
>>> Eduardo, Rui: If this is not the suggested technique, maybe you guys
>>> could suggest how we could handle a case where userspace might be
>>> hungup due to some reason and a case where a critical temperature
>>> event in the middle of device probe was triggered?
> 
> Orderly power off is supposed to take care of this. Looking at the code,
> it will force a shutdown in case execution of userland command fails:
> 
> static int __orderly_poweroff(bool force)
> {
>         int ret;
> 
>         ret = run_cmd(poweroff_cmd);
> 
>         if (ret && force) {
>                 pr_warn("Failed to start orderly shutdown: forcing the issue\n");
> 
>                 /*
>                  * I guess this should try to kick off some daemon to sync and
>                  * poweroff asap.  Or not even bother syncing if we're doing an
>                  * emergency shutdown?
>                  */
>                 emergency_sync();
>                 kernel_power_off();
>         }

Yes, it will *IF* userspace fails. the condition that I had tracked
was before identifying the following fix[1] - Example fail is here[2]

In this case, tmp102 is setup for X15 as [3] - and built as a module.
as the kernel startsup filesystem and starts a modprobe of all modules
via udev rules, the probe of tmp102 detects (falsely) a critical
temperature condition. Shutdown attempt in the middle of driver probe
is always a tricky business.

As we look at the log in [2], Line  472
> thermal thermal_zone3: critical temperature reached(108 C),shutting down
We have userspace trigger for shutdown taking place.

Line 495: INIT: Sending processes the TERM signal

userspace starts shutting down services. (but note that probe for
other devices were either in progress or queued up to complete)..

at line 647 - we are in a weird place -> sysrq shows that system is
idled and userspace is shutdown and system is still active.


In this case, we entered the case thanks to a driver bug, but if this
situation was a real world temperature scenario, then we'd probably in
an overtemp scenario, then device damage could take place OR something
much worse.

The only alternative is to run a parallel thread in case userspace
fails to complete the job in some given period of time - due to what
ever be the condition triggering the problem.

I hope this explains the problem.

[1]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=00917b5c55aeb01322d5ab51af8c025b82959224
[2] http://pastebin.ubuntu.com/14326688/

[3]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/am57xx-beagle-x15.dts#n738

-- 
Regards,
Nishanth Menon
