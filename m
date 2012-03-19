From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 12:59:37 +0000
Message-ID: <20120319125937.GD16389@n2100.arm.linux.org.uk>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk> <20120317004706.GF7276@atomide.com> <20120317211505.GA4720@n2100.arm.linux.org.uk> <1332149601.2144.15.camel@deskari> <20120319123006.GC16389@n2100.arm.linux.org.uk> <1332160864.2144.66.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37304 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758881Ab2CSM7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 08:59:49 -0400
Content-Disposition: inline
In-Reply-To: <1332160864.2144.66.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Mar 19, 2012 at 02:41:04PM +0200, Tomi Valkeinen wrote:
> On Mon, 2012-03-19 at 12:30 +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 19, 2012 at 11:33:21AM +0200, Tomi Valkeinen wrote:
> > > But that's a bigger work item, so what I did in the series above is that
> > > I changed platform_driver_register()s to platform_driver_probe()s. All
> > > the DSS subdevices are present at boot time and are non-hotpluggable, so
> > > I think that should work fine.
> > 
> > platform_driver_probe() is just a wrapper around platform_driver_register() -
> > the difference between the two is that _probe() will temporarily set the
> > probe method in the passed driver structure, call platform_driver_register(),
> > and then NULL the probe method out.
> 
> I meant that platform_driver_probe() solves the issue with the
> initialization order of the dss subdrivers.
> 
> The deadlock is solved in the series by moving the driver registration
> to module_init.
> 
> > So, merely changing platform_driver_register() for platform_driver_probe()
> > won't solve the deadlock.
> > 
> > I'm not sure what's caused this regression, as I can't see any DSS changes,
> > nor core driver model changes which would account for this.  Has something
> > changed in hwmod to cause this?
> > 
> > It is _very_ important that we discover what has caused this regression
> > and prevent it going upstream until the problem is resolved.  Until we
> > know that, I suggest that _no_ OMAP changes go upstream during this
> > merge window until we understand what's caused this.
> 
> I didn't try yet, but it could be this:
> 
> commit 3ec2decbb6dfcdbbb6e6a8ddf5adc7edbc429ed7
> Author: Kevin Hilman <khilman@ti.com>
> Date:   Wed Feb 15 11:47:45 2012 -0800
> 
>     ARM: OMAP: omap_device: remove omap_device_parent
>     
>     Currently all omap_devices are forced to have the dummy device
>     'omap_device_parent' as a parent.  This was used to distinguish
>     omap_devices from "normal" platform_devices in the OMAP PM core code.
>     
>     Now that we implement the PM core using PM domains, this is no longer
>     needed, and is removed.
>     
>     This also frees up omap_devices to have a more complex parent/child
>     relationships that model actual device relationships.
>     
>     The only in-tree user of omap_device_parent was the OMAP PM layer to
>     handle lost-context count for omap_devices.  That is now converted to
>     use the presence of the omap_device_pm_domain instead.
>     
>     Signed-off-by: Kevin Hilman <khilman@ti.com>

Yes, it could well be caused by this.  What would've happened before is
that the omapdss device would have been parented to the 'platform' device,
while the hwmod-built devices would've been parented to omap_device_parent.

With the above commit, both devices would be parented to the 'platform'
device, which would cause lock contention.

I've just built with this reverted (which was a relatively clean revert) -
and doing so appears to allow the kernel to boot again.
