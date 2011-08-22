From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v6 0/7] PM QoS: add a per-device latency constraints framework
Date: Mon, 22 Aug 2011 20:53:01 +0200
Message-ID: <201108222053.01639.rjw@sisk.pl>
References: <1313609965-6568-1-git-send-email-j-pihet@ti.com> <87mxf1wcrz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57871 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab1HVSvP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 14:51:15 -0400
In-Reply-To: <87mxf1wcrz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: jean.pihet@newoldbits.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Monday, August 22, 2011, Kevin Hilman wrote:
> jean.pihet@newoldbits.com writes:
> 
> > From: Jean Pihet <j-pihet@ti.com>
> >
> > High level implementation:
> >
> > 1. Preparation of the PM QoS for the addition of a device PM QoS constraints
> >    framework:
> >   . rename and move of the PM QoS implementation files to kernel/power/qos.c
> >     and include/linux/pm_qos.h
> >   . rename of API parameters and internal fields names
> >   . Move around the PM QoS misc devices management code for better readability
> >   . re-organize the internal data structs
> >   . generalize and export the constraints management core code
> >
> > 2. Implementation of the per-device PM QoS constraints:
> >   . create drivers/base/power/qos.c for the implementation
> >   . create a device PM QoS API, which calls the PM QoS constraints management
> >     core code
> >   . the per-device latency constraints data strctures are stored in the device
> >     dev_pm_info struct
> >   . the device PM code calls the init and destroy of the per-device constraints
> >     data struct in order to support the dynamic insertion and removal of the
> >     devices in the system.
> >   . to minimize the data usage by the per-device constraints, the data struct
> >     is only allocated at the first call to dev_pm_qos_add_request. The data
> >     is later free'd when the device is removed from the system
> >   . per-device notification callbacks can be registered and called upon a
> >     change to the aggregated constraint value
> >   . a global mutex protects the constraints users from the data being
> >     allocated and free'd.
> >
> > 3. add a global notification mechanism for the device constraints
> >   . add a global notification chain that gets called upon changes to the
> >     aggregated constraint value for any device.
> >   . the notification callbacks are passing the full constraint request data
> >     in order for the callees to have access to it. The current use is for the
> >     platform low-level code to access the target device of the constraint
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>

I guess that applies to the entire patchset?

Rafael
