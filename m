From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Mon, 18 May 2009 19:59:34 +0100
Message-ID: <20090518185934.GL7042@n2100.arm.linux.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com> <4A03F8DD.4070307@windriver.com> <87hbzv8rua.fsf@litku.valot.fi> <20090516081904.GB15328@n2100.arm.linux.org.uk> <87ljoube3z.fsf@litku.valot.fi> <20090518160957.GD7042@n2100.arm.linux.org.uk> <87zlda72r0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54504 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZERTAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 15:00:19 -0400
Content-Disposition: inline
In-Reply-To: <87zlda72r0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Kalle Valo <kalle.valo@iki.fi>, "stanley.miao" <stanley.miao@windriver.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, jon-hunter@ti.com

On Mon, May 18, 2009 at 10:13:55AM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Mon, May 18, 2009 at 06:54:56PM +0300, Kalle Valo wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> 
> >> > On Fri, May 08, 2009 at 07:47:09PM +0300, Kalle Valo wrote:
> >> >> "stanley.miao" <stanley.miao@windriver.com> writes:
> >> >> 
> >> >> >> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
> >> >> >> reported earlier. Switching to 2008q3 works.
> >> >> >
> >> >> > Yeah, Now the kernel booted. it's compiler's problem.
> >> >> 
> >> >> I was bitten by the same problem few weeks ago. Any chance of getting a
> >> >> warning/error if using 2007q3 compiler until the problem is fixed?
> >> >
> >> > Is there any way of detecting the 2007q3 compiler?
> >> >
> >> > With normal GCC versions, you can use __GNUC__, __GNUC_MINOR__ and
> >> > __GNUC_PATCHLEVEL__ to identify the three digit version number.
> >> 
> >> I don't know, most probably not. But Jon Hunter investigated the issue
> >> and he found the issue was related to CONFIG_ARCH_WANT_FRAME_POINTERS:
> >> 
> >> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12403.html
> >> 
> >> So maybe we can fix or workaround this.
> >
> > Why does this change anything?  FRAME_POINTERS seems to be enabled
> > anyway (and should be given the Kconfig setup we have.)
> 
> See the 'depends on' line in lib/Kconfig.debug.  The result is that
> without the patch from Jon, even if you have CONFIG_FRAME_POINTERS=y
> in your .config, it gets dropped if the arch doesn't set
> CONFIG_ARCH_WANT_FRAME_POINTERS.

Well, two things.

1. We don't want to force frame pointers on if unwinding support is enabled.

2. The lib/Kconfig.debug entry is overridden by ARM's own version in
   arch/arm/Kconfig.debug.  I've added samr into the discussion since
   he created this.

arch/arm/Kconfig.debug:

# RMK wants arm kernels compiled with frame pointers or stack unwinding.
# If you know what you are doing and are willing to live without stack
# traces, you can get a slightly smaller kernel by setting this option to
# n, but then RMK will have to kill you ;).
config FRAME_POINTER
        bool
        default y if !ARM_UNWIND
        help
          If you say N here, the resulting kernel will be slightly smaller and
          faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
          when a problem occurs with the kernel, the information that is
          reported is severely limited.

And lib/Kconfig.debug:

config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
        depends on DEBUG_KERNEL && \
                (CRIS || M68K || M68KNOMMU || FRV || UML || \
                 AVR32 || SUPERH || BLACKFIN || MN10300) || \
                ARCH_WANT_FRAME_POINTERS
        default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
        help
          If you say Y here the resulting kernel image will be slightly
          larger and slower, but it gives very useful debugging information
          in case of kernel bugs. (precise oopses/stacktraces/warnings)

this still results in frame pointers being enabled.  This is because the
ARM version follows the one in lib/, it overrides it rather than
supplementing the generic version.  I've just checked that by adding
'n &&' to that depends on line in lib/Kconfig.debug, and making oldconfig.
I still end up with FRAME_POINTER=y in my configs.  However, if I stub out
the 'default y' line in arch/arm/Kconfig.debug, it goes away.

So I think setting ARCH_WANT_FRAME_POINTERS will be ineffectual.

Moreover, I don't think forcing frame pointers to be enabled even with
unwinding support is the right solution - if we have frame pointers
there's no need for unwind support (so maybe the right answer is to
force unwind support off for the time being?)
