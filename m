From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 14:21:15 -0500 (EST)
Message-ID: <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-reply-to: <51265BF1.5000302@ti.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Linux@theia.denx.de, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 21 Feb 2013, Tom Rini wrote:

> On 02/21/2013 12:25 PM, Nicolas Pitre wrote:
> > On Thu, 21 Feb 2013, Tom Rini wrote:
> [snip]
> >>> uboot dug _itself_ into this hole.  It's uboot's problem.
> >> 
> >> A whole lot  of people dug this particular hole.  Joel is trying
> >> to offer up a solution that maybe makes things easier for
> >> everyone.  Or it gets rejected here too and distros will come up
> >> with their N different ways to try and provide easier experiences
> >> to the end user.
> > 
> > Nothing being perfect, it is probably unreasonable to think that
> > every board will start shipping with complete and correct DT
> > description, etc. But so is the state of FIT support right now.
> > That solution to make things easier for everyone should actually
> > make that DT vs kernel separation more effective and provide better
> > mechanisms for gluing the various DTBs to their respective boards,
> > and not to glue them to the kernel to populate a distro filesystem
> > with them.
> 
> I very much agree here.  And in the end, what I really really want to
> avoid is every distribution (or similar grouping of stuff) coming up
> with N different ways to solve the problem of "how do I get the user
> the right device tree to go with $whatever board they happen to be
> running".

DT installation must be outside of the distribution's responsibilities.  
It should be the OEM's responsibility, just like BIOS updates for PCs 
which don't come from Fedora/Debian/Ubuntu.  Obviously, having the dts 
files in the kernel tree does confuse people in that regard, but that 
must not deter people from doing the right thing.

> If the clever solution everyone comes up with is some other container 
> that's not FIT, that's fine, patches welcome and happily reviewed for 
> whatever the solution is.  I just don't want people thinking this is a 
> problem that hasn't been thought of before.

Ideally, there should be no such containers.  You should simply pick any 
kernel, or install your distro of choice, and run that on any "DT ready" 
hardware. A distro could list the minimum version of a DTB some 
particular boards were tested with, just like they sometimes do for some 
PC BIOSes.  That said, maybe some provision for DTB versioning would be 
a good idea if not done already.


Nicolas
