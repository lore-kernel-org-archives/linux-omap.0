From: "Girish S G" <girishsg@ti.com>
Subject: RE: [RFC][Patch] OMAP3 PM: sysfs vdd_opp change  to use ConstraintFramework
Date: Tue, 20 Oct 2009 12:54:21 -0500
Message-ID: <020701ca51ae$5aad0bd0$841018ac@am.dhcp.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA174C98@dbde02.ent.ti.com> <87vdianjww.fsf@deeprootsystems.com> <20091020170219.GE12576@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41235 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbZJTRyV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:54:21 -0400
In-Reply-To: <20091020170219.GE12576@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>, 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: "'Sripathy, Vishwanath'" <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Tuesday, October 20, 2009 12:02 PM
> To: Kevin Hilman
> Cc: Sripathy, Vishwanath; linux-omap@vger.kernel.org
> Subject: Re: [RFC][Patch] OMAP3 PM: sysfs vdd_opp change to use ConstraintFramework
> 
> * Kevin Hilman <khilman@deeprootsystems.com> [091020 08:51]:
> > "Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:
> >
> > > Sysfs entry vdd_opp currently does not use constraint framework.
> > > Because of this, even if you set the opp via this entry, it has no effect
> > > since it can be overridden by on demand governor any time.
> > > This patch has changes to make vdd_opp to use constraint framework.
> > > vdd_lock variable has to be used when application wants to disable DVFS
> > > altogether. This will override any other constraints and will lock the
> > > OPP to given value.
> > Since we can do the equivalent with CPUFreq using the userspace
> > governor, I don't see the point of having an additional interface.
> >
> > Comments?
> 
> Total ack from me!

Only thing what I think of is, L3 rate.

-Girish


