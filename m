From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v6 0/7] PM QoS: add a per-device latency constraints framework
Date: Thu, 18 Aug 2011 09:59:00 +0200
Message-ID: <201108180959.00827.rjw@sisk.pl>
References: <1313609965-6568-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49338 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755249Ab1HRH5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Aug 2011 03:57:17 -0400
In-Reply-To: <1313609965-6568-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi,

On Wednesday, August 17, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
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
>   . a global mutex protects the constraints users from the data being
>     allocated and free'd.
> 
> 3. add a global notification mechanism for the device constraints
>   . add a global notification chain that gets called upon changes to the
>     aggregated constraint value for any device.
>   . the notification callbacks are passing the full constraint request data
>     in order for the callees to have access to it. The current use is for the
>     platform low-level code to access the target device of the constraint
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
> 1. write Documentation for the new PM QoS class, once the code is agreed on
> 2. submit patches for the OMAP low level code to control the power domains
>    states from the device constraints, using a global notification callback
> 
>    
> Based on the master branch of the linux-omap git tree (3.1.0-rc1). Compile
> tested using OMAP and x86 generic defconfigs.
> 
> Tested on OMAP3 Beagleboard (ES2.x).
> Need testing on platforms other than OMAP, because of the impact on the
> device insertion/removal in device_pm_add/remove

OK

If that were my code, I'd probably change a couple of things more, but
it looks good enough to me to take as is.  I'm going to push this patchset
for 3.2.

Thanks a lot for your hard work on it,
Rafael
