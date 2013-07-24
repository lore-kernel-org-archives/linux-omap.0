From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Wed, 24 Jul 2013 15:52:38 +0100
Message-ID: <20130724145237.GB21614@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38454 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab3GXOw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 10:52:57 -0400
Content-Disposition: inline
In-Reply-To: <51EFE1DD.8070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 24, 2013 at 10:17:01AM -0400, Santosh Shilimkar wrote:
> On Wednesday 24 July 2013 09:56 AM, Will Deacon wrote:
> > On Tue, Jul 23, 2013 at 10:05:17AM +0100, Rajendra Nayak wrote:
> >> On Tuesday 23 July 2013 12:37 PM, Paul Walmsley wrote:
> >>> Hi Rajendra,
> >>>
> >>> On Tue, 23 Jul 2013, Rajendra Nayak wrote:
> >>>
> >>>> On Tuesday 23 July 2013 01:37 AM, Paul Walmsley wrote:
> >>>>> On Mon, 22 Jul 2013, Russell King - ARM Linux wrote:
> >>>>>
> >>>>>> Bear in mind that I'm almost at the point of not boot-testing anything
> >>>>>> I sent to Linus because of the uselessness of the SDP4430 board now
> >>>>>> that it's DT only - the only platform which boot-tests anything I send
> >>>>>> is the 3430LDP board now.  If people care about that, maybe they can
> >>>>>> assist with sorting out the issues I've raised on these lists about
> >>>>>> the SDP4430 - and why the SDP4430 build remains disabled in my build
> >>>>>> and boot system.
> >>>>>
> >>>>> I understand completely...
> >>>>>
> >>>>>> Looking at the boot log, it just stops after uboot hands over control.
> >>>>>> With the lack of output from the decompressor, it's not possible to
> >>>>>> tell whether it's a decompressor problem or a kernel problem.
> >>>>>>
> >>>>>> I think you need to turn on the LL_DEBUG option, select the appropriate
> >>>>>> output option, and also get the decompressor to use the kernel's debug
> >>>>>> io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).
> >>>>>
> >>>>> OK, will dig deeper here at the next opportunity.
> >>>>
> >>>> Paul, I can take a look at the 4430sdp issue. Are you also seeing this also on
> >>>> 2430sdp as the subject says, or was that a typo?
> >>>
> >>> Thanks for the offer.  The issue that I'm seeing is on the 2430SDP in my 
> >>> testbed.
> >>>
> >>> I don't have a 4430SDP, so you might consider touching base with rmk for 
> >>> that one.
> >>
> >> So I tried commit 'fb2af00' on the 4430SDP and it did boot fine, though I see
> >> the below errors. (I am using the mainline bootloaders which do not lock any
> >> additional DPLLs like USB)
> > 
> > Any update on this? If it's an issue introduced by architectural changes,
> > I'd really like to bisect it down but I don't have a board.
> > 
> >From the other thread, RMK did manage to get the board booting finally
> (uImage related issues, low level debug problem) but with DT only supported
> build, the audio and DSS was not at same state as before(non-DT build).
> And then Tony pointed the issues to Peter and Tomy to address it further.
> 
> Russell,
> Is above right or I am missing something ?

Will is referring to the 2430 issues I think; the original topic of this
thread.

I've not enabled the 4430 again in the build system because I see no point
to it - it can't find its rootfs because the device numbering for the MMC/SD
cards has reversed itself.  Not only does that need the kernel command line
changed, but it also needs fixing in the fstab on the SD card rootfs, and
quite frankly I really can't be bothered at the moment with this kind of
pointless boot breaking churn.

I also continue to be disappointed by the lack of things working on the
4430 - it's been a number of years now and _still_ the on-board LCDs do
not work.  People have tried to blame that on hardware faults and the
like, but they're just being idiotic when they say stuff like that.  It
can't be hardware faults when the kernel supplied with the board is able
to make them work to the extent that userspace can play back video on all
three output devices simultaneously, without hiccup or any imperfection.
I don't know whether it's just that the backlight support isn't working
or what - because any information on the 4430 seems to be a tightly
controlled secret that only a few select people are permitted to know
about.  As far as I'm concerned, much of the hardware is a black box to
me.

And yes, my 4430 has the projector module on it.  Never ever seen that
work, and no idea how to make it work because there's no information
available on the hardware.

It's a bit like the useless 3430LDP - though there's information available
there's no way to work out which of the many different designs of 3430LDP
the one I have ties up with, and I'm pretty sure that all the published
revisions of the circuits for the 3430LDP do not match the version I have
here - which means when things go wrong, there's no way for me to look
at stuff.

And no, I don't want another Beagle board or Panda board or whatever, I
have those (I think I have one of each), and they've never been powered up
because they have no ethernet on them, and I have no USB to ethernet still,
partly because I don't really do USB here *at* *all*, so I don't know what
works well and what doesn't with Linux.  Even if I did provide them with a
USB ethernet, I doubt they'd be able to boot a kernel via the network.

My experience of USB is hellishly poor - I have an icybox eSATA enclosure
which also provides USB.  The USB interface on that regularly drops out
with errors, timeouts, and even isn't recognised on many occasions.  I
see slow serial comms with USB serial devices on platforms like the
4430SDP and Dove Cubox - the speed is very much like a 4800baud modem, even
though the serial runs at 115200 baud.  No, don't even _think_ about blaming
the host, because this happens whether it be a Thinkpad, or the USB hosts
in a Thecus N2100.

I can believe why this all happens, when you see USB interrupts taking
upwards of 3ms to complete:

Longest time: 3247506ns
Longest irq: 24
Longest handler: usb_hcd_irq+0x0/0x68

is it hardly surprising that USB is soo crap?  And the above 3ms is just
for handling a USB keyboard - what takes 3ms over servicing a USB keyboard?
I mean, what crap USB really is when it behaves like that... and is it
no wonder I hate the bloody thing.

Anyway, this is getting off topic. :)
