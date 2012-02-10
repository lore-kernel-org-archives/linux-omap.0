From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 20:06:00 +0000
Message-ID: <20120210200600.GA13587@n2100.arm.linux.org.uk>
References: <20120208231551.GA9009@kroah.com> <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com> <20120209004731.GA11343@kroah.com> <4F3374F0.3080002@bitmer.com> <20120209133739.GB2590@sirena.org.uk> <20120209183624.GJ1426@atomide.com> <CANOLnOPucEMxYa2=fy=Vm_NSHWthnNAq0hJK5u37VZdcwwozFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47402 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760056Ab2BJUGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 15:06:41 -0500
Content-Disposition: inline
In-Reply-To: <CANOLnOPucEMxYa2=fy=Vm_NSHWthnNAq0hJK5u37VZdcwwozFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Fri, Feb 10, 2012 at 01:53:12PM +0200, Grazvydas Ignotas wrote:
> On Thu, Feb 9, 2012 at 8:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Please everybody using omaps with mainline give a test for the
> > merge of the various fixes planned. I've done a branch with
> > v3.3-rc3 + Russell's fixes + Paul's serial port fixes + fixes
> > that I've queued up.
> 
> Seems to be good on pandora with omap2plus_defconfig, only one section mismatch:
> 
> WARNING: vmlinux.o(.text+0x22b64): Section mismatch in reference from
> the function omap4_hotplug_cpu() to the function
> .cpuinit.text:omap_secondary_startup()
> The function omap4_hotplug_cpu() references the function __cpuinit
> omap_secondary_startup().
> This is often because omap4_hotplug_cpu lacks a __cpuinit annotation
> or the annotation of omap_secondary_startup is wrong.

That's expected at the moment, and is something that shouldn't be solved
by changing omap_secondary_startup().

However, omap4_hotplug_cpu() and platform_cpu_die() are both things which
run when the CPU is being unplugged, so they should logically be __cpuexit.
However, we would end up with __cpuexit code referencing __cpuinit code,
which will also emit a warning.

So, just like Versatile Express et.al. we persist with the section mismatch
warning being emitted for these platforms, because the reference there is
entirely valid for this code.

Unfortunately, there's no way to place omap4_hotplug_cpu() into the
__cpuexit section and mark it as validly referencing __cpuinit code.
(iow, __ref doesn't work for that.)
