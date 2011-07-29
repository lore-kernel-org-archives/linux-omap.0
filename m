From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/PATCH v3 00/13] PM QoS: add a per-device latency constraints class
Date: Fri, 29 Jul 2011 23:25:20 +0200
Message-ID: <201107292325.20637.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34806 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab1G2VYA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 17:24:00 -0400
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch set is in an RFC state, for review and comments.
> 
> High level implementation:
> 
> 1. Add a new PM QoS class for device wake-up constraints (PM_QOS_DEV_LATENCY).
> . Define a pm_qos_constraints struct for the storage of the constraints list
> and associated values (target_value, default_value, type ...).
> . Update the pm_qos_object struct with the information related to a PM QoS
> class: ptr to constraints list, notifer ptr, name ...
> . Each PM QoS class statically declare objects for pm_qos_object and
> pm_qos_constraints. The only exception is the devices constraints, cf. below.
> . The device constraints class is statically declaring a pm_qos_object. The
> pm_qos_constraints are per-device and so are embedded into the device struct.
> 
> The new class is available from kernel drivers and shall be made available
> to user space through a per-device sysfs entry. User space API to come as a 
> subsequent patch.
> 
> 2. Added a notification of device insertion/removal from the device PM framework
> to PM QoS.
> This allows to init/de-init the per-device constraints list upon device insertion
> and removal.
> RFC state for comments and review, lightly tested
> 
> 3. Make the pm_qos_add_request API more generic by using a
> struct pm_qos_parameters parameter. This allows easy extension in the future.
> 
> 4. Upon a change of the aggregated constraint value in the PM_QOS_DEV_LATENCY class
> a notification chain mechanism is used to take action on the system.
> This is the proposed way to have PM QoS and the platform dependant code to
> interact with each other, cf. 5 below.
> The notification mechanism now passes the constraint request struct ptr in
> order for the notifier callback to have access to the full set of constraint
> data, e.g. the struct device ptr.
> 
> 5. cpuidle interaction with the OMAP3 cpuidle handler
> Since cpuidle is a CPU centric framework it decides the MPU next power state
> based on the MPU exit_latency and target_residency figures.
>     
> The rest of the power domains get their next power state programmed from
> the PM_QOS_DEV_LATENCY class of the PM QoS framework, via the device
> wake-up latency constraints callback to the OMAP_PM_CONSTRAINTS framework.
> 
> Note: the exit_latency and target_residency figures of the MPU include the MPU
> itself and the peripherals needed for the MPU to execute instructions (e.g.
> main memory, caches, IRQ controller, MMU etc).
> Some of those peripherals can belong to other power domains than the MPU
> subsystem and so the corresponding latencies must be included in those figures.
> 
> 6. Update the pm_qos_add_request callers to the generic API
> 
> 7. Misc fixes to improve code readability:
> . rename of the PM QoS implementation file from pm_qos_params.[ch] to pm_qos.[ch]
> . rename of fields names (request, list, constraints, class),
> . simplification of the in-kernel PM QoS API implementation. The main logic part
> is now implemented in the update_target function.
> 
> Questions:
> 1. per-device user-space API: since sysfs does not provide open/close
> callbacks it is not possible to support multiple and simultaneous users of
> the per-device sysfs entry. A user-space constraints aggregation application is
> needed in case of multiple constraints for a device. Is this the way to go?

I'd say so.

Thanks,
Rafael
