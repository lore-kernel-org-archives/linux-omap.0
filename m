From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 00/15] PM QoS: add a per-device latency constraints class
Date: Sun, 14 Aug 2011 15:53:52 +0200
Message-ID: <201108141553.52720.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <201108122356.02983.rjw@sisk.pl> <CAORVsuU2sph=oKDk1btSmEY=tKPUucXuQdapru=Z6EXvuPqARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40073 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab1HNNwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Aug 2011 09:52:12 -0400
In-Reply-To: <CAORVsuU2sph=oKDk1btSmEY=tKPUucXuQdapru=Z6EXvuPqARA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Sunday, August 14, 2011, Jean Pihet wrote:
> Rafael,
> 
> On Fri, Aug 12, 2011 at 11:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > On Friday, August 12, 2011, Jean Pihet wrote:
> >> Hi Rafael,
> >>
> >> 2011/8/12 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
> >> >> From: Jean Pihet <j-pihet@ti.com>
> >> >>
> >> >> This patch set is in an RFC state, for review and comments.
> >> >>
> >> ...
> >> >>
> >> >>
> >> >> Questions:
> >> >> 1. the user space API is still under discussions on linux-omap and linux-pm MLs,
> >> >>    cf. [1]. The idea is to add a user-space API for the devices constratins
> >> >>    PM QoS, using a sysfs entry per device
> >> >>
> >> >> [1] http://marc.info/?l=linux-omap&m=131232344503327&w=2
> >> >>
> >> >> ToDo:
> >> >> 1. write Documentation for the new PM QoS class, once the RFC is agreed on
> >> >> 2. validate the constraints framework on OMAP4 HW (done on OMAP3)
> >> >> 3. Need testing on platforms other than OMAP
> >> >> 4. refine the power domains wake-up latency and the cpuidle figures
> >> >> 5. re-visit the OMAP power domains states initialization procedure. Currently
> >> >>    the power states that have been changed from the constraints API which were
> >> >>    applied before the initialization of the power domains are lost
> >> >>
> >> >>
> >> >> Based on the master branch of the linux-omap git tree (3.0.0-rc7). Compile
> >> >> tested using OMAP and x86 generic defconfigs.
> >> >>
> >> >> Lightly tested on OMAP3 Beagleboard (ES2.x).
> >> >> Need testing on platforms other than OMAP, because of the impact on the
> >> >> device insertion/removal in device_pm_add/remove
> >> >
> >> > The patchset looks really good to me, I don't think I have any major
> >> > complaints about this version.
> >> Ok good to hear it! I tried to address all comments and concerns in
> >> this release.
> >>
> >> >
> >> > The only thing I'd like to ask at the moment is whether or not the
> >> > compilation of drivers/base/power/qos.c should depend on
> >> > CONFIG_PM_RUNTIME.  Do you think it will be used by system suspend code on any
> >> > platforms?
> >> I would say it should only depend on CONFIG_PM because the dev PM QoS
> >> API can be used from any kernel code, being runtime PM code or not.
> >> I leave the decision to the PM framework experts.
> >>
> >> >
> >> > Also, I'd like to take the final patchset for 3.2,
> >> Ok good!
> >>
> >> > but I don't feel
> >> > confident enough about the OMAP patches.
> >> The OMAP patches have been reviewed a few times already and the
> >> comments have been taken into account. Also i has been tested
> >> correctly on OMAP3.
> >>
> >> > If you want me to take them too,
> >> > please make sure they are ACKed by the OMAP maintainers.
> >> For sure I need the Acks. I guess I now need to annoy OMAP folks about it ;p
> >> In the case the Acks are not gathered on time the generic patches
> >> could be merged in, then the OMAP generic code. Do you think it is a
> >> viable option?
> >
> > Yes, it is.  I can take patches [1-7/15] alone.
> >
> >> The only concern I have is about the on-going OMAP PM initialization
> >> clean-up task, cf. ToDo list:
> >>   >> 5. re-visit the OMAP power domains states initialization
> >> procedure. Currently
> >>   >>    the power states that have been changed from the constraints
> >> API which were
> >>   >>    applied before the initialization of the power domains are lost
> >>
> >> On the other hand some testing is needed on platforms other than OMAP,
> >> because of the impact on the device insertion/removal in
> >> device_pm_add/remove functions. I tested the SD card insertion/removal
> >> on OMAP3.
> >
> > OK, so are you going to make any more changes to patches [1-7/15]?
> I am now reworking [06/15] after your comments.
> Is that OK timewise?

It should be fine.  I still need to have a closer look at [7/15] later today,
I'll let you know if there's anything I'd like to change in there.

Thanks,
Rafael


