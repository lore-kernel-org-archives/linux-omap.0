From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP4430 SDP boot issues.. (Was Re: OMAP2430 SDP boot broken
 after Linus' rmk merge)
Date: Wed, 24 Jul 2013 14:17:07 -0400
Message-ID: <51F01A23.2060502@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk> <51EFF571.3070106@ti.com> <20130724172321.GC21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58099 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130Ab3GXSRq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jul 2013 14:17:46 -0400
In-Reply-To: <20130724172321.GC21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Balaji T Krishnamoorthy <balajitk@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Wednesday 24 July 2013 01:23 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 24, 2013 at 11:40:33AM -0400, Santosh Shilimkar wrote:
>> On Wednesday 24 July 2013 10:52 AM, Russell King - ARM Linux wrote:
>>> I also continue to be disappointed by the lack of things working on the
>>> 4430 - it's been a number of years now and _still_ the on-board LCDs do
>>> not work.  People have tried to blame that on hardware faults and the
>>> like, but they're just being idiotic when they say stuff like that.  It
>>> can't be hardware faults when the kernel supplied with the board is able
>>> to make them work to the extent that userspace can play back video on all
>>> three output devices simultaneously, without hiccup or any imperfection.
>>> I don't know whether it's just that the backlight support isn't working
>>> or what - because any information on the 4430 seems to be a tightly
>>> controlled secret that only a few select people are permitted to know
>>> about.  As far as I'm concerned, much of the hardware is a black box to
>>> me.
>>>
>> On the display related issues, Tomi and Archit have been sorting out
>> issue but am not sure about the current state. If the pre-built binaries
>> video playback works means your hardware seems to be fine.
> 
> Just let me be absolutely crystal clear about this: the on-board LCDs
> have _never_ worked with a mainline kernel, but they did work with the
> kernel which originally came with the board with the original 4430 SoC.
> I can right now put the original 4430 SoC back on the board and boot
> using the kernel which is still on the SD card and they will work.
> 
> Even with the original 4430 SoC and mainline kernels, they have never
> worked.
> 
> I tried it back and forth several times, but even with this, the
> explanation was always "your hardware must be faulty".  And then the wrong
> voltage levels was found which was preventing the LCD modules from even
> being recognised... but still, no sign of life on the LCD panels.
> 
> It may be that there's some error in the kernel configuration I'm building.
> I don't know, because I have _no_ idea what hardware is involved in
> bringing the LCDs online.  Like I said above, the 4430SDP board is just
> a black box.  I am totally reliant on others telling me what the right
> config options are supposed to be and fixing problems when things don't
> work.
> 
> With the lack of information on this board, all I can do when things don't
> work is whinge and moan at people.  I am powerless to debug the problems
> myself, even if they're a simple misconfiguration.
> 
> Is there information available on the 4430SDP?  Is there any reason I
> can't have access to it?
> 
I haven't come across the information which is available on the web.
Let me check if there are schematics which i can send across to
you.

Regards,
Santosh



