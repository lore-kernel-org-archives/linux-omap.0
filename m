From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Tue, 2 Aug 2011 22:19:59 +0200
Message-ID: <201108022220.00019.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <201107022310.50175.rjw@sisk.pl> <87bow7ln4c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42391 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754944Ab1HBUSx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 16:18:53 -0400
In-Reply-To: <87bow7ln4c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: jean.pihet@newoldbits.com, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

On Tuesday, August 02, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Hi,
> >
> > On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
> >> From: Jean Pihet <j-pihet@ti.com>
> >> 
> >> - add a new PM QoS class PM_QOS_DEV_WAKEUP_LATENCY for device wake-up
> >> constraints. Due to the per-device nature of the new class the constraints
> >> list is stored inside the device dev_pm_info struct instead of the internal
> >> per-class constraints lists.
> >
> > I think PM_QOS_DEV_LATENCY might be a better name.
> >
> >> The new class is only available from kernel drivers and so is not exported
> >> to user space.
> >
> > It should be available to user space, however, because in many cases drivers
> > simply have no idea what values to use (after all, the use decides if he
> > wants to trade worse video playback quality for better battery life, for
> > example).
> >
> 
> FWIW, I think it's wrong to expose the raw per-device constraints
> directly to userspace.
> 
> I think it's the responsibility of the subsystems (video, audio, input,
> etc.) to expose QoS knobs to userspace as they see fit and now allow
> userspace to tinker directly with QoS constraints.

This assumes that those "subsystems" or rather "frameworks" (a bus type or
a device class is a subsystem in the terminology used throughout the PM
documentation) will (a) know about PM QoS and (b) will care to handle it.
Both (a) and (b) seem to be unrealistic IMHO.

We already export wakeup and runtime PM knobs per device via sysfs and
I'm not so sure why PM QoS is different in that respect.

Thanks,
Rafael
