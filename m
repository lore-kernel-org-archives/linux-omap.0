From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 26 Feb 2014 13:28:56 +0000
Message-ID: <20140226132856.GB27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <20140225123921.GY27282@n2100.arm.linux.org.uk> <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon> <20140225205634.GZ27282@n2100.arm.linux.org.uk> <530DCC8A.6060708@ti.com> <20140226120359.GA27282@n2100.arm.linux.org.uk> <530DE192.9030506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:51506 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751850AbaBZN3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 08:29:09 -0500
Content-Disposition: inline
In-Reply-To: <530DE192.9030506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Wed, Feb 26, 2014 at 02:44:02PM +0200, Tomi Valkeinen wrote:
> > Also - DRM is not going to ever support hotplugging components - this
> > was discussed at kernel summit last year and David Airlie was quite
> 
> Ok. Very odd stance. Maybe there's a reason for it that I just don't see.

DRM is like ALSA - it's a card level subsystem.  All components have
to be present before the card level is brought up for the subsystem to
function correctly.

> > adamant about that.  So, any "framework" which forces hotplugging of
> > components on subsystems isn't going to fly.
> 
> CDF doesn't force hotplugging.
> 
> Although without hotplugging (hot-unplug not needed), or at least some
> minimal form of it, the system is a bit crippled. Leave one kernel
> module out, or have one driver probe fail, the whole display subsystem
> fails, even if some display pipelines would work fine.

That is, unfortunately, one of the side effects of the policy - but that's
not a policy that's going to change any time soon.  As I said, that was
made very clear at the last kernel summit - we had a /specific/ session
on the issues around multi-device DRM chaired by David.

There are some DRM drivers which have tried to do this, but they're all
buggy in some regard, whether that be to the point of oopsing the kernel
if things don't quite go to plan, or whether it's races between different
parts.

> > This is why we now have the component helpers in the driver model -
> > to allow devices to be collected together into one logical subsystem
> > group, and bound/unbound as a group.
> 
> Yep, it's a good start. The component helpers could well be used with CDF.
> 
> But if I'm not mistaken, it suffers from the problems above, when there
> are multiple independent pipelines (simultaneous or non-simultaneous)
> handled by the same IPs.

It may "suffer from the problems above" that you've raised, but that's
by explicit design of it - because that's what subsystems like DRM and
ALSA require, and this is _precisely_ the problem it's solving.

It's solving the "subsystem requires a stable view of hardware components,
but we have multiple devices and drivers which need probing" problem.

> And, while I may be mistaken, it sounds that the component helpers leave
> mostly everything up to the display drivers. Everyone devising their own
> way to describe the hardware in DT, and the connections between the
> components. Of course, the core component system shouldn't define
> anything DT related, as it doesn't. But that part is still needed, which
> is where CDF comes in.

Sigh.  It's very easy for people to get the wrong end of the stick.

What the component helpers do is provide a _subsystem_ _independent_
method of collecting a set of devices together and binding them to the
drivers at an appropriate time, in a way that is _completely_ independent
of whether you're using platform data, DT, ACPI, or whatever other
hardware description language comes along.

It's up to the users of this to define how components are grouped
together, whether that be at the subsystem level or at the driver
level - whatever is appropriate.

If a subsystem (eg, a display subsystem) wants to define "this is how
you define in DT the bindings between all components" and provide its
own hook for the "add_components" callback which does this, then it's
at liberty to do that.

If we can come up with a generic way to describe how all the components
in a display subsystem should be connected together, then great - but
that needs to happen very quickly.  Philipp Zabel is working on replacing
the imx-drm binding method right now for 3.15, and is probably completely
unaware of anything that's been talked about here.  I need to sort out
Armada DRM at some point to use the component stuff, which includes
sorting out TDA998x for DT - which again needs to be done in such a way
that it follows a common theme.

> I need to ask Dave why he is so strongly opposed to hotplugging components.

I suspect one reason for it is because it means rewriting the XF86
backend to Xorg to cope with it...

> > Remember that "hotplugging" in this context does not mean that the
> > user can physically do something with the hardware.  It means that
> > they're separate devices which can be probed/removed at will.  Every
> > device in Linux can be bound and unbound from its driver at any time
> > by userspace, and that is something which is expected to be handled
> > gracefully.
> 
> Hmm, sorry, can you rephrase?

I'll do better than that.  Try running this script with the
/sys/bus/.../drivers/whatever for the drivers you wish to test:

#!/bin/sh
for driver in "$@"; do
   if [ -f "${driver}/unbind" ]; then
      for device in "${driver}"/*; do
         if [ -d "${device}" ]; then
            devname="$(basename "${device}")"
            echo "$devname" > "${driver}/unbind"
            echo "$devname" > "${driver}/bind"
         fi
      done
   fi
done

The system should survive that.

> So with hotplug, a new fbdev or a combination of drm crtcs, encoders,
> etc, could appear even after the initial probe of the display controller.

This is the exact situation that David is opposed to.  DRM, like ALSA,
whats to have a stable view of hardware - once the drm_device has been
created and probed, no further changes to it are allowed.

Certainly no changes to the CRTCs will _ever_ be permitted, because it
completely destroys the user API for referecing which encoders can be
associated with which CRTCs - not only at the kernel level, but also the
Xorg and Xrandr level too.  That's done via a bitmask of allowable CRTCs,
where bit 0 refers to the first CRTC, bit 1 to the second and so on.
That's propagated all the way through to userspace, right through the Xorg
interfaces to applications.

Connectors and encoders are fixed at the moment after initial probe time
in DRM due to the way the fbdev emulation layer works.  There's also issues
there concerning bitmasks for which connectors can be cloned onto other
connectors which follows the same pattern as above - and again, that
propagates all the way through userspace.

So, if this is going to get fixed, there has to be a desire to break
userspace quite badly, and there is no such desire to do that.

For instance, let's say that Xorg is up and running, and you have the
gnome applet for configuring your display open, and you have two CRTCs.
Then the first CRTC is removed from the system, resulting in CRTC 1
becoming CRTC 0 in the kernel.  What happens...

Think the same thing through for a system with three connectors, A, B, C
numbered 0, 1, and 2 respectively.  A and be cloned onto B.  Now connector
A is removed, meaning B and C appear to become numbers 0 and 1 in the
kernel...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
