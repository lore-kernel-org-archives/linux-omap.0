From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Fri, 21 Mar 2014 10:10:30 -0700
Message-ID: <20140321171029.GC3842@atomide.com>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
 <20140321013729.GC29691@saruman.home>
 <20140321023646.GB17404@kroah.com>
 <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
 <20140321025238.GA31610@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140321025238.GA31610@saruman.home>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [140320 19:57]:
> On Thu, Mar 20, 2014 at 09:45:42PM -0500, Robert Nelson wrote:
> > On Thu, Mar 20, 2014 at 9:36 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Mar 20, 2014 at 08:37:29PM -0500, Felipe Balbi wrote:
> > >> On Thu, Mar 20, 2014 at 08:35:57PM -0500, Felipe Balbi wrote:
> > >> > Hi,
> > >> >
> > >> > On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
> > >> > > On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
> > >> > > > Hi folks,
> > >> > > >
> > >> > > > I've been toying with the idea of removing
> > >> > > > drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> > >> > > > ungly copy of 8250 driver.
> > >> > > >
> > >> > > > The original concern was wrt suspend/resume but I think it'd be a far
> > >> > > > better approach to implement runtime PM in 8250 and write a rather small
> > >> > > > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> > >> > > > OMAP-specific details out of the way.
> > >> > > >
> > >> > > > The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
> > >> > > > instead of ttyS\d so removing omap-serial.c would have a direct impact
> > >> > > > in userland. I wonder if it's an acceptable "regression" considering
> > >> > > > we'd be able to reuse 8250 gaining proper Flow Control support, proper
> > >> > > > DMA support, years and years of bug-fixes, etc.
> > >> > >
> > >> > > Breaking device node names is a contentious issue for serial ports, I
> > >> > > don't think you can do that :(
> > >> >
> > >> > would an upstream udev rule creating a symbolic link from ttyO to ttyS
> > >> > be enough ?
> > >> >
> > >> > I didn't test this yet but I guess this is enough (?)
> > >> >
> > >> > KERNEL=="ttyO[0-9]", GROUP="dialout", SYMLINK+="ttyS"
> > >>
> > >> or actually it should be to other way around, ttyS would be the real
> > >> device:
> > >>
> > >> KERNEL=="ttyS[0-9]", GROUP="dialout", SYMLINK+="ttyO"
> > >
> > > As udev rules don't ship with the kernel, this might be tough to do :(
> > >
> > > Might be easier to make the 8250 driver handle different "names" like
> > > Alan said.
> 
> I'll see if I find a way to avoid that or at least see if we find any
> other way of creating a symlink... In any case, just switching back to
> 8250, even if just maintaining ttyO name, is already a big benefit.
> 
> > On the support side, I'm not looking forward to this for beagle/panda
> > users.  We've already converted them once from ttySx -> ttyOx back in
> > 2.6.33/2.6.34? days.  That was an irc/email/u-boot/kernel nightmare...
> 
> that's exactly why we're talking about ways to maintain backwards
> compatibility here. But I'm more interested in finding a way to switch
> over to ttyS and have a symlink to ttyO, that way a simple debootstrap
> (or any other ARM distro minimal rootfs) would work out of the box,
> without any changes, just like in "normal" systems.

Yeah let's not break things. The symlink solution won't work for kernel
console output so it needs to be dealt with some other way.

It seems that the biggest amount of work is making existing 8250
support the missing features in a clean way and without breaking
other platforms. Looks like 8250_dw.c has some pm_runtime_calls so
obviously it's doable.

Regards,

Tony
