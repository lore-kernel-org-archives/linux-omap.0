From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: OMAP4430 SDP boot issues.. (Was Re: OMAP2430 SDP boot broken after
 Linus' rmk merge)
Date: Wed, 24 Jul 2013 11:40:33 -0400
Message-ID: <51EFF571.3070106@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51001 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab3GXPlI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jul 2013 11:41:08 -0400
In-Reply-To: <20130724145237.GB21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Balaji T Krishnamoorthy <balajitk@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Wednesday 24 July 2013 10:52 AM, Russell King - ARM Linux wrote:
> On Wed, Jul 24, 2013 at 10:17:01AM -0400, Santosh Shilimkar wrote:
>> On Wednesday 24 July 2013 09:56 AM, Will Deacon wrote:
>>> On Tue, Jul 23, 2013 at 10:05:17AM +0100, Rajendra Nayak wrote:
>>>> On Tuesday 23 July 2013 12:37 PM, Paul Walmsley wrote:

[..]

>>>>> I don't have a 4430SDP, so you might consider touching base with rmk for 
>>>>> that one.
>>>>
>>>> So I tried commit 'fb2af00' on the 4430SDP and it did boot fine, though I see
>>>> the below errors. (I am using the mainline bootloaders which do not lock any
>>>> additional DPLLs like USB)
>>>
>>> Any update on this? If it's an issue introduced by architectural changes,
>>> I'd really like to bisect it down but I don't have a board.
>>>
>> >From the other thread, RMK did manage to get the board booting finally
>> (uImage related issues, low level debug problem) but with DT only supported
>> build, the audio and DSS was not at same state as before(non-DT build).
>> And then Tony pointed the issues to Peter and Tomy to address it further.
>>
>> Russell,
>> Is above right or I am missing something ?
> 
> Will is referring to the 2430 issues I think; the original topic of this
> thread.
>
We crossed the emails. Am just renaming the thread since below summary is
still important for OMAP4430SDP.
 
> I've not enabled the 4430 again in the build system because I see no point
> to it - it can't find its rootfs because the device numbering for the MMC/SD
> cards has reversed itself.  Not only does that need the kernel command line
> changed, but it also needs fixing in the fstab on the SD card rootfs, and
> quite frankly I really can't be bothered at the moment with this kind of
> pointless boot breaking churn.
>
The MMC slot change has also troubled us in past in downstream kernel. Am
looping Balaji to see if he can fix it to restore the original ordering.
 
> I also continue to be disappointed by the lack of things working on the
> 4430 - it's been a number of years now and _still_ the on-board LCDs do
> not work.  People have tried to blame that on hardware faults and the
> like, but they're just being idiotic when they say stuff like that.  It
> can't be hardware faults when the kernel supplied with the board is able
> to make them work to the extent that userspace can play back video on all
> three output devices simultaneously, without hiccup or any imperfection.
> I don't know whether it's just that the backlight support isn't working
> or what - because any information on the 4430 seems to be a tightly
> controlled secret that only a few select people are permitted to know
> about.  As far as I'm concerned, much of the hardware is a black box to
> me.
> 
On the display related issues, Tomi and Archit have been sorting out
issue but am not sure about the current state. If the pre-built binaries
video playback works means your hardware seems to be fine.

> And yes, my 4430 has the projector module on it.  Never ever seen that
> work, and no idea how to make it work because there's no information
> available on the hardware.
> 
I think you mean the Pico DLP module. There was a downstream driver but
am not sure about the state. Archit, Tomi should be able to comment.

> It's a bit like the useless 3430LDP - though there's information available
> there's no way to work out which of the many different designs of 3430LDP
> the one I have ties up with, and I'm pretty sure that all the published
> revisions of the circuits for the 3430LDP do not match the version I have
> here - which means when things go wrong, there's no way for me to look
> at stuff.
> 
> And no, I don't want another Beagle board or Panda board or whatever, I
> have those (I think I have one of each), and they've never been powered up
> because they have no ethernet on them, and I have no USB to ethernet still,
> partly because I don't really do USB here *at* *all*, so I don't know what
> works well and what doesn't with Linux.  Even if I did provide them with a
> USB ethernet, I doubt they'd be able to boot a kernel via the network.
>
We discussed the LDP issue in past. That board is almost dead since almost
no one from TI is using/having it anymore.
 
> My experience of USB is hellishly poor - I have an icybox eSATA enclosure
> which also provides USB.  The USB interface on that regularly drops out
> with errors, timeouts, and even isn't recognised on many occasions.  I
> see slow serial comms with USB serial devices on platforms like the
> 4430SDP and Dove Cubox - the speed is very much like a 4800baud modem, even
> though the serial runs at 115200 baud.  No, don't even _think_ about blaming
> the host, because this happens whether it be a Thinkpad, or the USB hosts
> in a Thecus N2100.
> 
> I can believe why this all happens, when you see USB interrupts taking
> upwards of 3ms to complete:
> 
> Longest time: 3247506ns
> Longest irq: 24
> Longest handler: usb_hcd_irq+0x0/0x68
> 
> is it hardly surprising that USB is soo crap?  And the above 3ms is just
> for handling a USB keyboard - what takes 3ms over servicing a USB keyboard?
> I mean, what crap USB really is when it behaves like that... and is it
> no wonder I hate the bloody thing.
> 
Felipe might be able to comment better on the above USB topic.

Regards,
Santosh


