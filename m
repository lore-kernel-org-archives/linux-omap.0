From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Date: Mon, 09 Jul 2018 14:25:33 +0300
Message-ID: <79db809d74dcbe84b7ed3001dd7c82649227783a.camel@linux.intel.com>
References: <20180708174939.GA10002@amd> <20180708193720.GA13262@amd>
         <20180709102852.GA20580@amd> <20180709104943.GA5212@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709104943.GA5212@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 2018-07-09 at 12:49 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > grep in /sys produces a nasty oops:
> > > > 
> > > > I guess next step is trying to find out which file that is..
> > > 
> > > Let me see...
> > > 
> > > openat(6, "suspend",
> > > O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) = 4
> > > fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> > > read(4, 0x4d2000, 32768)                = -1 EINVAL (Invalid
> > > argument)
> > > write(2, "grep: ", 6grep: )                   = 6
> > > write(2, "/sys/kernel/debug/pm_debug/cefus"...,
> > > 47/sys/kernel/debug/pm_debug/cefuse_pwrdm/suspend) = 47
> > > write(2, ": Invalid argument", 18: Invalid argument)      = 18
> > > write(2, "\n", 1
> > > )                       = 1
> > > close(4)                                = 0
> > > close(6)                                = 0
> > > openat(5, "time",
> > > O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW)
> > > = 4
> > > fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> > > read(4, "cefuse_pwrdm (OFF),OFF:641441757"..., 32768) = 849
> > > read(4, "", 28672)                      = 0
> > > close(4)                                = 0
> > > openat(5, "count",
> > > O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) = 4
> > > Connection to usb closed by remote host.
> > > Connection to usb closed.
> > > pavel@half:~$
> > > 
> > > Ok, so it seems to be:
> > > 
> > > user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
> > > (oops).
> > > 
> > > The file seems to be world-readable.
> > > 
> > > user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> > > -r--r--r-- 1 root root 0 Jan  1  1970
> > > /sys/kernel/debug/pm_debug/count
> > > 
> > > But on PC, that file does not exist.
> > 
> > Ok, it is easier to reproduce like this:
> > 
> > sudo mount /dev/zero -t debugfs /sys/kernel/debug/
> > sudo cat /sys/kernel/debug/pm_debug/count
> > 
> > I tried adding debugging like this:
> 
> Confused.
> 
> 
> >  	seq_printf(s, "%s->%s (%d)\n", clkdm->name, clkdm-
> > >pwrdm.ptr->name,
> >  		   clkdm->usecount);
> 
> I replaced seq_prinf with printk, and it still crashes, after
> producing reasonable output.
> 

You need to add printk to the show function as well. It might be last
item in the list which is problematic (or one after cefuse CLK domain.

> [   74.852508] cmp...
> [   74.855773] printf...
> [   74.859313] l4_cfg_clkdm->core_pwrdm (0)
> [   74.864532] done...
> [   74.867889] cmp...
> [   74.871154] printf...
> [   74.874694] l4_cefuse_clkdm->cefuse_pwrdm (0)
> [   74.880340] done...
> [   74.883728] ------------[ cut here ]------------
> [   74.889709] WARNING: CPU: 0 PID: 2127 at
> drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x23c/0x380
> [   74.900695] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2
> (Read): Data Access in User mode during Functional access
> [   74.915222] Modules linked in:
> [   74.919982] CPU: 0 PID: 2127 Comm: cat Not tainted
> 4.18.0-rc4-88970-gf075a2c-dirty #763
> [   74.929870] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [   74.937805] [<c010f6cc>] (unwind_backtrace) from [<c010ba50>]
> (show_stack+0x10/0x14)
> 
> 									
> Pavel

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
