From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 12:25:21 -0500 (EST)
Message-ID: <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-reply-to: <51262A7A.8040103@ti.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Linux@theia.denx.de, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 21 Feb 2013, Tom Rini wrote:

> FIT isn't required.  FIT is just trying to offer a nice usability
> thing to folks.

Usability is often counter-balanced by maintenance costs.

> A point of device trees is a single image works in a
> lot of places.  FIT gives you a single file works in a lot of places.

The whole _point_ for bringing DT into the ARM land was to decouple the 
the various platform specific stuff from the kernel, and even allow 
existing distros to work on yet-to-be-created devices unchanged, just 
like X86 PC class machines.  Now you're suggesting that the kernel and 
the DT information should be glued together again.  That looks like a 
move backward to me.  Yet, having that platform stuff in plain C code as 
we had before, given it is maintained properly, is still the most 
efficient way to achieve that usability wise.

So let's stop kidding ourselves and be coherent please: either we move 
device specifics away from the kernel, or we keep them together.  In 
other words, the DT should ideally come preinstalled with the bootloader 
on a given board/device for distros to not even have to care about it, 
or we put that data back inside the kernel and dispense ourselves from 
all the added DT overhead entirely.  But an hybrid mixed solution like 
FIT is IMHO the worst of both worlds and sending a wrong message.

> > uboot dug _itself_ into this hole.  It's uboot's problem.
> 
> A whole lot  of people dug this particular hole.  Joel is trying to
> offer up a solution that maybe makes things easier for everyone.  Or
> it gets rejected here too and distros will come up with their N
> different ways to try and provide easier experiences to the end user.

Nothing being perfect, it is probably unreasonable to think that every 
board will start shipping with complete and correct DT description, etc.  
But so is the state of FIT support right now.  That solution to make 
things easier for everyone should actually make that DT vs kernel 
separation more effective and provide better mechanisms for gluing the 
various DTBs to their respective boards, and not to glue them to the 
kernel to populate a distro filesystem with them.


Nicolas
