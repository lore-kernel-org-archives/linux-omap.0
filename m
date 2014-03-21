From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Thu, 20 Mar 2014 21:45:42 -0500
Message-ID: <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
References: <20140320235210.GB26964@saruman.home>
	<20140321001228.GA18131@kroah.com>
	<20140321013557.GB29691@saruman.home>
	<20140321013729.GC29691@saruman.home>
	<20140321023646.GB17404@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140321023646.GB17404@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 20, 2014 at 9:36 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 20, 2014 at 08:37:29PM -0500, Felipe Balbi wrote:
>> On Thu, Mar 20, 2014 at 08:35:57PM -0500, Felipe Balbi wrote:
>> > Hi,
>> >
>> > On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
>> > > On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
>> > > > Hi folks,
>> > > >
>> > > > I've been toying with the idea of removing
>> > > > drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
>> > > > ungly copy of 8250 driver.
>> > > >
>> > > > The original concern was wrt suspend/resume but I think it'd be a far
>> > > > better approach to implement runtime PM in 8250 and write a rather small
>> > > > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
>> > > > OMAP-specific details out of the way.
>> > > >
>> > > > The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
>> > > > instead of ttyS\d so removing omap-serial.c would have a direct impact
>> > > > in userland. I wonder if it's an acceptable "regression" considering
>> > > > we'd be able to reuse 8250 gaining proper Flow Control support, proper
>> > > > DMA support, years and years of bug-fixes, etc.
>> > >
>> > > Breaking device node names is a contentious issue for serial ports, I
>> > > don't think you can do that :(
>> >
>> > would an upstream udev rule creating a symbolic link from ttyO to ttyS
>> > be enough ?
>> >
>> > I didn't test this yet but I guess this is enough (?)
>> >
>> > KERNEL=="ttyO[0-9]", GROUP="dialout", SYMLINK+="ttyS"
>>
>> or actually it should be to other way around, ttyS would be the real
>> device:
>>
>> KERNEL=="ttyS[0-9]", GROUP="dialout", SYMLINK+="ttyO"
>
> As udev rules don't ship with the kernel, this might be tough to do :(
>
> Might be easier to make the 8250 driver handle different "names" like
> Alan said.

On the support side, I'm not looking forward to this for beagle/panda
users.  We've already converted them once from ttySx -> ttyOx back in
2.6.33/2.6.34? days.  That was an irc/email/u-boot/kernel nightmare...

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
