From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Thu, 6 Apr 2017 20:00:09 +0100
Message-ID: <20170406190008.GO23750@n2100.armlinux.org.uk>
References: <20170328205511.21166-1-d-gerlach@ti.com>
 <20170328205511.21166-3-d-gerlach@ti.com>
 <20170404161151.GS10760@atomide.com>
 <20170405135933.GN23750@n2100.armlinux.org.uk>
 <20170405143318.GE13234@atomide.com>
 <5cd63e14-52df-6010-4193-c926cdd76839@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5cd63e14-52df-6010-4193-c926cdd76839-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 05, 2017 at 09:48:26AM -0500, Dave Gerlach wrote:
> Russell,
> On 04/05/2017 09:33 AM, Tony Lindgren wrote:
> >* Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> [170405 07:02]:
> >>I'm not going to comment on this yet, but I'll instead comment on the
> >>newly appeared sram_exec_copy() stuff.
> >>
> >>So, a few years ago, we went to significant effort in ARM land to come
> >>up with a way to _safely_ copy assembler from the kernel into SRAM,
> >>because copying code to SRAM that is compiled in thumb mode and then
> >>executing it is _not_ as simple as memcpy(), cast the pointer to a
> >>function pointer, and then call the function pointer.
> >>
> >>The SRAM stuff throws all that out, instead preferring the dumb memcpy()
> >>approach.
> >>
> >>This needs resolving, and I'd like to see it resolved to the satisfaction
> >>of architecture maintainers before we progress any further down this
> >>route.
> 
> I'm sure you are referring to fncpy, correct? This is what we used before
> with ARM specific code to do the copy, but we've moved into drivers now.

Right, and as I explained above, fncpy() exists with very good reason.
The following does not work on ARM:

	sram = alloc(function_size);

	memcpy(sram, function, function_size);

	sram_ptr = (function_cast_t)sram;

	sram_ptr(args);

when the function is Thumb.  There are two problems with the above code
that fncpy() solves, both stemming from the same root cause:

1. The address of "function" will be offset by one byte, so the memcpy()
   will miss copying the first byte of the function.

2. sram_ptr will not be offset by one byte.

This is because, with Thumb functions, the "address" of the function is
offset by one byte - by the architecture requirements - to indicate that
it is to be called in Thumb mode.

> What are your thoughts on exposing fncpy outside of arch/arm?

You may use it by including asm/fncpy.h, but you may not move it out of
that file.  fncpy() is there exactly because it's _architecture_ specific.

If you're looking to make this generic, then we need cross-arch agreement
on how we can copy functions, and I'd recommend that fncpy() becomes that
generic copy function.  fncpy() has advantages over memcpy() besides
encoding the architecture specific knowledge - the biggest one is that
it guarantees type safety as well.  It ensures that the function pointer
that it's returning conforms with the function it's being asked to copy.

It strikes me, looking at the SRAM stuff, that the baby has been
completely thrown out with the bath water...

And really, this SRAM stuff _should_ have been through architecture
maintainer review before being merged into mainline so that these issues
could have been highlighted before hand.

This looks to me like yet another huge big review failure in kernel land,
because people are insistant on continually dividing stuff up by
sub-directory.  This has got to stop.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
