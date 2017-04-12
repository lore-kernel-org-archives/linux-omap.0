From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 16:26:20 +0800
Message-ID: <1491985580.2357.39.camel@intel.com>
References: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
         <20170411172918.GA5193@localhost.localdomain>
         <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
         <1491967248.2357.25.camel@intel.com>
         <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
         <20170412040542.GA11305@localhost.localdomain>
         <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, 2017-04-12 at 13:25 +0530, Keerthy wrote:
> 
> On Wednesday 12 April 2017 09:35 AM, Eduardo Valentin wrote:
> > 
> > Keerthy,
> > 
> > On Wed, Apr 12, 2017 at 09:09:36AM +0530, Keerthy wrote:
> > > 
> > > 
> > > 
> > > On Wednesday 12 April 2017 08:50 AM, Zhang Rui wrote:
> > > > 
> > > > On Wed, 2017-04-12 at 08:19 +0530, Keerthy wrote:
> > > > > 
> > > > > 
> > > > > On Tuesday 11 April 2017 10:59 PM, Eduardo Valentin wrote:
> > > > > > 
> > > > > > 
> > > > > > Hey,
> > > > > > 
> > > > > > On Fri, Mar 31, 2017 at 12:00:20PM +0530, Keerthy wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > off).
> > <cut>
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > OK... This seams to me, still a corner case supposed to be
> > > > > > fixed at
> > > > > > orderly_power_off, not at thermal. But..
> > > > > > 
> > ^^^ Then again, this must be fixed not at thermal core. And re-
> > reading
> > the history of this thread, this seams to be really something
> > broken at
> > OMAP/DRA7, as mentioned in previous messages. That is probably why
> > you
> > are pushing for pm_power_off(), which seams to be the one that
> > works for
> > you, pulling the plug correctly (DRA7).
> Zhang/Eduardo,
> 
> OMAP5/DRA7 is one case.
> 
> I believe i this is the root cause of this failure.
> 
> thermal_zone_device_check --> thermal_zone_device_update -->
> handle_thermal_trip --> handle_critical_trips --> orderly_poweroff
> 
> The above sequence happens every 250/500 mS based on the
> configuration.
> The orderly_poweroff function is getting called every 250/500 mS and
> i
> see with a full fledged nfs file system it takes at least 5-10
> Seconds
> to shutdown and during that time we bombard with orderly_poweroff
> calls
> multiple times due to the thermal_zone_device_check triggering
> periodically.
> 
> To confirm that i made sure that handle_critical_trips calls
> orderly_poweroff only once and i no longer see the failure on DRA72-
> EVM
> board.
> 
Nice catch!

> So IMHO once we get to handle_critical_trips case where we do
> orderly_poweroff we need to do the following:
> 
> 1) Make sure that orderly_poweroff is called only once.

agreed.

> 2) Cancel all the scheduled work queues to monitor the temperature as
> we have already reached a point of shutting down the system.
> 
agreed.

now I think we've found the root cause of the problem.
orderly_poweroff() is not reenterable and it does not have to be.
If we're using orderly_poweroff() for emergency power off, we have to
use it correctly.

will you generate a patch to do this?

thanks,
rui

> Let me know your thoughts on this.
> 
> Best Regards,
> Keerthy
> > 
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > However, there is no clean way of detecting such failure
> > > > > > > of
> > > > > > > userspace
> > > > > > > powering off the system. In such scenarios, it is
> > > > > > > necessary for a
> > > > > > > backup
> > > > > > > workqueue to be able to force a shutdown of the system
> > > > > > > when
> > > > > > > orderly
> > > > > > > shutdown is not successful after a configurable time
> > > > > > > period.
> > > > > > > 
> > > > > > Given that system running hot is a thermal issue, I guess
> > > > > > we care
> > > > > > more
> > > > > > on this matter then..
> > > > > Yes!
> > > > > 
> > > > I just read this thread again https://patchwork.kernel.org/patc
> > > > h/802458
> > > > 1/ to recall the previous discussion.
> > > > 
> > > > https://patchwork.kernel.org/patch/8149891/
> > > > https://patchwork.kernel.org/patch/8149861/
> > > > should be the solution made based on Ingo' suggestion, right?
> > > > 
> > > > And to me, this sounds like the right direction to go, thermal
> > > > does not
> > > > need a back up shutdown solution, it just needs a kernel
> > > > function call
> > > > which guarantees the system can be shutdown/reboot immediately.
> > > > 
> > > > is there any reason that patch 1/2 is not accepted?
> > > Zhang,
> > > 
> > > http://www.serverphorums.com/read.php?12,1400964
> > > 
> > > I got a NAK from Alan and was given this direction on a
> > > thermal_poweroff
> > > which is more or less what is done in this patch.
> > > 
> > 
> > Actually, Alan's suggestion is more for you to define a
> > thermal_poweroff() that can be defined per architecture.
> > 
> > Also, please, keep track of your patch versions and also do copy
> > everybody who has stated their opinion on previous discussions.
> > These
> > patches must have Ingo, Alan, and RMK copied too. In this way we
> > avoid
> > loosing track of what has been suggested and we also converge
> > faster to
> > something everybody (or most of us) agree. Next version, please,
> > fix
> > that.
> > 
> > 
> > To me, thermal core needs a function that simply powers off the
> > system.
> > No timeouts, delayed works, backups, etc. Simple and straight.
> > 
> > The idea of having a per architecture implementation, as per Alan's
> > suggestion, makes sense to me too. Having something different from
> > pm_power_off(), specific to thermal, might also give the
> > opportunity to
> > save the power off reason.
> > 
> > BR,
> > 
> > Eduardo Valentin
> > 
