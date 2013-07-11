From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 6/6] USB: ehci-omap: Implement suspend/resume
Date: Thu, 11 Jul 2013 11:14:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307111106090.1276-100000@iolanthe.rowland.org>
References: <51DE71F3.1040101@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51DE71F3.1040101-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ruslan.bilovol-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 11 Jul 2013, Roger Quadros wrote:

> > The other two problems are both related to the interaction between
> > system PM and runtime PM.  Suppose the controller is already runtime
> > suspended when the system goes to sleep.  Because it is runtime
> > suspended, it is enabled for wakeup.  But device_may_wakeup() could
> > return false; if this happens then you have to do a runtime-resume in
> > omap_ehci_suspend() before calling ehci_suspend(), so that the
> > controller can be suspended again with wakeups disabled.  (Or you could
> > choose an alternative method for accomplishing the same result, such as
> > disabling the wakeup signal from the pad without going through a whole
> > EHCI resume/suspend cycle.)  Conversely, if device_may_wakeup() returns
> > true then you shouldn't do anything at all, because the controller is
> > already suspended with the correct wakeup setting.
> 
> I think this case is taken care of by the Runtime PM core at least for the OMAP
> platform according to the documentation
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/runtime_pm.txt#n647

No; that section refers only to races, not to wakeup settings.

> At the end of this mail is the log during system suspend/resume
> 
> You can notice the following sequence
> 
> -ehci runtime suspends
> -system suspend triggered
> -ehci runtime resumes
> -ehci suspends (uses new wakeup settings)
> -system wakeup triggered
> -ehci resumes
> -ehci runtime suspends

This is because the root hub was runtime suspended with the wrong
wakeup setting.  The USB core, which is careful about these things,
resumed and re-suspended it with the proper wakeup setting.  In the 
process, the controller had to be runtime resumed as well.

Try doing the test over again, but this time with the root hub enabled 
for wakeup and the controller disabled.  (I know this is a bizarre 
combination, but try it anyway.)  Also, after the system wakes up, see 
whether the root hub and controller get runtime suspended.

> > For the third problem, suppose the controller was runtime suspended
> > when the system went to sleep.  When the system wakes up, the
> > controller will become active, so you have to inform the runtime PM
> > core about its change of state.  Basically, if omap_ehci_resume() sees
> > that ehci_resume() returned 0 then it must do:
> > 
> > 	pm_runtime_disable(dev);
> > 	pm_runtime_set_active(dev);
> > 	pm_runtime_enable(dev);
> > 
> > All of these issues are discussed (among lots of other material) in 
> > Documentation/power/runtime_pm.txt.
> 
> Is this still applicable? Documentation claims
> 
>    "During system resume it calls pm_runtime_enable() and pm_runtime_put_sync()
>     for every device right after executing the subsystem-level .resume_early()
>     callback and right after executing the subsystem-level .resume() callback
>     for it, respectively."

Yes, this is applicable, but it is irrelevant to the problem I 
described.  You still have to tell the runtime PM core that the device 
is now active.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
