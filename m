From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH] thermal: Schedule a backup thermal shutdown
 workqueue after a known period of time to tackle failed poweroff
Date: Thu, 31 Dec 2015 10:20:17 -0800
Message-ID: <20151231182016.GA14127@localhost.localdomain>
References: <1450676778-7840-1-git-send-email-j-keerthy@ti.com>
 <5681742C.8050805@ti.com>
 <56824F81.7000202@ti.com>
 <20151231172906.GB11863@localhost.localdomain>
 <56856A4D.7090804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56856A4D.7090804@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Keerthy <a0393675@ti.com>, Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, linux-omap@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 31, 2015 at 11:47:57AM -0600, Nishanth Menon wrote:
> On 12/31/2015 11:29 AM, Eduardo Valentin wrote:
> > can we have a shorter title?
> > 
> > 
> > Orderly power off is supposed to take care of this. Looking at the code,
> > it will force a shutdown in case execution of userland command fails:
> > 
> > static int __orderly_poweroff(bool force)
> > {
> >         int ret;
> > 
> >         ret = run_cmd(poweroff_cmd);
> > 
> >         if (ret && force) {
> >                 pr_warn("Failed to start orderly shutdown: forcing the issue\n");
> > 
> >                 /*
> >                  * I guess this should try to kick off some daemon to sync and
> >                  * poweroff asap.  Or not even bother syncing if we're doing an
> >                  * emergency shutdown?
> >                  */
> >                 emergency_sync();
> >                 kernel_power_off();
> >         }
> 
> Yes, it will *IF* userspace fails. the condition that I had tracked
> was before identifying the following fix[1] - Example fail is here[2]
> 

OK. But still, why other users of orderly_poweroff do not
deserve to be fixed, then?

> 
> I hope this explains the problem.
> 
> [1]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=00917b5c55aeb01322d5ab51af8c025b82959224
> [2] http://pastebin.ubuntu.com/14326688/
> 
> [3]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/am57xx-beagle-x15.dts#n738
> 
> -- 
> Regards,
> Nishanth Menon
