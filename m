From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
Date: Mon, 13 Feb 2012 13:17:05 -0500
Message-ID: <20120213181704.GE40045@h115-84.vpn.ti.com>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
 <20120213165209.GA31482@n2100.arm.linux.org.uk>
 <20120213165617.GE3494@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120213165617.GE3494@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 13, 2012 at 08:56:18AM -0800, Mark Brown wrote:
> On Mon, Feb 13, 2012 at 04:52:09PM +0000, Russell King - ARM Linux wrote:
> 
> > I think OMAP (or even the reg-fixed-voltage folk) needs to create an enum
> > similar to what I did for 8250 to control the allocation of platform
> > device IDs for this, otherwise we're going to keep on running over this
> > problem.
> 
> > Added Mark for his comment.
> 
> Hrm, seems slightly icky but the enum will work if we can decide how to
> add elements to the enum since it'll be easy to bloat a lot it if it's
> central.  It's tempting to suggest just using a random number to assign
> the IDs randomly rather than have a central registry but obviously
> there's no guarantees there.

Another option might be to provide a generic platform device helper
that instantiates a per-named-platform-device id list that simply
provides the next available id sequentially as requests for platform
device registration arrive.

arch init:

platform_create_id_list_create("reg-fixed-voltage"); 

platform init:

/* I = 0..N, .id filled in by _autoid() registration */
static struct platform_device my_fixed_regulatorN = {
	.name		= "reg-fixed-voltage",
	.dev = ...
}

platform_device_register_autoid(&my_fixed_regulator0); 
platform_device_register_autoid(&my_fixed_regulator1); 
platform_device_register_autoid(&my_fixed_regulator2); 
...
platform_device_register_autoid(&my_fixed_regulatorN); 

Something like this might be able to solve this once for the platform
device users don't need a fixed enum id. It would require changes to
platform_device_register() to update the list as static assignment
of ids occurs so those will not be used by the _autoid() method.

-Matt
