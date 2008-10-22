From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Thu, 23 Oct 2008 00:40:10 +0300
Message-ID: <94a0d4530810221440t653ed446p3d2838716e353332@mail.gmail.com>
References: <20081021045809.GJ7341@atomide.com>
	 <94a0d4530810211309w28188181rcb8b1b881588ec87@mail.gmail.com>
	 <20081021203700.GP7341@atomide.com>
	 <94a0d4530810211434t5708978ftd1f409c7e4c93d12@mail.gmail.com>
	 <20081021220216.GQ7341@atomide.com>
	 <94a0d4530810220746j54d5e275q253192a0c7c07d7f@mail.gmail.com>
	 <e5e6ade50810221430u111bcafeo3a4c4a96a87b8b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:6226 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992AbYJVVke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 17:40:34 -0400
Received: by ey-out-2122.google.com with SMTP id 6so4679eyi.37
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 14:40:11 -0700 (PDT)
In-Reply-To: <e5e6ade50810221430u111bcafeo3a4c4a96a87b8b0c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, lauri.leukkunen@nokia.com, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Rick Bronson <rick@efn.org>

On Thu, Oct 23, 2008 at 12:30 AM, Nathan Monson <nmonson@gmail.com> wrote:
> On Wed, Oct 22, 2008 at 7:46 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I've reverted the strongly ordered patch and I'm not getting any IRQ
>> issues with any DSP tests, including the ping one.
>>
>> I'm using the latest patches from Hiroshi (20081021), so maybe that
>> has something to do with it?
>
> I've also reverted the strongly ordered patch.  While I can't do
> anything that freezes the kernel anymore, I can still cause two kinds
> of endless interrupts on Angstrom:
>
> 1) About 1 in 10 boots generates these messages endlessly:
>
> __ratelimit: 1518265 callbacks suppressed
> omapfb omapfb: irq error status 4000
> omapfb omapfb: irq error status 4022
>
> Tony sent me some debug code which shows the register values when this occurs:
> XXX 95mask: 0xffffffdf 95 0x3ffffff
> XXX 95ack: 0xffffffdf 95 0x3ffffff
>
> This can be triggered even without the DSP patches.
>
> Before Tony's latest work, this would just spiral out into irq -33s
> and kill the kernel.  Now it just slows things down, which is a good
> improvement.
>
> I can't reproduce this with the S-O patch.
>
> 2) I still get spurious interrupts while running the DSP ping.out
> test, but they are also handled better.  No slow down occurs.
> However, I can get endless interrupts  by unplugging/replugging my USB
> hub.  Again, the endless interrupts slow things down a lot, but no
> longer kill the system like before.
>
> I can't reproduce this with the S-O patch.
>
> Let me know if there are further patches worth testing without S-O.
> For now, I'm back to S-O to allow me to keep working.

Which DSP patches are you using?

I haven't been able to reproduce this with Tony's irq mask patch,
latest DSP patches, and removing S-O patch.

-- 
Felipe Contreras
