From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Thu, 06 Dec 2012 02:00:51 +0100
Message-ID: <4021362.qnrKDZ6JS9@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1212041150430.1800-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1212041150430.1800-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-pm mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Well, I'm not any less busy than yesterday, as it turns out, but I'm expecting
that to continue tomorrow, so I may as well have a look at it now. :-)

On Tuesday, December 04, 2012 12:10:32 PM Alan Stern wrote:
> [CC: list trimmed; the people who were on it should be subscribed to at 
> least one of the lists anyway.]
> 

[...]

> 
> > Not only regulators involved, clock or other things might be involved too.
> > Also the same power domain might be shared with more than one port,
> > so it is better to introduce power domain to the problem. Looks
> > generic_pm_domain is overkill, so I introduced power controller which
> > only focuses on power on/off and being shared by multiple devices.   
> 
> Even though it is overkill, it may be better than introducing a new 
> abstraction.  After all, this is exactly the sort of thing that PM 
> domains were originally created to handle.
> 
> Rafael, do you have any advice on this?  The generic_pm_domain 
> structure is fairly complicated, there's a lot of code in 
> drivers/base/power/domain.c (it's the biggest source file in its 
> directory), and I'm not aware of any documentation.

Yeah, documentation is missing, which obviously is my fault.

That code is designed to cover the case in which multiple devices share
a "power switch" that can be used to remove power from all of them at
once (eg. through a register write).  It also assumes that there will
be a "stop" operation, such as "disable clock", allowing each device in
the domain to be put into a shallow low-power state (individually) without
the necessity to save its state.  Device states only have to be saved
when the "power switch" is about to be used, which generally happens
when they all have been "stopped" (their runtime PM status is RPM_SUSPENDED).

The "stop" operation may be defined in a different way for each device in the
domain (actually, that applies to the "save state", "restore state", and
"start" - opposite to "stop" - operations too) and PM QoS latency constraints
are used to decide if and when to turn the whole domain off.  Moreover, it
supports hierarchies of power domains that may be pretty much arbitarily
complicated.

A big part of this code is for the handling of system suspend/resume
in such a way that it is consistent with runtime PM.

For USB ports I'd recommend to use something simpler. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
