From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 00/15] PM QoS: add a per-device latency constraints class
Date: Fri, 12 Aug 2011 10:02:24 +0200
Message-ID: <201108121002.25207.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36605 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab1HLIAq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 04:00:46 -0400
In-Reply-To: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch set is in an RFC state, for review and comments.
> 
> High level implementation:
> 
> 1. Preparation of the PM QoS for the addition of a device PM QoS constraints
>    framework:
>   . rename and move of the PM QoS implementation files to kernel/power/qos.c
>     and include/linux/pm_qos.h
>   . rename of API parameters and internal fields names
>   . Move around the PM QoS misc devices management code for better readability
>   . re-organize the internal data structs
>   . generalize and export the constraints management core code
> 
> 2. Implementation of the per-device PM QoS constraints:
>   . create drivers/base/power/qos.c for the implementation
>   . create a device PM QoS API, which calls the PM QoS constraints management
>     core code
>   . the per-device latency constraints data strctures are stored in the device
>     dev_pm_info struct
>   . the device PM code calls the init and destroy of the per-device constraints
>     data struct in order to support the dynamic insertion and removal of the
>     devices in the system.
>   . to minimize the data usage by the per-device constraints, the data struct
>     is only allocated at the first call to dev_pm_qos_add_request. The data
>     is later free'd when the device is removed from the system
>   . per-device notification callbacks can be registered and called upon a
>     change to the aggregated constraint value
> 
> 3. add a global notification mechanism for the device constraints
>   . add a global notification chain that gets called upon changes to the
>     aggregated constraint value for any device.
>   . the notification callbacks are passing the full constraint request data
>     in order for the callees to have access to it. The current use is for the
>     platform low-level code to access the target device of the constraint
> 
> 4. Implement the OMAP low level constraints management code
>   . create a PM layer plugin for per-device constraints, compiled under
>     CONFIG_OMAP_PM_CONSTRAINTS=y
>   . implement the devices wake-up latency constraints using the global
>     device PM QoS notification handler which applies the constraints to the
>     underlying layer
>   . implement the low level code which controls the power domains next power
>     states, through the hwmod and pwrdm layers
>   . add (preliminary) power domains wake-up latency figures for OMAP3&4
>   . cpuidle is a CPU centric framework so it decides the MPU next power state
>     based on the MPU exit_latency and target_residency figures. The rest of
>     the power domains get their next power state programmed from the devices
>     PM QoS framework, via the devices wake-up latency constraints.
>   . convert the OMAP I2C driver to the PM QoS API for MPU latency constraints
> 
> 
> Questions:
> 1. the user space API is still under discussions on linux-omap and linux-pm MLs,
>    cf. [1]. The idea is to add a user-space API for the devices constratins
>    PM QoS, using a sysfs entry per device
> 
> [1] http://marc.info/?l=linux-omap&m=131232344503327&w=2
> 
> ToDo:
> 1. write Documentation for the new PM QoS class, once the RFC is agreed on
> 2. validate the constraints framework on OMAP4 HW (done on OMAP3)
> 3. Need testing on platforms other than OMAP
> 4. refine the power domains wake-up latency and the cpuidle figures
> 5. re-visit the OMAP power domains states initialization procedure. Currently
>    the power states that have been changed from the constraints API which were
>    applied before the initialization of the power domains are lost
> 
>    
> Based on the master branch of the linux-omap git tree (3.0.0-rc7). Compile
> tested using OMAP and x86 generic defconfigs.
> 
> Lightly tested on OMAP3 Beagleboard (ES2.x).
> Need testing on platforms other than OMAP, because of the impact on the
> device insertion/removal in device_pm_add/remove

The patchset looks really good to me, I don't think I have any major
complaints about this version.

The only thing I'd like to ask at the moment is whether or not the
compilation of drivers/base/power/qos.c should depend on
CONFIG_PM_RUNTIME.  Do you think it will be used by system suspend code on any
platforms?

Also, I'd like to take the final patchset for 3.2, but I don't feel
confident enough about the OMAP patches.  If you want me to take them too,
please make sure they are ACKed by the OMAP maintainers.

Thanks,
Rafael
