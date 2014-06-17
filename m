From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org
	boards
Date: Tue, 17 Jun 2014 13:56:40 +0100
Message-ID: <20140617125640.GC3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk> <53A03675.1000908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60941 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932196AbaFQM4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 08:56:50 -0400
Content-Disposition: inline
In-Reply-To: <53A03675.1000908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Jason Kridner <jkridner@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, OMAP List <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 17, 2014 at 08:37:09AM -0400, Tom Rini wrote:
> On 06/17/2014 05:09 AM, Russell King - ARM Linux wrote:
> > A good way that this could have been done is to put an I2C EEPROM on
> > each cape, and have that store the DT fragment.  The boot loader could
> > have then read that from each cape, and used that information to build
> > up the final DT.  Why this hasn't been thought of, considering that the
> > kernel has been moving towards DT for years, is quite unbelievable.
> 
> I had actually talked about this a long while back (face to face) with
> people, but the problem was (and still kind of is) the bindings
> changing, etc.

And that's a strong argument for having stable bindings - or at the
very least, ensuring that new bindings which are compatible with older
versions.

We all know how to deal with this, we've had these discussions frequently
with the same outcomes.  It's really not something that needs discussing
yet again, just to reach the same conclusions.

Look, go back to the x86 model.  Why does the kernel run on virtually
any x86 computer there (firmware bugs not withstanding)?  It's not only
because the platform is mostly standardised, but also because it's
standardised at the firmware (BIOS) level as well.  So there's standard
ways to find out what hardware is fitted, standard ways to find out how
it's wired up (eg, which interrupts) and such like.

Like it or not, with ARM64 moving into the server space, and (I believe)
we're saying that we want FDT inside ACPI - well, as soon as you go down
that path on servers, FDT _has_ to be standardised and stable.  Server
space will /not/ stand having to update the FDT in firmware for each
incremental kernel version change, just because we've decided to change
the bindings.

Exactly the same should start applying here.  Yes, we may not want bindings
to be entirely frozen, but when we /do/ change them, we must change them
in a way that is compatible with the old bindings.

Like, for instance, the iMX AHCI driver that I've had for the last five
months patches to fix the incomplete DT bindings for: we have platforms
using it which have hard-coded non-hardware default parameters into the
driver.  I need different hardware parameters for it to come close to
working on my hardware, so when introducing new properties for these, I
_must_ ensure that when these properties are not specified (as they aren't
for the existing platforms using the driver) that their non-hardware
default values are used.  This even means providing negative options to
_disable_ features on the interface, because providing positive "enable
this feature" options would mean that their bindings break.

This is not rocket science.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
