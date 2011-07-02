From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 00/11] PM QoS: add a per-device wake-up latency constraint class
Date: Sat, 2 Jul 2011 21:20:46 +0200
Message-ID: <201107022120.47221.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50253 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab1GBTUK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Jul 2011 15:20:10 -0400
In-Reply-To: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

Hi,

On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch set is in an RFC state, for review and comments.

First off, I'm sorry I couldn't review the patchset earlier.

> In order to implement the new class in PM QoS the following changes have been
> made:
> 
> 1. Add a new PM QoS class for device wake-up constraints
> (PM_QOS_DEV_WAKEUP_LATENCY).
> Due to the per-device nature of the new class the constraints lists are stored
> inside the device dev_pm_info struct instead of the internal per-class
> constraints lists.
> The new class is only available from kernel drivers and so is not exported to
> user space.

Have you considered a design in which multiple devices may use the same
list of constraints?  It seems plausible that the constraints will be the
same, for example, for all Ethernet adapters in the system, in which case it
will be wasteful to duplicate the list of constraints for each of them.

> 2. Added a notification of device insertion/removal from the device PM framework
> to PM QoS.
> This allows to init/de-init the per-device constraints list upon device insertion
> and removal.
> RFC state for comments and review, barely tested

I need to have a look at the details, but in principle this means that the
per-device lists will be usable only after the devices have been registered.
In particular, this means that it will only be possible to add new constraints
after registering the device, which may be too late for some use cases.

> 3. Make the pm_qos_add_request API more generic by using a
> struct pm_qos_parameters parameter. This allows easy extension in the future.
> 
> 4. Upon a change of the strongest constraint in the PM_QOS_DEV_WAKEUP_LATENCY
> class a notification chain mechanism is used to take action on the system.
> This is the proposed way to have PM QoS and the platform dependant code to
> interact with each other, cf. 4 below.

I guess you mean 5.?

I think we will need something in addition to the notifier here.  For example,
I wouldn't like any core code, like runtime PM or cpuidle, to have to register
a notifier with PM QoS.

> The notification mechanism now passes the constraint request struct ptr in
> order for the notifier callback to have access to the full set of constraint
> data, e.g. the struct device ptr.
> 
> 5. cpuidle interaction with the OMAP3 cpuidle handler
> Since cpuidle is a CPU centric framework it decides the MPU next power state
> based on the MPU exit_latency and target_residency figures.
>     
> The rest of the power domains get their next power state programmed from
> the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework, via the device
> wake-up latency constraints.
> 
> Note: the exit_latency and target_residency figures of the MPU include the MPU
> itself and the peripherals needed for the MPU to execute instructions (e.g.
> main memory, caches, IRQ controller, MMU etc).
> Some of those peripherals can belong to other power domains than the MPU
> subsystem and so the corresponding latencies must be included in those figures.
> 
> 6. Update the pm_qos_add_request callers to the generic API
> 
> 7. Minor clean-ups and rename of struct fields
> 
> Questions:
> 1. How to retrieve the device ptr from a given device driver in order to add
> a constraint on it?
> 2. The device struct has recently been extended with the power domain
> information. Can this be used to apply the constraints on power domains?

Yes, it can in principle, but that will require some work.

> On-going developments, patches in preparation:
> 1. write Documentation for the new PM QoS class

I'd wait with that until the code has settled.

> 2. validate the constraints framework on OMAP4 HW (done on OMAP3)
> 3. refine the power domains wake-up latency and the cpuidle figures
> 
> Based on the master branch of the linux-omap git tree (3.0.0-rc3). Compile
> tested using OMAP and x86 generic defconfigs.
> Tested on OMAP3 Beagleboard (ES2.x) with full RETention and OFF modes.

More detailed comments will follow.

Thanks,
Rafael
