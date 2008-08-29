From: David Brownell <david-b@pacbell.net>
Subject: Re: Pin mux utility?
Date: Fri, 29 Aug 2008 11:12:28 -0700
Message-ID: <200808291112.28663.david-b@pacbell.net>
References: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com> <200808291017.40151.david-b@pacbell.net> <1220030469.19671.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:36567 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751469AbYH2SMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 14:12:30 -0400
In-Reply-To: <1220030469.19671.7.camel@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 29 August 2008, Igor Stoppa wrote:
> > > I'd like to verify that u-boot is setting things up properly.
> > 
> > CONFIG_OMAP_MUX_WARNINGS helps for some definitions of "properly":
> > when Linux needs one setting, but the boot loader leaves a different
> > one, you get a warning.  That's usually interpreted as u-boot doing
> > it wrong, except on devboards where the boot loader can't actually
> > know about all external hardware that might be hooked up (and how)
> 
> I'm probably a bit off topic, but since Tony started promoting the
> concept of multi-arch binary, well, i see it as a huge limitation the
> fact that the bootloader is expected to the right thing.

The boot loader knows exactly what it's dealing with.  And by the
time it get past very early boot, so does Linux ...


> In the multi arch case (but even single-arch, if we would like to
> support multiple boards with one single kernel binary) i see as a much
> more reasonable solution the case where the bootloader passes the board
> id to the kernel and the kernel loads the board-specific configuration
> in the form of a module.

How the kernel gets that config data doesn't matter.  The current
solution is that all supported boards have setup code (board-XYZ.c
object code) statically linked.  Most of the board init code runs
at arch_initcall() time ... and it's keyed using the board ID.  CPU
setup code runs a bit earlier.


> DVFS for example defeats the idea that the bootloader would be enough to
> setup properly the clock tree (of course it will do it, but only for 1
> OP and the setting can get lost the first time another OP is selected).

I've not looked at recent clock tree issues.  $SUBJECT is about
pinmux, not clock tree.  I have no problems with the notion that
Linux not rely on the boot loader to set up esoteric stuff.


> Imho the bootloader should just do what the name suggests: load the
> kernel and boot it. In as minimal configuration as possible.

There's a lot to be said for not relying on boot loaders to do much
more than loading and starting a kernel.  Kernel requirements have a
tendancy to evolve over time, while boot loaders tend to never get
upgraded ... so kernels tend to set things up, regardless.

The whole "rely on boot loader to do ABC" bit can only make sense
in special contexts ... like a Nokia product team which has the
processes in place to clearly define "ABC" and test it.  For many
development boards that's often not practical.  And of course, the
logical extension of relying on bootloaders is what you see in PCs
with BIOS and ACPI; yeech!

- Dave
